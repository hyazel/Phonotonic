//
//  EQView.h
//  PhtcEqualizer
//
//  Created by Dekhil Mazen on 27/05/16.
//  Copyright © 2016 Phonotonic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EQWave.h"

@interface EQView : UIView

- (id)initWithView:(UIImageView*)v andDotSize:(int)s andDistanceBetweenDots:(int)d andWaveHeight:(float)hmax andGradient:(int)g;

- (void)displayWave:(EQWave*)wave time:(double)t withBPM:(float)bpm;
- (void)hideWave;

- (void)setGradient:(int)g;

- (void)linkView:(UIImageView*)v;
- (void)unlinkViews;

@end
