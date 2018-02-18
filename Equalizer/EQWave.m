//
//  EQWave.m
//  PhtcEqualizer
//
//  Created by phtc.prod on 22/06/2016.
//  Copyright © 2016 phonotonic. All rights reserved.
//

#import "EQWave.h"

@implementation EQWave

- (id)init {
    
    if (self = [super init]) {
        self.amplitude = 1;
    }
    return self;
}

- (id)initWithAmplitude:(float)a {
    
    if (self = [super init]) {
        self.amplitude = a;
    }
    return self;
}

- (float)getValue:(float)x time:(float)t withBPM:(float)bpm {
    
    return self.amplitude;
}

@end
