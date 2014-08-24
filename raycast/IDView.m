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

@implementation IDView

- (void)drawRect:(CGRect)rect {
	
	for (IDRenderLine *line in self.renderPaths) {
		
		[[UIColor colorWithHue:0.2
								saturation:1.0
								brightness:10.0/line.depth
										 alpha:1.0] set];
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
