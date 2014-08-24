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

@property(nonatomic, strong) NSArray *slices;

@end

@implementation IDView

- (instancetype)initWithCoder:(NSCoder *)coder {
  self = [super initWithCoder:coder];
  if (self) {
    self.wallTile = [UIImage imageNamed:@"walls3"];
    
    NSMutableArray *slices = [NSMutableArray array];
    // hard coded to 256x256 wall tile
    for(NSInteger i = 0;i < 16;i++) {
      CGRect imageSlice = CGRectMake(i * 16, 0.0, 16.0, 256.0);
      CGImageRef slice = CGImageCreateWithImageInRect(self.wallTile.CGImage, imageSlice);
      CGSize size = CGSizeMake(1.0, 256.0);
      UIGraphicsBeginImageContext(size);
      CGContextRef ctx = UIGraphicsGetCurrentContext();
      CGContextDrawImage(ctx, CGRectMake(0.0, 0.0, 1.0, 256.0), slice);
      [slices addObject:UIGraphicsGetImageFromCurrentImageContext()];
      UIGraphicsEndImageContext();
    }
    self.slices = [slices copy];
    
  }
  return self;
}

- (void)drawRect:(CGRect)rect {
  CGContextRef ctx = UIGraphicsGetCurrentContext();
	
	for (IDRenderLine *line in self.renderPaths) {
    CGRect bounds = [line.renderLine bounds];
    bounds.size.width = 1.0;
    CGContextDrawImage(ctx, bounds, ((UIImage *)self.slices[line.wallTileColumn]).CGImage);
	}

}

@end
