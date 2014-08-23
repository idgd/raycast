//
//  IDLine.m
//  raycast
//
//  Created by Isaac Dudney on 8/4/14.
//  Copyright (c) 2014 Isaac Dudney. All rights reserved.
//

#import "IDLine.h"
#import <UIKit/UIKit.h>
@implementation IDLine

- (NSString *)description
{
	return [NSString stringWithFormat:@"start = %@ end = %@", NSStringFromCGPoint(self.start), NSStringFromCGPoint(self.end)];
}
@end
