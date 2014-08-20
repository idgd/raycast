//
//  IDTicker.h
//  raycast
//
//  Created by Isaac Dudney on 8/4/14.
//  Copyright (c) 2014 Isaac Dudney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@class IDRender;

@class IDTicker;

@protocol IDTickerDelegate <NSObject>

- (void)ticked:(IDTicker *)ticker;

@end

@interface IDTicker : NSObject

@property (nonatomic,strong) CADisplayLink *ticker;
@property (nonatomic, weak) id<IDTickerDelegate> delegate;

@property (nonatomic) IDRender *render;

@end
