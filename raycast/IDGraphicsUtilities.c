//
//  IDGraphicsUtilities.c
//  raycast
//
//  Created by Bill Dudney on 8/23/14.
//  Copyright (c) 2014 Isaac Dudney. All rights reserved.
//

#include "IDGraphicsUtilities.h"

CGPoint CGAffineTransformApplyToPoint(CGAffineTransform transform, CGPoint point) {
  CGFloat newX = point.x * transform.a + point.y * transform.b + transform.tx;
  CGFloat newY = point.x * transform.c + point.y * transform.d + transform.ty;
  return CGPointMake(newX, newY);
}
