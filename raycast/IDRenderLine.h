//
//  IDRenderLine.h
//  raycast
//
//  Created by Isaac Dudney on 8/19/14.
//  Copyright (c) 2014 Isaac Dudney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IDRenderLine : NSObject

@property(nonatomic) UIBezierPath *renderLine;
@property(nonatomic) CGFloat depth;
@property(nonatomic, strong) UIColor *color;

@end
