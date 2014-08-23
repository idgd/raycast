//
//  IDLine.h
//  raycast
//
//  Created by Isaac Dudney on 8/4/14.
//  Copyright (c) 2014 Isaac Dudney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface IDLine : NSObject

@property (nonatomic) CGPoint start;
@property (nonatomic) CGPoint end;

- (CGPoint)intersectionPoint:(IDLine *)otherLine intersects:(BOOL *)flag;

@property (nonatomic) CGFloat M;
@property (nonatomic) CGFloat B;

@end
