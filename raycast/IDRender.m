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

- (void)gak {
  self.renderLines = [NSMutableArray array];
  CGFloat distanceROTDelta = self.player.FOV / self.player.bounds.width;
  CGFloat distanceROT = self.player.ROT - self.player.FOV/2.0;
  
  for (int width = 0; width < self.player.bounds.width; width++) {
    CGFloat DIS;
    
    IDRay *distanceRay = [[IDRay alloc]init];
    distanceRay.origin = self.player.POS;
    distanceRay.direction = CGPointMake(cos(distanceROT), sin(distanceROT));
    
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
        BOOL zorting = NO;
        CGPoint zort = [line intersectionPointWithRay:distanceRay intersects:&zorting];
        CGFloat distanceRaySlope = [distanceRay slope];
        
        if(distanceRaySlope == line.slope){
          assert(zorting == NO);
          continue;
        }
        CGFloat collX, collY;
        
        if (line.slope >= MAXFLOAT - 1 ||
            line.slope <= -MAXFLOAT + 1) {
          
          collX = line.start.x;
          
          collY = distanceRaySlope * line.start.x + distanceRay.intercept;
          
        } else if (distanceRaySlope >= MAXFLOAT - 1 ||
                   distanceRaySlope <= -MAXFLOAT + 1) {
          
          collX = distanceRay.origin.x;
          
          collY = line.slope * distanceRay.origin.x + line.intercept;
          
        } else {
          
          collX = (distanceRay.intercept - line.intercept) /
          (line.slope - distanceRaySlope);
          
          collY = (line.slope * distanceRay.intercept - distanceRaySlope * line.intercept) /
          (line.slope - distanceRaySlope);
          
        }
        
        if(collX > MAX(line.start.x, line.end.x) + 0.01 ||
           collX < MIN(line.start.x, line.end.x) - 0.01 ||
           collY > MAX(line.start.y, line.end.y) + 0.01 ||
           collY < MIN(line.start.y, line.end.y) - 0.01){
          assert(zorting == NO);
          continue;
          
        }

        CGFloat changedCollX = collX - distanceRay.origin.x;
        CGFloat changedCollY = collY - distanceRay.origin.y;
        
        CGFloat dot = cos(distanceROT) * changedCollX + sin(distanceROT) * changedCollY;
        
        if(dot <= 0.0){
          assert(zorting == NO);
          continue;
        }
        assert(zorting == YES);
        assert(collX == zort.x);
        assert(collY == zort.y);
        
        DIS = sqrt(pow(collX - distanceRay.origin.x, 2) +
                   pow(collY - distanceRay.origin.y, 2));
        
        CGFloat distance = sqrt(pow(zort.x - distanceRay.origin.x, 2) +
                                pow(zort.y - distanceRay.origin.y, 2));
        assert(distance == DIS);

        IDRenderLine *renderLine = [[IDRenderLine alloc] init];
        
        renderLine.renderLine = [UIBezierPath bezierPath];
        renderLine.renderLine.flatness = MAXFLOAT;
        
        [renderLine.renderLine moveToPoint:
         CGPointMake(width, self.player.bounds.height/2 +
                     (self.player.bounds.height/2 * (5 / DIS)))];
        
        [renderLine.renderLine addLineToPoint:
         CGPointMake(width, self.player.bounds.height/2 -
                     (self.player.bounds.height/2 * (5 / DIS)))];

        renderLine.depth = DIS;
        renderLine.color = [UIColor colorWithHue:0.2
                                      saturation:1.0
                                      brightness:10.0/DIS
                                           alpha:1.0];

        [self.renderLines addObject:renderLine];
      }
    }
    
    distanceROT += distanceROTDelta;
    
  }
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
  
  if(zBuffer) {
    free(zBuffer);
  }
}

@end