//
//  EQWaveTransition.h
//  PhtcEqualizer
//
//  Created by phtc.prod on 28/06/2016.
//  Copyright © 2016 phonotonic. All rights reserved.
//

#import "EQWave.h"

@interface EQWaveTransition : EQWave

- (id)initWithWave:(EQWave*)w;

- (void)startNewTransitionTo:(EQWave*)w withSteps:(int)n;

- (void)progress;

@end
