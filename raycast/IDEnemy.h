//
//  IDEnemy.h
//  raycast
//
//  Created by Isaac Dudney on 8/23/14.
//  Copyright (c) 2014 Isaac Dudney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@interface IDEnemy : NSObject

@property (nonatomic) CGPoint enemyOrigin;
@property (nonatomic) CGFloat enemyWidth;
@property (nonatomic) UIBezierPath* enemyPath;

@end
