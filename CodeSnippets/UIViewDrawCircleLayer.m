//Draw a circle inside a UIView
- (void)drawCircleLayer:(UIView *)view
{
	UIBezierPath *path = [UIBezierPath bezierPath];
	[path addArcWithCenter:CGPointMake(view.frame.size.width/2, view.frame.size.height/2)
					radius:view.frame.size.width/2
				startAngle:0.0
				  endAngle:M_PI * 2.0
				 clockwise:YES];
	
	CAShapeLayer *shapeLayer = [CAShapeLayer layer];
	shapeLayer.path = [path CGPath];
	shapeLayer.fillColor = [[UIColor clearColor] CGColor];
	shapeLayer.strokeColor = [[UIColor colorWithRed:0.1 green:0.73 blue:0.6 alpha:1] CGColor];
	
	[view.layer addSublayer:shapeLayer];
}
