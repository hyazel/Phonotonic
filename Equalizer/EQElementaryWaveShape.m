//
//  EQElementaryWaveShape.m
//  PhtcEqualizer
//
//  Created by phtc.prod on 24/06/2016.
//  Copyright © 2016 phonotonic. All rights reserved.
//

#import "EQElementaryWaveShape.h"

@implementation EQElementaryWaveShape

- (id)initWithAmplitude:(float)a andCenter:(float)c andQualityFactor:(float)q {
    
    if (self = [super initWithAmplitude:a]) {
        self.center = c;
        self.q = q;
    }
    return self;
}

- (float)getValue:(float)x time:(float)t withBPM:(float)bpm {
    
    float frac = 2 * (x-self.center) * self.q;
    if (frac >= 1 || frac <= -1) {
        return 0;
    }
    return self.amplitude * 0.5 * (1 + cos(M_PI * frac));
}

@end