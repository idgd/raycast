//
//  IDGraphicsUtilities.c
//  raycast
//
//  Created by Bill Dudney on 8/23/14.
//  Copyright (c) 2014 Isaac Dudney. All rights reserved.
//

#include "IDGraphicsUtilities.h"
#include <math.h>

CGPoint CGAffineTransformApplyToPoint(CGAffineTransform transform, CGPoint point) {
  CGFloat newX = point.x * transform.a + point.y * transform.b + transform.tx;
  CGFloat newY = point.x * transform.c + point.y * transform.d + transform.ty;
  return CGPointMake(newX, newY);
}

CGPoint CGPointToPointDelta(CGPoint first, CGPoint second) {
  return CGPointMake(second.x - first.x, second.y - first.y);
}

CGFloat CGPointLength(CGPoint vector) {
  return (CGFloat)sqrt(vector.x * vector.x + vector.y * vector.y);
}