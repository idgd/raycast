//
//  IDRender.m
//  raycast
//
//  Created by Isaac Dudney on 8/4/14.
//  Copyright (c) 2014 Isaac Dudney. All rights reserved.
//

#import "IDRender.h"

#import "IDRectangle.h"
#import "IDRay.h"
#import "IDCamera.h"
#import "IDLine.h"
#import "IDRenderLine.h"

@implementation IDRender

- (void)calculateLines {
	self.renderLines = [NSMutableArray array];
	
	CGFloat distanceROTDelta = self.player.FOV / self.player.bounds.width / 10;
	CGFloat distanceROT = self.player.ROT;
	
	for (int width = 0; width < self.player.bounds.width / 10; width++) {
		CGFloat DIS;
		
		IDRay *distanceRay = [[IDRay alloc]init];
		distanceRay.XY = self.player.POS;
		distanceRay.M = tan(distanceROT);
		distanceRay.B = (distanceRay.XY.y - (distanceRay.M * distanceRay.XY.x));
		
		for (IDRectangle *block in self.blocks) {
			IDLine *AB = [[IDLine alloc]init];
			AB.start = block.a;
			AB.end = block.b;
			
			IDLine *BC = [[IDLine alloc]init];
			BC.start = block.b;
			BC.end = block.c;
			
			IDLine *CD = [[IDLine alloc]init];
			CD.start = block.c;
			CD.end = block.d;
			
			IDLine *DA = [[IDLine alloc]init];
			DA.start = block.d;
			DA.end = block.a;
			
			NSArray *ABCD = @[AB, BC, CD, DA];
			
			for (IDLine *line in ABCD) {
				
				line.M = (line.end.y - line.start.y) / (line.end.x - line.start.x);
				line.B = line.start.y - line.M * line.start.x;
				
				if(distanceRay.M == line.M){
					continue;
				}
				
				CGFloat collX, collY;
				
				if (line.M >= MAXFLOAT - 1 ||
						line.M <= -MAXFLOAT + 1) {
					
					collX = line.start.x;
					
					collY = distanceRay.M * line.start.x + distanceRay.B;
					
				} else if (distanceRay.M >= MAXFLOAT - 1 ||
									 distanceRay.M <= -MAXFLOAT + 1) {
					
					collX = distanceRay.XY.x;
					
					collY = line.M * distanceRay.XY.x + line.B;
					
				} else {
					
					collX = (distanceRay.B - line.B) /
					(line.M - distanceRay.M);
					
					collY = (line.M * distanceRay.B - distanceRay.M * line.B) /
					(line.M - distanceRay.M);
					
				}
				
				if(collX > MAX(line.start.x, line.end.x) + 0.01 ||
					 collX < MIN(line.start.x, line.end.x) - 0.01 ||
					 collY > MAX(line.start.y, line.end.y) + 0.01 ||
					 collY < MIN(line.start.y, line.end.y) - 0.01){
					
					continue;
					
				}
				
				CGFloat changedCollX = collX - distanceRay.XY.x;
				CGFloat changedCollY = collY - distanceRay.XY.y;
				
				CGFloat dot = cos(distanceROT) * changedCollX + sin(distanceROT) * changedCollY;
				
				if(dot <= 0.0){
					continue;
				}
				
				DIS = sqrt(pow(collX - distanceRay.XY.x, 2) +
									 pow(collY - distanceRay.XY.y, 2));
				
				IDRenderLine *renderLine = [[IDRenderLine alloc] init];
				
				renderLine.renderLine = [UIBezierPath bezierPath];
				renderLine.renderLine.flatness = MAXFLOAT;
				
				[renderLine.renderLine moveToPoint:
				 CGPointMake(width * 10, self.player.bounds.height/2 +
										(self.player.bounds.height/2 * (5 / DIS)))];
				
				[renderLine.renderLine addLineToPoint:
				 CGPointMake(width * 10, self.player.bounds.height/2 -
										(self.player.bounds.height/2 * (5 / DIS)))];
				
				renderLine.depth = DIS;
				
				[self.renderLines addObject:renderLine];
			}
		}
		
		distanceROT += distanceROTDelta;
		
	}
}

@end

//the original bezierpath placement code

/*[renderLine moveToPoint:CGPointMake(width, self.player.bounds.height/2 + (self.player.bounds.height/2 * (1 / DIS)))];
 
 [renderLine addLineToPoint:CGPointMake(width, self.player.bounds.height/2 - (self.player.bounds.height/2 * (1 / DIS)))];*/

//the wall testing code. Use this if it's not rendering a wall properly.

/*if ([ABCD indexOfObject:line] == 0) {
 
 [renderLine moveToPoint:
 CGPointMake(width / 3,
 self.player.bounds.height / 3)];
 
 [renderLine addLineToPoint:
 CGPointMake(width / 3,
 (self.player.bounds.height / 3) + 10)];
 
 } else if ([ABCD indexOfObject:line] == 1) {
 
 [renderLine moveToPoint:
 CGPointMake(width / 2,
 self.player.bounds.height / 2)];
 
 [renderLine addLineToPoint:
 CGPointMake(width / 2,
 (self.player.bounds.height / 2) + 10)];
 
 } else if ([ABCD indexOfObject:line] == 2) {
 
 [renderLine moveToPoint:
 CGPointMake(width,
 self.player.bounds.height)];
 
 [renderLine addLineToPoint:
 CGPointMake(width,
 self.player.bounds.height - 10)];
 
 } else if ([ABCD indexOfObject:line] == 3) {
 
 [renderLine moveToPoint:
 CGPointMake(width,
 self.player.bounds.height/2 +
 (self.player.bounds.height/2 * (1 / DIS)))];
 
 [renderLine addLineToPoint:
 CGPointMake(width,
 self.player.bounds.height/2 -
 (self.player.bounds.height/2 * (1 / DIS)))];
 
 }*/

//Original displacement calculation (AKA lame stuff for lame people)

/*CGFloat DISX;
 
 if (distanceRay.M == 0 || distanceRay.M == INFINITY) {
 DISX = line.start.x;
 } else {
 DISX = (line.start.y - distanceRay.B) / distanceRay.M;
 }
 
 CGFloat DISY = (distanceRay.M * line.start.x) + distanceRay.B;
 
 if ((DISX > line.start.x && DISX < line.end.x) ||
 (DISY > line.start.y && DISY < line.end.y)) {
 
 DIS = sqrt(pow(DISX - distanceRay.XY.x, 2) +
 pow(DISY - distanceRay.XY.y, 2));
 
 UIBezierPath *renderLine = [UIBezierPath bezierPath];
 
 renderLine.flatness = MAXFLOAT;
 
 [renderLine moveToPoint:CGPointMake(width, self.player.bounds.height/2 + (self.player.bounds.height/2 * (1 / DIS)))];
 
 [renderLine addLineToPoint:CGPointMake(width, self.player.bounds.height/2 - (self.player.bounds.height/2 * (1 / DIS)))];
 
 [self.renderLines addObject:renderLine];
 
 }*/
