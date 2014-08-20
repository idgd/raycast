//
//  IDTicker.m
//  raycast
//
//  Created by Isaac Dudney on 8/4/14.
//  Copyright (c) 2014 Isaac Dudney. All rights reserved.
//

#import "IDTicker.h"
#import "IDRender.h"
#import "IDCamera.h"

@implementation IDTicker

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.ticker = [CADisplayLink displayLinkWithTarget:self selector:@selector(tick:)];
        [self.ticker addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    }
    return self;
}

- (void)tick:(CADisplayLink *)ticker {
    [self.render calculateLines];
    [self.delegate ticked:self];
    
    self.render.player.ROT += 0.01;
    NSLog(@"ROT: %f",self.render.player.ROT);
//    self.render.player.POS = CGPointMake(self.render.player.ROT*15, 0);
}

@end
