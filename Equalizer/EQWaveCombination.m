//
//  EQWaveCombination.m
//  PhtcEqualizer
//
//  Created by phtc.prod on 24/06/2016.
//  Copyright © 2016 phonotonic. All rights reserved.
//

#import "EQWaveCombination.h"

@interface EQWaveCombination()

@end

@implementation EQWaveCombination

- (id)initBySummingWave1:(EQWave*)w1 andWave2:(EQWave*)w2 {
    
    if (self = [super initWithAmplitude:1]) {
        self.wave1 = w1;
        self.wave2 = w2;
        self.operation = EQWaveSum;
    }
    return self;
}

- (id)initByMultiplyingWave1:(EQWave*)w1 andWave2:(EQWave*)w2 {
    
    if (self = [super initWithAmplitude:1]) {
        self.wave1 = w1;
        self.wave2 = w2;
        self.operation = EQWaveProduct;
    }
    return self;
}

- (float)getValue:(float)x time:(float)t withBPM:(float)bpm {
    
    if (self.operation == EQWaveSum) {
        return self.amplitude * ([self.wave1 getValue:x time:t withBPM:bpm] + [self.wave2 getValue:x time:t withBPM:bpm]);
    } else if (self.operation == EQWaveProduct) {
        return self.amplitude * ([self.wave1 getValue:x time:t withBPM:bpm] * [self.wave2 getValue:x time:t withBPM:bpm]);
    }
    return 0;
}

@end
