//
//  IDLine.m
//  raycast
//
//  Created by Isaac Dudney on 8/4/14.
//  Copyright (c) 2014 Isaac Dudney. All rights reserved.
//

#import "IDLine.h"
#import <UIKit/UIKit.h>
#import "IDRay.h"

@interface IDLine ()

@property (nonatomic, readwrite) CGFloat slope;
@property (nonatomic) BOOL slopeSet;
@property (nonatomic, readwrite) CGFloat intercept;
@property (nonatomic) BOOL interceptSet;

@end

@implementation IDLine

- (NSString *)description {
	return [NSString stringWithFormat:@"start = %@ end = %@", NSStringFromCGPoint(self.start), NSStringFromCGPoint(self.end)];
}

- (CGFloat)deltaY {
	return self.end.y - self.start.y;
}

- (CGFloat)deltaX {
	return self.end.x - self.start.x;
}

- (CGFloat)slope {
  if(!_slopeSet) {
    
    CGFloat slope = MAXFLOAT;
    
    if (fabs([self deltaX]) >= 0.0001) {
      slope = [self deltaY] / [self deltaX];
    }
    _slope = slope;
    _slopeSet = YES;
  }
	return _slope;
}

- (CGFloat)intercept {
  if(!_interceptSet) {
    // y = mx + b
    // y - mx = b
    _intercept = self.start.y - (self.start.x * [self slope]);
    _interceptSet = YES;
  }
  return _intercept;
}

- (CGPoint)intersectionPointWithRay:(IDRay *)ray intersects:(BOOL *)flag {
  CGFloat thisSlope = [self slope];
  CGFloat raySlope = [ray slope];
  CGFloat thisIntercept = [self intercept];
  CGFloat rayIntercept = [ray intercept];
  
  // don't intercept if parallel, even if on top of each other
  // that would make for a bogus drawing
  if(raySlope == thisSlope) {
    if(flag) {
      *flag = NO;
    }
    return CGPointZero;
  }
  
  CGFloat interceptX;
  CGFloat interceptY;
  
  if (thisSlope >= MAXFLOAT - 1.0 ||
      thisSlope <= -MAXFLOAT + 1.0) {
    
    interceptX = self.start.x;
    interceptY = raySlope * self.start.x + rayIntercept;
    
  } else if (raySlope >= MAXFLOAT - 1.0 ||
             raySlope <= -MAXFLOAT + 1.0) {
    
    interceptX = ray.origin.x;
    interceptY = thisSlope * ray.origin.x + thisIntercept;
    
  } else {
    
    interceptX = (rayIntercept - thisIntercept) / (thisSlope - raySlope);
    interceptY = (thisSlope * rayIntercept - raySlope * thisIntercept) / (thisSlope - raySlope);
    
  }
  
  
  // check if the intersection point is on the line segment
  if(interceptX > MAX(self.start.x, self.end.x) + 0.01 ||
     interceptX < MIN(self.start.x, self.end.x) - 0.01 ||
     interceptY > MAX(self.start.y, self.end.y) + 0.01 ||
     interceptY < MIN(self.start.y, self.end.y) - 0.01) {
    if(flag) {
      *flag = NO;
    }
    return CGPointZero;
  }
  
  // check if the intersection point is on the ray
  CGFloat dot = ray.direction.x * (interceptX - ray.origin.x) +
                ray.direction.y * (interceptY - ray.origin.y);
  
  if(dot <= 0.0){
    if(flag) {
      *flag = NO;
    }
    return CGPointZero;
  }
  
  CGPoint foo = CGPointMake(interceptX, interceptY);
  
  if(flag) {
    *flag = YES;
  }
  
  return foo;
}

- (CGPoint)intersectionPointWithLine:(IDLine *)otherLine intersects:(BOOL *)flag {
  
	CGFloat thisSlope = [self slope];
	CGFloat otherSlope = [otherLine slope];
	CGFloat thisIntercept = [self intercept];
	CGFloat otherIntercept = [otherLine intercept];
	
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
	
	if (otherSlope >= MAXFLOAT - 1.0 ||
			otherSlope <= -MAXFLOAT + 1.0) {
		
		interceptX = otherLine.start.x;
		interceptY = thisSlope * otherLine.start.x + thisIntercept;
		
	} else if (thisSlope >= MAXFLOAT - 1.0 ||
						 thisSlope <= -MAXFLOAT + 1.0) {
		
		interceptX = self.start.x;
		
		interceptY = otherSlope * self.start.x + otherIntercept;
		
	} else {
		
		interceptX = (otherIntercept - thisIntercept) / (thisSlope - otherSlope);
		interceptY = (thisSlope * otherIntercept - otherSlope * thisIntercept) / (thisSlope - otherSlope);
		
	}
	
	CGPoint foo = CGPointMake(interceptX, interceptY);
	
  CGFloat bias = 0.01;
  
  CGFloat minSelfX = MIN(self.start.x, self.end.x) - bias;
  CGFloat minSelfY = MIN(self.start.y, self.end.y) - bias;
  CGFloat maxSelfX = MAX(self.start.x, self.end.x) + bias;
  CGFloat maxSelfY = MAX(self.start.y, self.end.y) + bias;

  CGFloat minOtherX = MIN(otherLine.start.x, otherLine.end.x) - bias;
  CGFloat minOtherY = MIN(otherLine.start.y, otherLine.end.y) - bias;
  CGFloat maxOtherX = MAX(otherLine.start.x, otherLine.end.x) + bias;
  CGFloat maxOtherY = MAX(otherLine.start.y, otherLine.end.y) + bias;

  if ((interceptX <= maxSelfX && interceptX >= minSelfX) &&
      (interceptY <= maxSelfY && interceptY >= minSelfY) &&
      (interceptX <= maxOtherX && interceptX >= minOtherX) &&
      (interceptY <= maxOtherY && interceptY >= minOtherY)) {
    if(flag) {
      *flag = YES;
			
    }
		
  } else {
		
    foo = CGPointMake(0.0, 0.0);
		
  }
	
	return foo;
}

@end
