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
@class IDEnemy;

@interface IDRender : NSObject

@property (nonatomic,strong) IDCamera *player;
@property (nonatomic,strong) NSMutableArray *renderLines;
@property (nonatomic,strong) NSMutableArray *enemies;
@property (nonatomic,copy) NSArray *blocks;
@property (nonatomic,copy) NSArray *enemyBlocks;

- (void)gak;
- (void)calculateLines;

@end
