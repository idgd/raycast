//
//  IDRay.h
//  raycast
//
//  Created by Isaac Dudney on 8/4/14.
//  Copyright (c) 2014 Isaac Dudney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface IDRay : NSObject

@property (nonatomic) CGPoint origin;
@property (nonatomic) CGPoint direction;
@property (nonatomic, readonly) CGFloat intercept;
@property (nonatomic, readonly) CGFloat slope;

@end
