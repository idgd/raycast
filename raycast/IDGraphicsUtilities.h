//
//  IDGraphicsUtilities.h
//  raycast
//
//  Created by Bill Dudney on 8/23/14.
//  Copyright (c) 2014 Isaac Dudney. All rights reserved.
//

#ifndef __raycast__IDGraphicsUtilities__
#define __raycast__IDGraphicsUtilities__

#include <stdio.h>
#include <CoreGraphics/CoreGraphics.h>

CGPoint CGAffineTransformApplyToPoint(CGAffineTransform transform, CGPoint point);
CGPoint CGPointToPointDelta(CGPoint first, CGPoint second);
CGFloat CGPointLength(CGPoint vector);

#endif /* defined(__raycast__IDGraphicsUtilities__) */
