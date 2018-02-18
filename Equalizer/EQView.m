//
//  EQView.m
//  PhtcEqualizer
//
//  Created by Dekhil Mazen on 27/05/16.
//  Copyright © 2016 Phonotonic. All rights reserved.
//

#import "EQView.h"
#import "EQDesign.h"
#import "EQWave.h"

float scalingY = 0.75;

@interface EQView () {
    int numberOfDotsX;
    int numberOfDotsY;
    int dotSize;
    int distanceBetweenDots;
    NSMutableArray *imageViews;
}

@end

@implementation EQView

- (id)initWithView:(UIImageView*)v andDotSize:(int)s andDistanceBetweenDots:(int)d andWaveHeight:(float)hmax andGradient:(int)g {
    
    if (self = [super init]) {
        
        self.frame = CGRectMake(0, 2*d*(int)(v.frame.size.height*(1-hmax)/(2*d)), v.frame.size.width, v.frame.size.height - 2*d*(int)(v.frame.size.height*(1-hmax)/(2*d)));
        numberOfDotsX = self.frame.size.width / (scalingY*d);
        numberOfDotsY = self.frame.size.height / d;
        distanceBetweenDots = d;
        dotSize = s;
        imageViews = [NSMutableArray array];
        
        [self createBackground];
        [self createWave];
        [self setGradient:g];
        
        [self linkView:v];
    }
    
    return self;
}

- (void)createBackground {
    
    CALayer *backgroundLayer = [CALayer layer];
    backgroundLayer.frame = CGRectMake(0, 0, scalingY*2*distanceBetweenDots, 2*distanceBetweenDots);
    backgroundLayer.backgroundColor = [EQDesign getBackgroundColor].CGColor;
    
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    [circleLayer setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, dotSize, dotSize)] CGPath]];
    circleLayer.fillColor = [EQDesign getDotColor].CGColor;
    [backgroundLayer addSublayer:circleLayer];
    
    CAShapeLayer *circleLayer2 = [CAShapeLayer layer];
    [circleLayer2 setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(scalingY*distanceBetweenDots, distanceBetweenDots, dotSize, dotSize)] CGPath]];
    circleLayer2.fillColor = [EQDesign getDotColor].CGColor;
    [backgroundLayer addSublayer:circleLayer2];

    UIGraphicsBeginImageContextWithOptions(backgroundLayer.frame.size, self.opaque, 0.0);
    [backgroundLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage* backgroundImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    backgroundLayer = nil;
    
    self.layer.backgroundColor = [UIColor colorWithPatternImage:backgroundImage].CGColor;
}

- (void)createWave {
    
    for (int i = 0; i < numberOfDotsX; i++) {
        
        [self.layer addSublayer:[CALayer layer]];
    }
}

- (void)displayWave:(EQWave*)wave time:(double)t withBPM:(float)bpm {
    
    int i = 0;
    
    for (CALayer *column in self.layer.sublayers) {
        
        int r = numberOfDotsY * [wave getValue:(float)i/numberOfDotsX time:t withBPM:bpm] * distanceBetweenDots;
        // Stay in the view...
        r = MIN(r, self.frame.size.height);
        r = MAX(r, 0);
        
        column.frame = CGRectMake(scalingY*i*distanceBetweenDots, self.frame.size.height-r, scalingY*distanceBetweenDots, r);
        column.contentsRect = CGRectMake(0.5*((i+1)%2), 1-(float)r/self.frame.size.height, 0.5, (float)r/self.frame.size.height);
        i++;
    }
    
    [self updateView];
}

- (void)hideWave {
    
    int i = 0;
    
    for (CALayer *column in self.layer.sublayers) {
        
        column.frame = CGRectMake(scalingY*i*distanceBetweenDots, self.frame.size.height, scalingY*distanceBetweenDots, 0);
        i++;
    }
    
    [self updateView];
}


- (void)setGradient:(int)g {
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, scalingY*2*distanceBetweenDots, self.frame.size.height);
    gradientLayer.mask = [CALayer layer];
    
    for (int j = 0; j < numberOfDotsY; j++) {
        
        CAShapeLayer *circleLayer = [CAShapeLayer layer];
        [circleLayer setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(scalingY*((j+1)%2)*distanceBetweenDots, self.frame.size.height - (j-1)*distanceBetweenDots - dotSize, dotSize, dotSize)] CGPath]];
        circleLayer.fillColor = [UIColor colorWithWhite:1.0 alpha:1.0].CGColor;
        [gradientLayer.mask addSublayer:circleLayer];
    }
    
    NSDictionary *gradient = [EQDesign getGradient:g];
    
    gradientLayer.colors = (NSArray*)([gradient objectForKey:@"colors"]);
    gradientLayer.locations = (NSArray*)([gradient objectForKey:@"locations"]);
    
    UIGraphicsBeginImageContextWithOptions(gradientLayer.frame.size, self.opaque, 0.0);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *gradientImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    gradientLayer = nil;
    
    for (CALayer *column in self.layer.sublayers) {
        column.contents = (id)(gradientImage.CGImage);
    }
}

- (void)linkView:(UIImageView*)v {
    
    UIImageView *view = [[UIImageView alloc] initWithFrame:self.frame];
    [v addSubview:view];
    [imageViews addObject:view];
    
    v.layer.backgroundColor = self.layer.backgroundColor;
    UIGraphicsBeginImageContextWithOptions(v.frame.size, v.opaque, 0.0);
    [v.layer renderInContext:UIGraphicsGetCurrentContext()];
    v.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    v.layer.backgroundColor = [EQDesign getBackgroundColor].CGColor;
}

- (void)unlinkViews {
    
    for (UIImageView *v in imageViews) {
        [[v.subviews lastObject] removeFromSuperview];
    }
    [imageViews removeAllObjects];
}

- (void)updateView {
    
    UIGraphicsBeginImageContextWithOptions(self.frame.size, self.opaque, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    for (UIImageView *view in imageViews) {
        view.image = image;
    }
    UIGraphicsEndImageContext();
}

@end
