//Public method layerForIconWithFrame
//Returns a filled CAShapeLayer that can be added as a UIView.layer sublayer
//Params
//frame - CGRect of the container to hold the icon. The icon will be sized to fit the frame. 
//color - UIColor to fill the icon with. 
- (CAShapeLayer *)layerForIconWithFrame:(CGRect)frame andColor:(UIColor *)color
{
	UIBezierPath *path = [self pathForCalendarIcon];
	CAShapeLayer *scaledLayer = [self scaledLayerForPath:path inBoundingFrame:frame];
	scaledLayer.fillColor = [color CGColor];
	return scaledLayer;
}

//Private method pathForIcon
//Returns a single UIBezierPath of the drawn object. Unfilled. Unsized.
- (UIBezierPath *)pathForIcon
{
  //Bezier Drawing
	UIBezierPath* bezierPath = [UIBezierPath bezierPath];
	[bezierPath moveToPoint: CGPointMake(24, 5.33)];
	[bezierPath addLineToPoint: CGPointMake(24, 21.33)];
	[bezierPath addCurveToPoint: CGPointMake(21.33, 24) controlPoint1: CGPointMake(24, 22.78) controlPoint2: CGPointMake(22.83, 24)];
	[bezierPath addLineToPoint: CGPointMake(2.67, 24)];
	[bezierPath addCurveToPoint: CGPointMake(0, 21.33) controlPoint1: CGPointMake(1.23, 24) controlPoint2: CGPointMake(0, 22.78)];
	[bezierPath addLineToPoint: CGPointMake(0, 5.33)];
	[bezierPath addCurveToPoint: CGPointMake(2.67, 2.67) controlPoint1: CGPointMake(0, 3.84) controlPoint2: CGPointMake(1.23, 2.67)];
	[bezierPath addLineToPoint: CGPointMake(3.9, 2.67)];
	[bezierPath addLineToPoint: CGPointMake(3.9, 5.33)];
	[bezierPath addLineToPoint: CGPointMake(8.16, 5.33)];
	[bezierPath addLineToPoint: CGPointMake(8.16, 2.67)];
	[bezierPath addLineToPoint: CGPointMake(15.89, 2.67)];
	[bezierPath addLineToPoint: CGPointMake(15.89, 5.33)];
	[bezierPath addLineToPoint: CGPointMake(20.16, 5.33)];
	[bezierPath addLineToPoint: CGPointMake(20.16, 2.67)];
	[bezierPath addLineToPoint: CGPointMake(21.34, 2.67)];
	[bezierPath addCurveToPoint: CGPointMake(24, 5.33) controlPoint1: CGPointMake(22.83, 2.67) controlPoint2: CGPointMake(24, 3.84)];
	[bezierPath closePath];
	[bezierPath moveToPoint: CGPointMake(21.33, 10.67)];
	[bezierPath addLineToPoint: CGPointMake(2.67, 10.67)];
	[bezierPath addLineToPoint: CGPointMake(2.67, 21.33)];
	[bezierPath addLineToPoint: CGPointMake(21.33, 21.33)];
	[bezierPath addLineToPoint: CGPointMake(21.33, 10.67)];
	[bezierPath closePath];
	[bezierPath moveToPoint: CGPointMake(6.93, 4.53)];
	[bezierPath addLineToPoint: CGPointMake(5.07, 4.53)];
	[bezierPath addLineToPoint: CGPointMake(5.07, 0)];
	[bezierPath addLineToPoint: CGPointMake(6.93, 0)];
	[bezierPath addLineToPoint: CGPointMake(6.93, 4.53)];
	[bezierPath closePath];
	[bezierPath moveToPoint: CGPointMake(18.93, 4.53)];
	[bezierPath addLineToPoint: CGPointMake(17.07, 4.53)];
	[bezierPath addLineToPoint: CGPointMake(17.07, 0)];
	[bezierPath addLineToPoint: CGPointMake(18.93, 0)];
	[bezierPath addLineToPoint: CGPointMake(18.93, 4.53)];
	[bezierPath closePath];
	bezierPath.miterLimit = 4;
		
	return bezierPath;
}

//Private method scaledLayerForPath
//Params
//path - the UIBezierPath to scale. 
//frame - the frame size the UIBezierPath will be scaled to fit exactly. 
//Returns CAShapeLayer - the scaled drawing fitted inside the frame
- (CAShapeLayer *)scaledLayerForPath:(UIBezierPath *)path inBoundingFrame:(CGRect)frame
{
	//Initial shapeLayer
	CAShapeLayer *shapeLayer = [CAShapeLayer layer];
	shapeLayer.path = [path CGPath];
	
	CGRect boundingBox = CGPathGetBoundingBox(shapeLayer.path);
	CGFloat boundingBoxAspectRatio = CGRectGetWidth(boundingBox)/CGRectGetHeight(boundingBox);
	CGFloat viewAspectRatio = CGRectGetWidth(frame)/CGRectGetHeight(frame);
	
	//Calculate the scale factor
	CGFloat scaleFactor = 1.0;
	if (boundingBoxAspectRatio > viewAspectRatio) {
		// Width is limiting factor
		scaleFactor = CGRectGetWidth(frame)/CGRectGetWidth(boundingBox);
	} else {
		// Height is limiting factor
		scaleFactor = CGRectGetHeight(frame)/CGRectGetHeight(boundingBox);
	}
	
	
	CGAffineTransform scaleTransform = CGAffineTransformIdentity;
	// Scale down the path first
	scaleTransform = CGAffineTransformScale(scaleTransform, scaleFactor, scaleFactor);
	// Then translate the path to the upper left corner
	scaleTransform = CGAffineTransformTranslate(scaleTransform, -CGRectGetMinX(boundingBox), -CGRectGetMinY(boundingBox));
	
	// Center it in the bounding frame
	CGSize scaledSize = CGSizeApplyAffineTransform(boundingBox.size, CGAffineTransformMakeScale(scaleFactor, scaleFactor));
	CGSize centerOffset = CGSizeMake((CGRectGetWidth(frame)-scaledSize.width)/(scaleFactor*2.0),
									 (CGRectGetHeight(frame)-scaledSize.height)/(scaleFactor*2.0));
	scaleTransform = CGAffineTransformTranslate(scaleTransform, centerOffset.width, centerOffset.height);

	
	CGPathRef scaledPath = CGPathCreateCopyByTransformingPath(shapeLayer.path,
															  &scaleTransform);
	
	// Create a new shape layer and assign the new path
	CAShapeLayer *scaledShapeLayer = [CAShapeLayer layer];
	scaledShapeLayer.path = scaledPath;
	
	return scaledShapeLayer;
}
