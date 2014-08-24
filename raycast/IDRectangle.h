//
//  IDRectangle.h
//  raycast
//
//  Created by Isaac Dudney on 8/4/14.
//  Copyright (c) 2014 Isaac Dudney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@class IDLine;
@class IDRay;

@interface IDRectangle : NSObject

@property (nonatomic) CGPoint a;
@property (nonatomic) CGPoint b;
@property (nonatomic) CGPoint c;
@property (nonatomic) CGPoint d;

- (BOOL)containsPoint:(CGPoint)point;
- (CGPoint)intersectionWithPoint:(IDLine *)one flag:(BOOL *)flag;

- (CGPoint)intersectionWithRay:(IDRay *)ray flag:(BOOL *)flag whichLine:(IDLine **)linePtr;

@end
