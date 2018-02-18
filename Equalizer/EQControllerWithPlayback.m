//
//  EQControllerWithPlayback.m
//  PhtcEqualizer
//
//  Created by phtc.prod on 11/07/2016.
//  Copyright © 2016 phonotonic. All rights reserved.
//

#import "EQControllerWithPlayback.h"

static float const EQDefaultPlaybackTimeInterval = 0.5;

@interface EQControllerWithPlayback() {
    NSTimer *playTimer;
    int position;
    NSDate *startTime;
    NSTimeInterval timeIntervalBetweenPauseAndStart;
}

@end

@implementation EQControllerWithPlayback

- (void)start {
    
    if (self.recording == nil && !self.playRandom) {
        return;
    }
    [super start];
    startTime = [NSDate dateWithTimeInterval:-timeIntervalBetweenPauseAndStart sinceDate:[NSDate date]];
    [self play];
}

- (void)play {
    
    if (self.playRandom) {
        [super clip:arc4random_uniform(6)];
        playTimer = [NSTimer scheduledTimerWithTimeInterval:EQDefaultPlaybackTimeInterval target:self selector:@selector(play) userInfo:nil repeats:NO];
        return;
    }
    
    [super clip:[[[self.recording objectForKey:@"clip"] objectAtIndex:position] intValue]];
    position++;
    float timeInterval = [[[self.recording objectForKey:@"time"] objectAtIndex:position] floatValue] - [[NSDate date] timeIntervalSinceDate:startTime];
    playTimer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(play) userInfo:nil repeats:NO];
}

- (void)pause {
    
    timeIntervalBetweenPauseAndStart = [[NSDate date] timeIntervalSinceDate:startTime];
    [super stop];
    [playTimer invalidate];
    playTimer = nil;
    position--;
}

- (void)stop {
    
    [super stop];
    [playTimer invalidate];
    playTimer = nil;
    position = 0;
    startTime = nil;
    timeIntervalBetweenPauseAndStart = 0;
}

- (void)setRecording:(NSDictionary *)recording {
    
    _recording = recording;
    if ([[[self.recording objectForKey:@"time"] firstObject] floatValue] != 0) {
        [[self.recording objectForKey:@"time"] insertObject:[NSNumber numberWithFloat:0] atIndex:0];
        [[self.recording objectForKey:@"clip"] insertObject:[NSNumber numberWithInt:0] atIndex:0];
    }
}

@end
