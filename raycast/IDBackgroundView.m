//
//  IDBackgroundView.m
//  raycast
//
//  Created by Bill Dudney on 8/24/14.
//  Copyright (c) 2014 Isaac Dudney. All rights reserved.
//

#import "IDBackgroundView.h"

@interface IDBackgroundView ()

@property(nonatomic, strong) UIImage *floor;
@property(nonatomic, strong) UIImage *ceiling;

@end

@implementation IDBackgroundView

- (instancetype)initWithCoder:(NSCoder *)coder {
  self = [super initWithCoder:coder];
  if (self) {
    self.floor = [UIImage imageNamed:@"floor"];
    self.ceiling = [UIImage imageNamed:@"ceiling"];
  }
  return self;
}

- (void)drawRect:(CGRect)rect {
  [self.ceiling drawInRect:CGRectMake(0.0, 0.0, 1024.0, 768.0 / 2.0)];
  [self.floor drawInRect:CGRectMake(0.0, 768.0 / 2.0, 1024.0, 768.0 / 2.0)];
}

@end
