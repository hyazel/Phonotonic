//
//  EQController.h
//  PhtcEqualizer
//
//  Created by phtc.prod on 29/06/2016.
//  Copyright © 2016 phonotonic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EQView.h"
#import "MBSensor.h"

@interface EQController : NSObject

@property (strong, nonatomic) EQView *equalizerView;
@property (strong, nonatomic) NSDate *firstBeat;

- (id)initWithView:(EQView*)view;

- (void)bindSensor:(MBSensor*)sensor;
- (void)bindAllSensors;
- (void)unbindAllSensors;

- (void)start;
- (void)clip:(int)i;
- (void)stop;

@end
