//
//  IDRay.m
//  raycast
//
//  Created by Isaac Dudney on 8/4/14.
//  Copyright (c) 2014 Isaac Dudney. All rights reserved.
//

#import "IDRay.h"
#import <UIKit/UIKit.h>

@implementation IDRay

- (CGFloat)intercept {
  // y = mx + b
  // y - mx = b
  return self.origin.y - (self.origin.x * self.direction.y / self.direction.x);
}

- (CGFloat)slope {
  return self.direction.y / self.direction.x;
}

- (NSString *)description {
  return [NSString stringWithFormat:@"start = %@ slope = %@", NSStringFromCGPoint(self.origin), NSStringFromCGPoint(self.direction)];
}

@end
