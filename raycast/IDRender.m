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
#import "IDEnemy.h"

@implementation IDRender

- (void)calculateLines {
  NSUInteger lineCount = self.player.bounds.width;
  
  self.renderLines = [NSMutableArray arrayWithCapacity:lineCount];
  CGFloat *zBuffer = calloc(lineCount, sizeof(CGFloat));
  
  for(NSUInteger i = 0;i < lineCount;i++) {
    zBuffer[i] = MAXFLOAT;
  }

  
  CGFloat distanceROTDelta = self.player.FOV / self.player.bounds.width;
  CGFloat distanceROT = self.player.ROT - self.player.FOV/2.0;
  
  for (int width = 0; width < self.player.bounds.width; width++) {
    
    IDRay *distanceRay = [[IDRay alloc]init];
    distanceRay.origin = self.player.POS;
    // normalized direction vector for the ray
    distanceRay.direction = CGPointMake(cos(distanceROT), sin(distanceROT));
    
    for (IDRectangle *block in self.blocks) {
      BOOL intersects = NO;
      CGPoint intersection = [block intersectionWithRay:distanceRay flag:&intersects];
      if(intersects) {
        CGFloat distance = sqrt(pow(intersection.x - distanceRay.origin.x, 2) +
                                pow(intersection.y - distanceRay.origin.y, 2));
        
        if(distance < zBuffer[width]) {
          zBuffer[width] = distance;
          IDRenderLine *renderLine = [[IDRenderLine alloc] init];
          
          renderLine.renderLine = [UIBezierPath bezierPath];
          renderLine.renderLine.flatness = MAXFLOAT;
          
          [renderLine.renderLine moveToPoint:
           CGPointMake(width, self.player.bounds.height/2.0 +
                       (self.player.bounds.height/2.0 * (5.0 / distance)))];
          
          [renderLine.renderLine addLineToPoint:
           CGPointMake(width, self.player.bounds.height/2.0 -
                       (self.player.bounds.height/2.0 * (5.0 / distance)))];
          
          renderLine.depth = distance;
          renderLine.color = [UIColor colorWithHue:0.2
                                        saturation:1.0
                                        brightness:10.0/distance
                                             alpha:1.0];
          self.renderLines[width] = renderLine;
        }

      }
    }
    distanceROT += distanceROTDelta;
  }
  
  [self calculateEnemies];
  
  if(zBuffer) {
    free(zBuffer);
  }
}

- (void)calculateEnemies {
  CGFloat enemyDISRay, enemyDISRayDelta, width = 0.0;
  enemyDISRay = self.player.ROT - self.player.FOV/2.0;
  enemyDISRayDelta = self.player.FOV / self.player.bounds.width;
  
  for (int boop = 0; boop < self.player.bounds.width; boop++) {
    
    IDRay *distanceRay = [[IDRay alloc]init];
    distanceRay.origin = self.player.POS;
    distanceRay.direction = CGPointMake(cos(enemyDISRay), sin(enemyDISRay));
    
    for (IDEnemy *enemy in self.enemyBlocks) {
      if (enemy.enemyOrigin.y  == distanceRay.slope * enemy.enemyOrigin.x + distanceRay.intercept ||
          distanceRay.origin.x == (enemy.enemyOrigin.y - distanceRay.intercept) / distanceRay.slope) {
        width = boop;
      }
    }
    
    enemyDISRay += enemyDISRayDelta;
  }
  
  for (IDEnemy *enemy in self.enemyBlocks) {
    
    CGFloat DIS = sqrt(pow(self.player.POS.x - enemy.enemyOrigin.x, 2) +
                       pow(self.player.POS.y - enemy.enemyOrigin.y, 2));
    
    enemy.enemyWidth = (self.player.bounds.width / 2) / DIS;
    
    enemy.enemyPath = [UIBezierPath bezierPath];
    enemy.enemyPath.flatness = MAXFLOAT;
    
    [enemy.enemyPath moveToPoint:CGPointMake(width,
                                             self.player.bounds.height / 2 +
                                             (self.player.bounds.height / 2 *
                                              (5 / DIS)))];
    
    [enemy.enemyPath addLineToPoint:CGPointMake(width,
                                                self.player.bounds.height / 2 -
                                                (self.player.bounds.height / 2 *
                                                 (5 / DIS)))];
    
    [self.enemies addObject:enemy];
    
  }
}

@end