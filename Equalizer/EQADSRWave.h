//
//  EQADSRWave.h
//  PhtcEqualizer
//
//  Created by phtc.prod on 23/06/2016.
//  Copyright © 2016 phonotonic. All rights reserved.
//

#import "EQWave.h"

@interface EQADSRWave : EQWave

@property float oscillationsPerBeat;
@property float offset;
@property float attack;
@property float attackGain;
@property float decay;
@property float sustain;
@property float rel;

- (id)initWithOscillationsPerBeat:(float)n andOffset:(float)o andAttack:(float)a andAttackGain:(float)g andDecay:(float)d andSustain:(float)s andRelease:(float)r;

@end
