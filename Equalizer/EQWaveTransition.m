//
//  EQWaveTransition.m
//  PhtcEqualizer
//
//  Created by phtc.prod on 28/06/2016.
//  Copyright © 2016 phonotonic. All rights reserved.
//

#import "EQWaveTransition.h"

@interface EQWaveTransition() {
    EQWave *startWave;
    EQWave *endWave;
    int currentStep;
    int numberOfSteps;
}

@end

@implementation EQWaveTransition

- (id)initWithWave:(EQWave*)w {
    
    if (self = [super initWithAmplitude:1]) {
        startWave = nil;
        endWave = w;
        currentStep = 1;
        numberOfSteps = 1;
    }
    return self;
}

- (id)copy {
    
    EQWaveTransition *copy = [[EQWaveTransition alloc] initWithWave:startWave];
    [copy startNewTransitionTo:endWave withSteps:numberOfSteps];
    for (int i = 0; i < currentStep; i++) {
        [copy progress];
    }
    return copy;
}

- (void)startNewTransitionTo:(EQWave*)w withSteps:(int)n {
    
    // if the transition was finished
    if (currentStep == numberOfSteps) {
        startWave = endWave;
    } else {
        startWave = [self copy];
    }
    endWave = w;
    currentStep = 0;
    numberOfSteps = n;
}

- (void)progress {
    if (currentStep < numberOfSteps) {
        currentStep++;
    } else {
        startWave = nil;
    }
}

- (void)generateNoise {
    
    //[startWave generateNoise];
    //[endWave generateNoise];
}

- (float)getValue:(float)x time:(float)t withBPM:(float)bpm {

    if (currentStep == numberOfSteps) {
        return [endWave getValue:x time:t withBPM:bpm];
    }
    float u = 0.5*(1 + cos(M_PI * currentStep / numberOfSteps));
    return self.amplitude * (u * [startWave getValue:x time:t withBPM:bpm] + (1-u) * [endWave getValue:x time:t withBPM:bpm]);
}

@end
