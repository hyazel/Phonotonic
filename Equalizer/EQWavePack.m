//
//  EQWavePack.m
//  PhtcEqualizer
//
//  Created by phtc.prod on 24/06/2016.
//  Copyright © 2016 phonotonic. All rights reserved.
//

#import "EQWavePack.h"
#import "EQADSRWave.h"
#import "EQElementaryWaveShape.h"
#import "EQPerlinNoise.h"
#import "EQWaveCombination.h"

@interface EQWavePack() {
    NSArray *waves;
}

@end

@implementation EQWavePack

- (id)init {
    
    if (self = [super init]) {
        waves = [NSArray arrayWithObjects:[EQWavePack createWave:0], [EQWavePack createWave:1], [EQWavePack createWave:2], [EQWavePack createWave:3], [EQWavePack createWave:4], [EQWavePack createWave:5], nil];
    }
    return self;
}

- (EQWave*)getWave:(int)i {
    
    return [waves objectAtIndex:i];
}

+ (EQWave*)createWave:(int)i {
    
    if (i==1) return [self createWave1];
    else if (i==2) return [self createWave2];
    else if (i==3) return [self createWave3];
    else if (i==4) return [self createWave4];
    else if (i==5) return [self createWave5];
    else return [self createWave0];
}

+ (EQWave*)createWave0 {
    
    return [[EQWave alloc] initWithAmplitude:0];
}

+ (EQWave*)createWave1 {
    
    EQADSRWave *tempWaveLeft = [[EQADSRWave alloc] initWithOscillationsPerBeat:0.5 andOffset:0 andAttack:0.2 andAttackGain:1.1 andDecay:0.1 andSustain:0 andRelease:0.7];
    EQElementaryWaveShape *freqWaveLeft = [[EQElementaryWaveShape alloc] initWithAmplitude:0.3 andCenter:0.3 andQualityFactor:1.4];
    EQWaveCombination *waveLeft = [[EQWaveCombination alloc] initByMultiplyingWave1:freqWaveLeft andWave2:tempWaveLeft];
    
    EQADSRWave *tempWaveRight = [[EQADSRWave alloc] initWithOscillationsPerBeat:0.5 andOffset:0.5 andAttack:0.2 andAttackGain:1.1 andDecay:0.1 andSustain:0 andRelease:0.7];
    EQElementaryWaveShape *freqWaveRight = [[EQElementaryWaveShape alloc] initWithAmplitude:0.3 andCenter:0.7 andQualityFactor:1.4];
    EQWaveCombination *waveRight = [[EQWaveCombination alloc] initByMultiplyingWave1:freqWaveRight andWave2:tempWaveRight];
    
    return [[EQWaveCombination alloc] initBySummingWave1:waveLeft andWave2:waveRight];
}

+ (EQWave*)createWave2 {
    
    EQPerlinNoise *noise = [[EQPerlinNoise alloc] initWithSeed:arc4random() andFrequency:8 andOctaves:2 andPersistence:0.9 andAmplitude:0.1];
    
    EQADSRWave *tempWaveLeft = [[EQADSRWave alloc] initWithOscillationsPerBeat:0.5 andOffset:0 andAttack:0.1 andAttackGain:1.2 andDecay:0.2 andSustain:0 andRelease:0.8];
    EQElementaryWaveShape *freqWaveLeft = [[EQElementaryWaveShape alloc] initWithAmplitude:0.5 andCenter:0.3 andQualityFactor:1.4];
    EQWaveCombination *waveLeft = [[EQWaveCombination alloc] initByMultiplyingWave1:freqWaveLeft andWave2:tempWaveLeft];
    
    EQADSRWave *tempWaveRight = [[EQADSRWave alloc] initWithOscillationsPerBeat:0.5 andOffset:0.5 andAttack:0.1 andAttackGain:1.2 andDecay:0.2 andSustain:0 andRelease:0.8];
    EQElementaryWaveShape *freqWaveRight = [[EQElementaryWaveShape alloc] initWithAmplitude:0.5 andCenter:0.7 andQualityFactor:1.4];
    EQWaveCombination *waveRight = [[EQWaveCombination alloc] initByMultiplyingWave1:freqWaveRight andWave2:tempWaveRight];
    
    EQWaveCombination *totalWave = [[EQWaveCombination alloc] initBySummingWave1:waveLeft andWave2:waveRight];
    return [[EQWaveCombination alloc] initBySummingWave1:noise andWave2:totalWave];
}

