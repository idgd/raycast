//
//  IDRectangle.m
//  raycast
//
//  Created by Isaac Dudney on 8/4/14.
//  Copyright (c) 2014 Isaac Dudney. All rights reserved.
//

#import "IDRectangle.h"
#import <UIKit/UIKit.h>

#import "IDLine.h"

@implementation IDRectangle

- (CGRect)boundingBox {
  CGFloat minX = MIN(MIN(MIN(self.a.x, self.b.x), self.c.x), self.d.x);
  CGFloat minY = MIN(MIN(MIN(self.a.y, self.b.y), self.c.y), self.d.y);
  CGFloat maxX = MAX(MAX(MAX(self.a.x, self.b.x), self.c.x), self.d.x);
  CGFloat maxY = MAX(MAX(MAX(self.a.y, self.b.y), self.c.y), self.d.y);
  return CGRectMake(minX, minY, maxX - minX, maxY - minY);
}

- (BOOL)containsPoint:(CGPoint)point {
  return CGRectContainsPoint([self boundingBox], point);
	
}

- (NSArray *)lines {
  IDLine *AB = [[IDLine alloc]init];
  AB.start = self.a;
  AB.end = self.b;
  
  IDLine *BC = [[IDLine alloc]init];
  BC.start = self.b;
  BC.end = self.c;
  
  IDLine *CD = [[IDLine alloc]init];
  CD.start = self.c;
  CD.end = self.d;
  
  IDLine *DA = [[IDLine alloc]init];
  DA.start = self.d;
  DA.end = self.a;
  
  return @[AB, BC, CD, DA];
}

- (CGPoint)intersectionWithRay:(IDRay *)ray flag:(BOOL *)flag {
  
  NSArray *lines = [self lines];
  CGPoint intersection = CGPointZero;
  
  for (IDLine *line in lines) {
    BOOL intercepts = NO;
    intersection = [line intersectionPointWithRay:ray intersects:&intercepts];
    if(intercepts) {
      if(flag) {
        *flag = YES;
      }
      break;
    }
  }
  return intersection;
}

- (CGPoint) intersectionWithPoint:(IDLine *)one flag:(BOOL *)flag {
	
  NSArray *lines = [self lines];
	
	CGPoint intersection = CGPointMake(0, 0);
	
	for (IDLine *line in lines) {
		
		BOOL intersects = NO;
		intersection = [line intersectionPointWithLine:one intersects:&intersects];
		
		if (intersects) {
			if (flag) {
				*flag = intersects;
			}
			break;
		}
		
	}
	
	return intersection;
  
}

- (NSString *)description {
  return [NSString stringWithFormat:@"{%@, %@, %@, %@}", NSStringFromCGPoint(self.a), NSStringFromCGPoint(self.b),
          NSStringFromCGPoint(self.c), NSStringFromCGPoint(self.d)];
}

@end
