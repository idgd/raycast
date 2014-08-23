//
//  IDRectangle.m
//  raycast
//
//  Created by Isaac Dudney on 8/4/14.
//  Copyright (c) 2014 Isaac Dudney. All rights reserved.
//

#import "IDRectangle.h"
#import <UIKit/UIKit.h>

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

@end
