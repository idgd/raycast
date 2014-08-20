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

@implementation IDRender

- (void)calculateLines {
    
    self.renderLines = [NSMutableArray array];
    
    CGFloat distanceROTDelta = self.player.FOV / self.player.bounds.width;
    CGFloat distanceROT = self.player.ROT;
    
    for (int width = 0; width < self.player.bounds.width; width++) {
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
            
            NSArray *ABCD = @[DA];
            
            for (IDLine *line in ABCD) {
                
                CGFloat DISX;
                
                if (distanceRay.M == 0) {
                    DISX = line.start.x;
                } else {
                    DISX = (line.start.y - distanceRay.B) / distanceRay.M;
                }
                
                CGFloat DISY = (distanceRay.M * line.start.x) + distanceRay.B;
                
                NSLog(@"DISY: %f",DISY);
                NSLog(@"DISX: %f",DISX);
                NSLog(@"X:%f,%f",line.start.x,line.end.x);
                NSLog(@"Y:%f,%f",line.start.y,line.end.y);
                
                if ((DISX > line.start.x && DISX < line.end.x) ||
                    (DISY > line.start.y && DISY < line.end.y)) {
                    
                    NSLog(@"Success!");
                    
                    DIS = sqrt(pow(DISX - distanceRay.XY.x, 2) +
                               pow(DISY - distanceRay.XY.y, 2));
                    
                    UIBezierPath *renderLine = [UIBezierPath bezierPath];
                    
                    renderLine.flatness = MAXFLOAT;
                    
                    [renderLine moveToPoint:CGPointMake(width, self.player.bounds.height/2 + (self.player.bounds.height/2 * (1 / DIS)))];
                    
                    [renderLine addLineToPoint:CGPointMake(width, self.player.bounds.height/2 - (self.player.bounds.height/2 * (1 / DIS)))];
                    
                    [self.renderLines addObject:renderLine];
                    
                }
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
