//
//  IDCamera.h
//  raycast
//
//  Created by Isaac Dudney on 8/4/14.
//  Copyright (c) 2014 Isaac Dudney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface IDCamera : NSObject

@property (nonatomic) CGPoint POS;
@property (nonatomic) CGFloat ROT;
@property (nonatomic) CGFloat FOV;
@property (nonatomic) CGSize bounds;

@end
