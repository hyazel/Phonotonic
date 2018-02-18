//
//  EQADSRWave.m
//  PhtcEqualizer
//
//  Created by phtc.prod on 23/06/2016.
//  Copyright © 2016 phonotonic. All rights reserved.
//

#import "EQADSRWave.h"

@implementation EQADSRWave

- (id)initWithOscillationsPerBeat:(float)n andOffset:(float)o andAttack:(float)a andAttackGain:(float)g andDecay:(float)d andSustain:(float)s andRelease:(float)r {
    
    if (self = [super initWithAmplitude:1]) {
        self.oscillationsPerBeat = n;
        self.offset = o;
        self.attack = a;
        self.attackGain = g;
        self.decay = d;
        self.sustain = s;
        self.rel = r;
    }
    return self;
}

- (float)getValue:(float)x time:(float)t withBPM:(float)bpm {
    
    float period = 60.0 / (self.oscillationsPerBeat*bpm);
    float u = t/period - self.offset - ceil(t/period - self.offset) + 1;
    
    if (u < self.attack) {
        float ampIni = [self getValue:x time:self.offset*period withBPM:bpm];
        return self.amplitude * [self cosInterpolationBetweenX0:0 Y0:ampIni andX1:self.attack Y1:self.attackGain at:u];
    } else if (u < self.attack + self.decay) {
        return self.amplitude * [self cosInterpolationBetweenX0:self.attack Y0:self.attackGain andX1:self.attack+self.decay Y1:1 at:u];
    } else if (u < self.attack + self.decay + self.sustain) {
        return self.amplitude;
    } else if (u < self.attack + self.decay + self.sustain + self.rel) {
        return self.amplitude * [self cosInterpolationBetweenX0:self.attack+self.decay+self.sustain Y0:1 andX1: self.attack+self.decay+self.sustain+self.rel Y1:0 at:u];
    } else {
        return 0;
    }
}

- (float)cosInterpolationBetweenX0:(float)x0 Y0:(float)y0 andX1:(float)x1 Y1:(float)y1 at:(float)x {
    
    return y0+(y1-y0)*0.5*(1 - cos(M_PI*(x-x0)/(x1-x0)));
}

@end
