//
//  IDLine.m
//  raycast
//
//  Created by Isaac Dudney on 8/4/14.
//  Copyright (c) 2014 Isaac Dudney. All rights reserved.
//

#import "IDLine.h"
#import <UIKit/UIKit.h>
@implementation IDLine

- (NSString *)description
{
	return [NSString stringWithFormat:@"start = %@ end = %@", NSStringFromCGPoint(self.start), NSStringFromCGPoint(self.end)];
}

- (CGFloat)deltaY {
	return self.end.y - self.start.y;
}

- (CGFloat)deltaX {
	return self.end.x - self.start.x;
}

- (CGFloat)slope {
	
	CGFloat slope = MAXFLOAT;
	
	if (fabs([self deltaX]) >= 0.0001) {
		slope = [self deltaY] / [self deltaX];
	}
	
	return slope;
}

- (CGFloat)intercept {
	return -(self.start.x * [self slope]);
}

- (CGPoint)intersectionPoint:(IDLine *)otherLine intersects:(BOOL *)flag {
	
	CGFloat thisSlope = [self slope];
	CGFloat otherSlope = [otherLine slope];
	CGFloat thisIntercept = [self intercept];
	CGFloat otherIntercept = [self intercept];
	
	CGFloat interceptX;
	CGFloat interceptY;
	
	// y1 = m1x1 + b1
	// y2 = m1x2 + b2
	// y2 == y1 && x1 == x2
	// y = m1x + b1
	// y = m2x + b2
	// m1x + b1 = m2x + b2
	// b2 - b1 = m1x - m2x
	// b2 - b1 = x(m1 - m2)
	// x = (b2 - b1) / (m1 - m2)
	// y = m1 ((b2 - b1) / (m1 - m2)) + b2
	
	if (otherSlope >= MAXFLOAT - 1 ||
			otherSlope <= -MAXFLOAT + 1) {
		
		interceptX = otherLine.start.x;
		interceptY = thisSlope * otherLine.start.x + thisIntercept;
		
	} else if (thisSlope >= MAXFLOAT - 1 ||
						 thisSlope <= -MAXFLOAT + 1) {
		
		interceptX = (thisIntercept - otherIntercept) /
		(otherSlope - thisSlope);
		
		interceptY = (otherSlope * thisIntercept - thisSlope * otherIntercept) /
		(otherSlope - thisSlope);
		
	} else {
		
		interceptX = (otherIntercept - thisIntercept) / (thisSlope - otherSlope);
		interceptY = thisSlope * ((otherIntercept - thisIntercept) / (thisSlope - otherSlope) + otherIntercept);
		
	}
	
	CGPoint foo = CGPointMake(interceptX, interceptY);
	
	CGFloat minX = MIN(self.start.x, self.end.x);
	CGFloat minY = MIN(self.start.y, self.end.y);
	CGFloat maxX = MAX(self.start.x, self.end.x);
	CGFloat maxY = MAX(self.start.y, self.end.y);
	
	CGRect boundingBox = CGRectMake(minX, minY, maxX - minX, maxY - minY);
	
	BOOL lag = CGRectContainsPoint(boundingBox, foo);
	
	if (!lag) {
		foo = CGPointMake(0, 0);
	}
	if (flag) {
		*flag = lag;
	}
	return foo;
	
}

@end
