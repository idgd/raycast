//
//  IDRay.m
//  raycast
//
//  Created by Isaac Dudney on 8/4/14.
//  Copyright (c) 2014 Isaac Dudney. All rights reserved.
//

#import "IDRay.h"
#import <UIKit/UIKit.h>

@interface IDRay ()

@property (nonatomic, readwrite) CGFloat intercept;
@property (nonatomic) BOOL interceptSet;
@property (nonatomic, readwrite) CGFloat slope;
@property (nonatomic) BOOL slopeSet;

@end

@implementation IDRay

- (CGFloat)intercept {
  if(!_interceptSet) {
    // y = mx + b
    // y - mx = b
    _intercept = self.origin.y - (self.origin.x * self.direction.y / self.direction.x);
    _interceptSet = YES;
  }
  return _intercept;
}

- (CGFloat)slope {
  if(!_slopeSet) {
    _slope = self.direction.y / self.direction.x;
    _slopeSet = YES;
  }
  return _slope;
}

- (NSString *)description {
  return [NSString stringWithFormat:@"start = %@ slope = %@", NSStringFromCGPoint(self.origin), NSStringFromCGPoint(self.direction)];
}

@end
