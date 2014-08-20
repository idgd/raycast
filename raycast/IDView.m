//
//  IDView.m
//  raycast
//
//  Created by Isaac Dudney on 8/4/14.
//  Copyright (c) 2014 Isaac Dudney. All rights reserved.
//

#import "IDView.h"

@implementation IDView

- (void)drawRect:(CGRect)rect {
    for (UIBezierPath *line in self.renderPaths) {
        [[UIColor yellowColor] set];
        [line stroke];
    }
}

@end
