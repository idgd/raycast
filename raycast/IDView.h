//
//  IDView.h
//  raycast
//
//  Created by Isaac Dudney on 8/4/14.
//  Copyright (c) 2014 Isaac Dudney. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IDRender;

@interface IDView : UIView

@property (nonatomic,copy) NSArray *renderPaths;
@property (nonatomic,copy) NSArray *enemyPaths;

@end