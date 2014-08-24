//
//  IDView.m
//  raycast
//
//  Created by Isaac Dudney on 8/4/14.
//  Copyright (c) 2014 Isaac Dudney. All rights reserved.
//

#import "IDView.h"

#import "IDRenderLine.h"
#import "IDEnemy.h"

@interface IDView ()

@property(nonatomic, strong) UIImage *floor;
@property(nonatomic, strong) UIImage *ceiling;

@end

@implementation IDView

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
	
	for (IDRenderLine *line in self.renderPaths) {
		
    [line.color set];
		line.renderLine.lineWidth = 1;
		
		[line.renderLine stroke];
		
	}
	
	for (IDEnemy *enemy in self.enemyPaths) {
		
		[[UIColor colorWithHue:0.0
								saturation:1.0
								brightness:1.0
										 alpha:1.0] set];
		enemy.enemyPath.lineWidth = enemy.enemyWidth;
		
		[enemy.enemyPath stroke];
		
	}
	
}

@end
