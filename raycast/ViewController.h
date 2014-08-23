//
//  ViewController.h
//  raycast
//
//  Created by Isaac Dudney on 8/4/14.
//  Copyright (c) 2014 Isaac Dudney. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IDRender;
@class IDTicker;
@class IDRectangle;
@class IDRay;
@class IDCamera;

@interface ViewController : UIViewController

@property (strong,nonatomic) IDRender *map;
@property (strong,nonatomic) IDTicker *tick;
@property (nonatomic) UIPanGestureRecognizer *tapGR;
@property (nonatomic) CGPoint translation;
@property (nonatomic) CGPoint location;

@end

