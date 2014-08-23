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

- (BOOL)containsPoint:(CGPoint)point {
	
	CGRect blorp = CGRectMake(MIN(self.a.x,self.c.x),
														MIN(self.a.y,self.c.y),
														fabs(MIN(self.a.x, self.c.x) -
																 MAX(self.a.x, self.c.x)),
														fabs(MIN(self.a.y, self.c.y) -
																 MAX(self.a.y, self.c.y)));
	
	//NSLog(@"%@,%@",NSStringFromCGPoint(blorp.origin),NSStringFromCGSize(blorp.size));
	
	return CGRectContainsPoint(blorp, point);
	
}

- (CGPoint) intersectionWithPoint:(IDLine *)one flag:(BOOL *)flag {
	
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
	
	NSArray *lines = @[AB,BC,CD,DA];
	
	CGPoint foo = CGPointMake(0, 0);
	
	for (IDLine *line in lines) {
		
		BOOL boop = NO;
		foo = [line intersectionPoint:one intersects:&boop];
		
		if (boop) {
			if (flag) {
				*flag = boop;
			}
			break;
		}
		
	}
	
	return foo;
	
}

@end
