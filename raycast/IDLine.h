//
//  IDLine.h
//  raycast
//
//  Created by Isaac Dudney on 8/4/14.
//  Copyright (c) 2014 Isaac Dudney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@class IDRay;

@interface IDLine : NSObject

@property (nonatomic) CGPoint start;
@property (nonatomic) CGPoint end;
@property (nonatomic, readonly) CGFloat slope;
@property (nonatomic, readonly) CGFloat intercept;

// returns the intersection point, if it intersects
// if it does not intersect CGPointZero is returned
// flag will specify if an intersection exists
- (CGPoint)intersectionPointWithLine:(IDLine *)otherLine intersects:(BOOL *)flag;

// returns the intersection point, if it intersects
// if it does not intersect CGPointZero is returned
// flag will specify if an intersection exists
- (CGPoint)intersectionPointWithRay:(IDRay *)ray intersects:(BOOL *)flag;

@end
