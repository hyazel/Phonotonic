//
//  EQElementaryWaveShape.h
//  PhtcEqualizer
//
//  Created by phtc.prod on 24/06/2016.
//  Copyright © 2016 phonotonic. All rights reserved.
//

#import "EQWave.h"

@interface EQElementaryWaveShape : EQWave

@property float center;
@property float q;

- (id)initWithAmplitude:(float)a andCenter:(float)c andQualityFactor:(float)q;

@end