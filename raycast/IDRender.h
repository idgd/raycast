//
//  IDRender.h
//  raycast
//
//  Created by Isaac Dudney on 8/4/14.
//  Copyright (c) 2014 Isaac Dudney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class IDRectangle;
@class IDRay;
@class IDCamera;
@class IDLine;

@interface IDRender : NSObject

@property (nonatomic,strong) IDCamera *player;
@property (nonatomic,strong) NSMutableArray *renderLines;
@property (nonatomic,copy) NSArray *blocks;

- (void)calculateLines;

@end
