//
//  EQPerlinNoise.h
//  PhtcEqualizer
//
//  Created by phtc.prod on 24/06/2016.
//  Copyright © 2016 phonotonic. All rights reserved.
//

#import "EQWave.h"

@interface EQPerlinNoise : EQWave

- (id)initWithSeed:(int)seed andFrequency:(float)f andOctaves:(int)n andPersistence:(float)p andAmplitude:(float)amp;

@property int seed;
@property float frequency;
@property int octaves;
@property float persistence;

@end
