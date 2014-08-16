//
//  FLWaveView.m
//  flood
//
//  Created by Justin Poliachik on 5/23/14.
//  Copyright (c) 2014 justinpoliachik. All rights reserved.
//

#import "FLWaveView.h"

@interface FLWaveView()
@property (strong, nonatomic) UIColor *fillColor;
@end

@implementation FLWaveView

- (id)initWithFrame:(CGRect)frame withColor:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _fillColor = color;
        
        // default properties
        _waveLength = 200.f;
        _waveHeight = 50.f;
        
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

// draws a series of waves
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path setLineCapStyle:kCGLineCapRound];
    [path setLineJoinStyle:kCGLineJoinRound];
    
    // start at x = 0, y = half height
    [path moveToPoint:CGPointMake(0, self.waveHeight/2)];
    
    int iterations = rect.size.width / self.waveLength;
    for(int i = 0; i < iterations; i++){
        CGFloat newX = self.waveLength * (i + 1);
        CGFloat midX = newX - (self.waveLength/2);
        [path addCurveToPoint:CGPointMake(newX, self.waveHeight/2) controlPoint1:CGPointMake(midX, self.waveHeight) controlPoint2:CGPointMake(midX, 0)];

    }
    
    // now we should be on the right side of the view
    [path addLineToPoint:CGPointMake(rect.size.width, rect.size.height)]; //bottom right
    [path addLineToPoint:CGPointMake(0, rect.size.height)]; //bottom left
    [path closePath];
    
    CGContextAddPath(context, path.CGPath);
    
    if(self.fillColor){
        [self.fillColor set];
    }else{
        [[UIColor whiteColor] set];
    }
    
    CGContextFillPath(context);
}


@end
