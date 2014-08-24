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
#import <ImageIO/ImageIO.h>

@interface IDView ()

@property(nonatomic, strong) UIImage *wallTile;

@end

@implementation IDView

- (instancetype)initWithCoder:(NSCoder *)coder {
  self = [super initWithCoder:coder];
  if (self) {
    self.wallTile = [UIImage imageNamed:@"walls4"];
  }
  return self;
}

- (void)drawRect:(CGRect)rect {
  CGContextRef ctx = UIGraphicsGetCurrentContext();
	
	for (IDRenderLine *line in self.renderPaths) {
    CGRect bounds = [line.renderLine bounds];
    bounds.size.width = 1.0;
    NSUInteger wallTileWidth = self.wallTile.size.width;
    NSUInteger wallTileHeight = self.wallTile.size.height;
    CGRect imageSlize = CGRectMake(((NSInteger)(bounds.origin.x)) % wallTileWidth, 0.0, 1.0, wallTileHeight);
    CGImageRef slice = CGImageCreateWithImageInRect(self.wallTile.CGImage, imageSlize);
    CGContextDrawImage(ctx, bounds, slice);
//    [line.color set];
//		line.renderLine.lineWidth = 1;
//		[line.renderLine stroke];
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
