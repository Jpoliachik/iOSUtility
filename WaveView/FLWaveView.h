//
//  FLWaveView.h
//  flood
//
//  Created by Justin Poliachik on 5/23/14.
//  Copyright (c) 2014 justinpoliachik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLWaveView : UIView

/**
 *  Specify the approximate wave height
 *  Does not accurately measure the waveheight, only where the control points
 *  of the UIBezierPath path should be
 */
@property (nonatomic, assign) CGFloat waveHeight;

/**
 *  Specify the exact length of each wave
 *  Used to specify how many repetitions are needed to fill the view
 *  NOTE: When lining up adjacent wave views, specify a waveLength that is evenly
 *  a divisor of the view width. This will ensure the waves line up evenly.
 */
@property (nonatomic, assign) CGFloat waveLength;

/**
 *  init with frame and fill color
 *  pass in the fill color to be drawn below the wave path
 *
 *  @param frame view bounding frame
 *  @param color fill color of the wave
 *
 *  @return self
 */
- (id)initWithFrame:(CGRect)frame withColor:(UIColor *)color;

@end
