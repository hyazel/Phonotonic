//
//  EQWaveCombination.h
//  PhtcEqualizer
//
//  Created by phtc.prod on 24/06/2016.
//  Copyright © 2016 phonotonic. All rights reserved.
//

#import "EQWave.h"

typedef NS_ENUM(NSInteger, EQWaveCombinationOperator) {
    EQWaveSum,
    EQWaveProduct
};

@interface EQWaveCombination : EQWave

@property EQWave *wave1;
@property EQWave *wave2;
@property EQWaveCombinationOperator operation;

- (id)initBySummingWave1:(EQWave*)w1 andWave2:(EQWave*)w2;
- (id)initByMultiplyingWave1:(EQWave*)w1 andWave2:(EQWave*)w2;

@end
