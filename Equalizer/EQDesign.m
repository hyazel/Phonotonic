//
//  EQDesign.m
//  PhtcEqualizer
//
//  Created by phtc.prod on 28/06/2016.
//  Copyright © 2016 phonotonic. All rights reserved.
//

#import "EQDesign.h"

@implementation EQDesign

+ (UIColor*)getBackgroundColor {
    
    return [UIColor colorWithRed:11/255.0 green:19/255.0 blue:27/255.0 alpha:1];
}

+ (UIColor*)getDotColor {
    
    return [UIColor colorWithRed:6/255.0 green:29/255.0 blue:60/255.0 alpha:1];
}

+ (NSDictionary*)getGradient:(int)g {
    
    if (g == 0) {
        return @{
                 @"colors":[NSArray arrayWithObjects:
                                      (id)[UIColor colorWithRed:255/255.0 green:163/255.0 blue:148/255.0 alpha:1].CGColor,
                                      (id)[UIColor colorWithRed:255/255.0 green:40/255.0 blue:138/255.0 alpha:1].CGColor,
                                      (id)[UIColor colorWithRed:255/255.0 green:40/255.0 blue:138/255.0 alpha:1].CGColor,
                                      (id)[UIColor colorWithRed:55/255.0 green:116/255.0 blue:222/255.0 alpha:1].CGColor,
                                      nil],
                 @"locations":[NSArray arrayWithObjects:
                                         [NSNumber numberWithFloat:0.1],
                                         [NSNumber numberWithFloat:0.4],
                                         [NSNumber numberWithFloat:0.7],
                                         [NSNumber numberWithFloat:1.0],
                                         nil]
                 };
    } else if (g == 1) {
        return @{
                 @"colors":[NSArray arrayWithObjects:
                                      (id)[UIColor colorWithRed:255/255.0 green:144/255.0 blue:1/255.0 alpha:1].CGColor,
                                      (id)[UIColor colorWithRed:62/255.0 green:235/255.0 blue:15/255.0 alpha:1].CGColor,
                                      (id)[UIColor colorWithRed:255/255.0 green:26/255.0 blue:128/255.0 alpha:1].CGColor,
                                      nil],
                 @"locations":[NSArray arrayWithObjects:
                                         [NSNumber numberWithFloat:0.3],
                                         [NSNumber numberWithFloat:0.65],
                                         [NSNumber numberWithFloat:1.0],
                                         nil]
                 };
    } else if (g == 2) {
        return @{
                 @"colors":[NSArray arrayWithObjects:
                                      (id)[UIColor colorWithRed:2/255.0 green:198/255.0 blue:255/255.0 alpha:1].CGColor,
                                      (id)[UIColor colorWithRed:239/255.0 green:66/255.0 blue:126/255.0 alpha:1].CGColor,
                                      (id)[UIColor colorWithRed:255/255.0 green:148/255.0 blue:9/255.0 alpha:1].CGColor,
                                      nil],
                 @"locations":[NSArray arrayWithObjects:
                                         [NSNumber numberWithFloat:0.2],
                                         [NSNumber numberWithFloat:0.6],
                                         [NSNumber numberWithFloat:0.8],
                                         nil]
                 };
    } else if (g == 3) {
        return @{
                 @"colors":[NSArray arrayWithObjects:
                                      (id)[UIColor colorWithRed:255/255.0 green:42/255.0 blue:137/255.0 alpha:1].CGColor,
                                      (id)[UIColor colorWithRed:5/255.0 green:235/255.0 blue:219/255.0 alpha:1].CGColor,
                                      (id)[UIColor colorWithRed:102/255.0 green:0/255.0 blue:255/255.0 alpha:1].CGColor,
                                      nil],
                 @"locations":[NSArray arrayWithObjects:
                                         [NSNumber numberWithFloat:0.2],
                                         [NSNumber numberWithFloat:0.6],
                                         [NSNumber numberWithFloat:0.9],
                                         nil]
                 };
    } else {
        return nil;
    }
}

@end