//
//  EQPerlinNoise.m
//  PhtcEqualizer
//
//  Created by phtc.prod on 24/06/2016.
//  Copyright © 2016 phonotonic. All rights reserved.
//

#import "EQPerlinNoise.h"

@interface EQPerlinNoise () {
    int functionSelector;
}

@end

@implementation EQPerlinNoise

- (id)initWithSeed:(int)seed andFrequency:(float)f andOctaves:(int)n andPersistence:(float)p andAmplitude:(float)amp {
    
    if ((self = [super initWithAmplitude:amp])) {
        self.seed = seed;
        self.frequency = f;
        self.octaves = n;
        self.persistence = p;
    }
    return self;
}

- (float)cosInterpolationBetweenValueA:(float)a valueB:(float)b valueX:(float)x {
    
    float ft = x * 3.1415927f;
    float f = (1 - (float)cos(ft)) * 0.5f;
    return a * (1 - f) + b * f;
}

- (float)makeNoise:(int)x time:(int)t {
    
    int n = x + t * 57;
    n = (n >> 13) ^  (n * functionSelector);
    n = (n * (n * n * (int)_seed + 19990303) + 1376312589) & RAND_MAX;
    return ( 1.0 - ( (n * (n * n * 15731 + 789221) + 1376312589) & RAND_MAX) / 1073741824.0);
}

- (float)smoothedNoise:(float)x time:(float)t {
    
    float corners = ([self makeNoise:x-1 time:t-1] + [self makeNoise:x+1 time:t-1] +
                     [self makeNoise:x-1 time:t+1] + [self makeNoise:x+1 time:t+1]) / 16;
    float sides = ([self makeNoise:x-1 time:t] + [self makeNoise:x+1 time:t] +
                   [self makeNoise:x time:t+1] + [self makeNoise:x time:t+1]) / 8;
    float center = [self makeNoise:x time:t] / 4;
    return corners + sides + center;
}

- (float)interpolatedNoise:(float)x time:(float)t {
    
    int integerX = (int)x;
    float fractionalX = x - integerX;
    int integerT = (int)t;
    float fractionalT = t - integerT;
    
    float v1 = [self smoothedNoise:integerX time:integerT];
    float v2 = [self smoothedNoise:integerX+1 time:integerT];
    float v3 = [self smoothedNoise:integerX time:integerT+1];
    float v4 = [self smoothedNoise:integerX+1 time:integerT+1];
    
    float i1 = [self cosInterpolationBetweenValueA:v1 valueB:v2 valueX:fractionalX];
    float i2 = [self cosInterpolationBetweenValueA:v3 valueB:v4 valueX:fractionalX];
    return [self cosInterpolationBetweenValueA:i1 valueB:i2 valueX:fractionalT];
}

- (float)getValue:(float)x time:(float)t withBPM:(float)bpm {
    
    functionSelector = 1;
    float value = 0;
    float persistence = 1;
    float frequency = _frequency;
    
    for (int i = 0; i < _octaves; i++) {
        value = value + [self interpolatedNoise:x * frequency time:t * frequency] * self.amplitude;
        persistence *= _persistence;
        frequency *= 2;
        functionSelector++;
    }
    
    if (_persistence == 1.0) {
        return value;
    }
     return value * (1 - _persistence) / (1 - persistence);
}

@end