+ (EQWave*)createWave3 {
    
    EQPerlinNoise *noise = [[EQPerlinNoise alloc] initWithSeed:arc4random() andFrequency:16 andOctaves:4 andPersistence:0.9 andAmplitude:0.2];
    
    EQADSRWave *tempWaveLeft = [[EQADSRWave alloc] initWithOscillationsPerBeat:1 andOffset:0 andAttack:0.3 andAttackGain:1.2 andDecay:0.2 andSustain:0 andRelease:0.9];
    EQElementaryWaveShape *freqWaveLeft = [[EQElementaryWaveShape alloc] initWithAmplitude:0.7 andCenter:0.3 andQualityFactor:1.4];
    EQWaveCombination *waveLeft = [[EQWaveCombination alloc] initByMultiplyingWave1:freqWaveLeft andWave2:tempWaveLeft];
    
    EQADSRWave *tempWaveRight = [[EQADSRWave alloc] initWithOscillationsPerBeat:1 andOffset:0.5 andAttack:0.3 andAttackGain:1.2 andDecay:0.2 andSustain:0 andRelease:0.9];
    EQElementaryWaveShape *freqWaveRight = [[EQElementaryWaveShape alloc] initWithAmplitude:0.7 andCenter:0.7 andQualityFactor:1.4];
    EQWaveCombination *waveRight = [[EQWaveCombination alloc] initByMultiplyingWave1:freqWaveRight andWave2:tempWaveRight];
    
    EQWaveCombination *totalWave = [[EQWaveCombination alloc] initBySummingWave1:waveLeft andWave2:waveRight];
    return [[EQWaveCombination alloc] initBySummingWave1:noise andWave2:totalWave];
}

+ (EQWave*)createWave4 {
    
    EQPerlinNoise *noise = [[EQPerlinNoise alloc] initWithSeed:arc4random() andFrequency:4 andOctaves:6 andPersistence:0.8 andAmplitude:0.4];
    
    EQADSRWave *tempWaveLeft = [[EQADSRWave alloc] initWithOscillationsPerBeat:1 andOffset:0 andAttack:0.2 andAttackGain:1.2 andDecay:0.2 andSustain:0 andRelease:1];
    EQElementaryWaveShape *freqWaveLeft = [[EQElementaryWaveShape alloc] initWithAmplitude:0.8 andCenter:0.3 andQualityFactor:1.4];
    EQWaveCombination *waveLeft = [[EQWaveCombination alloc] initByMultiplyingWave1:freqWaveLeft andWave2:tempWaveLeft];
    
    EQADSRWave *tempWaveRight = [[EQADSRWave alloc] initWithOscillationsPerBeat:1 andOffset:0.5 andAttack:0.2 andAttackGain:1.2 andDecay:0.2 andSustain:0 andRelease:1];
    EQElementaryWaveShape *freqWaveRight = [[EQElementaryWaveShape alloc] initWithAmplitude:0.8 andCenter:0.7 andQualityFactor:1.4];
    EQWaveCombination *waveRight = [[EQWaveCombination alloc] initByMultiplyingWave1:freqWaveRight andWave2:tempWaveRight];
    
    EQWaveCombination *totalWave = [[EQWaveCombination alloc] initBySummingWave1:waveLeft andWave2:waveRight];
    return [[EQWaveCombination alloc] initBySummingWave1:noise andWave2:totalWave];
}

+ (EQWave*)createWave5 {
    
    EQPerlinNoise *noise = [[EQPerlinNoise alloc] initWithSeed:arc4random() andFrequency:16 andOctaves:8 andPersistence:0.2 andAmplitude:0.2];
    
    EQADSRWave *tempWave = [[EQADSRWave alloc] initWithOscillationsPerBeat:4 andOffset:0 andAttack:0.5 andAttackGain:1 andDecay:0 andSustain:0 andRelease:1.5];
    EQElementaryWaveShape *freqWave = [[EQElementaryWaveShape alloc] initWithAmplitude:0.9 andCenter:0.5 andQualityFactor:4];
    EQWaveCombination *wave = [[EQWaveCombination alloc] initByMultiplyingWave1:freqWave andWave2:tempWave];
    
    EQWave *one = [[EQWave alloc] initWithAmplitude:1];
    EQWave *onePlusNoise = [[EQWaveCombination alloc] initBySummingWave1:one andWave2:noise];
    
    return [[EQWaveCombination alloc] initByMultiplyingWave1:onePlusNoise andWave2:wave];
}


@end
