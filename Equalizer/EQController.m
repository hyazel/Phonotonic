//
//  EQController.m
//  PhtcEqualizer
//
//  Created by phtc.prod on 29/06/2016.
//  Copyright © 2016 phonotonic. All rights reserved.
//

#import "EQController.h"
#import "EQWavePack.h"
#import "EQWaveTransition.h"
#import "GlobalVars.h"
#import "PHTCMVData.h"

static int const EQFps = 25;
static float const EQTransitionTime = 0.5;
static float const EQDecayTime = 1.0;

GlobalVars *globals;

@interface EQController ()<MBSensorClip> {
    EQWavePack *wavePack;
    EQWaveTransition *wave;
    
    BOOL playing;
    int nextMove;
    
    NSTimer *transitionTimer;
    NSTimer *decayTimer;
}

@end

@implementation EQController

- (id)initWithView:(EQView*)view {
    
    if (self = [super init]) {
        
        self.equalizerView = view;
        globals = [GlobalVars sharedInstance];
        self.firstBeat = [[NSDate alloc] init];
        wavePack = [[EQWavePack alloc] init];
        wave = [[EQWaveTransition alloc] initWithWave:[wavePack getWave:1]];
    }
    return self;
}

-(void)GetClip:(int)c fromSensor:(MBSensor *)s{
    //NSLog(@"get clip %d",c);
    [self clip:c];
}

- (void)bindSensor:(MBSensor*)sensor {
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(makeUpdateClip:) name:@"updateclip" object:sensor];
    [sensor addDelegate:self];
    
}

- (void)bindAllSensors {
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(makeUpdateClip:) name:@"updateclip" object:nil];
    if([[[PHTCMVData sharedInstance] maPhonoConnected] count]>0)[[[[PHTCMVData sharedInstance] maPhonoConnected] objectAtIndex:0] addDelegate:self];
    if([[[PHTCMVData sharedInstance] maPhonoConnected] count]>1)[[[[PHTCMVData sharedInstance] maPhonoConnected] objectAtIndex:1] addDelegate:self];
}

- (void)unbindAllSensors {
    NSLog(@"unbindAllSensors");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"updateclip" object:nil];
}

- (void)start {
    
    if (playing) {
        return;
    }
    playing = YES;
    
    if (nextMove != 0) {
        [self clip:nextMove];
    }
}

- (void)makeUpdateClip:(NSNotification *)notification {
    
    
    int i = [[notification.userInfo objectForKey:@"clip"] intValue];
    [self clip:i];
    
   
}

- (void)clip:(int)i {
    
    if (!playing) {
        nextMove = i;
        return;
    }
    
    if (decayTimer != nil) {
        [decayTimer invalidate];
    }
    
    int steps = (i == 0) ? (int)(EQDecayTime * EQFps) : ((i == 5) ? (int)(EQTransitionTime * EQFps / 2) : (int)(EQTransitionTime * EQFps));
    [wave startNewTransitionTo:[wavePack getWave:i] withSteps:steps];
    
    if (transitionTimer == nil) {
        transitionTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/EQFps target:self selector:@selector(ticker) userInfo:nil repeats:YES];
    }
    if (i == 0) {
        decayTimer = [NSTimer scheduledTimerWithTimeInterval:EQDecayTime target:self selector:@selector(destroy) userInfo:nil repeats:NO];
    }
}

- (void)ticker {
    
    //[wave generateNoise];
    [self.equalizerView displayWave:wave time:[[transitionTimer fireDate] timeIntervalSinceDate:self.firstBeat]-[transitionTimer timeInterval] withBPM:globals.bpm];
    [wave progress];
}

- (void)destroy {
    
    [transitionTimer invalidate];
    transitionTimer = nil;
    [self.equalizerView hideWave];
}

- (void)stop {
    
    if (!playing) {
        return;
    }
    playing = NO;
    [self destroy];
}

- (void)dealloc {
    NSLog(@"Dealloc EQCOntroller");
    [self unbindAllSensors];
}
@end
