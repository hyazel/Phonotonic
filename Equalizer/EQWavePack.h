//
//  EQWavePack.h
//  PhtcEqualizer
//
//  Created by phtc.prod on 24/06/2016.
//  Copyright © 2016 phonotonic. All rights reserved.
//

#import "EQWave.h"

@interface EQWavePack : NSObject

- (id)init;
- (EQWave*)getWave:(int)i;
+ (EQWave*)createWave:(int)i;

@end
