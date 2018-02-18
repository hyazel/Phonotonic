//
//  EQControllerWithPlayback
//  PhtcEqualizer
//
//  Created by phtc.prod on 11/07/2016.
//  Copyright © 2016 phonotonic. All rights reserved.
//

#import "EQController.h"

@interface EQControllerWithPlayback : EQController

@property (strong, nonatomic) NSDictionary* recording;

@property BOOL playRandom;

@end
