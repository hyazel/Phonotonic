//
//  EQWave.h
//  PhtcEqualizer
//
//  Created by phtc.prod on 22/06/2016.
//  Copyright © 2016 phonotonic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EQWave : NSObject

@property float amplitude;

- (id)init;
- (id)initWithAmplitude:(float)a;

- (float)getValue:(float)x time:(float)t withBPM:(float)bpm;

@end