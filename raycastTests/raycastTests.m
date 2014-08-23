//
//  raycastTests.m
//  raycastTests
//
//  Created by Isaac Dudney on 8/4/14.
//  Copyright (c) 2014 Isaac Dudney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "IDGraphicsUtilities.h"

@interface raycastTests : XCTestCase

@end

@implementation raycastTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testExample {
    XCTAssert(YES, @"Pass");
}

- (void)testRotation1 {
  CGAffineTransform rotation = CGAffineTransformMakeRotation(30.0 * M_PI / 180.0);
  CGPoint point = CGPointMake(4.0, 3.0);
  CGPoint newPoint = CGAffineTransformApplyToPoint(rotation, point);
  XCTAssertEqualWithAccuracy(sqrt(point.x * point.x + point.y * point.y),
                             sqrt(newPoint.x * newPoint.x + newPoint.y * newPoint.y), 0.00001);
  
}

- (void)testRotation2 {
  CGAffineTransform rotation = CGAffineTransformMakeRotation(-30.0 * M_PI / 180.0);
  CGPoint point = CGPointMake(4.0, 3.0);
  CGPoint newPoint = CGAffineTransformApplyToPoint(rotation, point);
  XCTAssertEqualWithAccuracy(sqrt(point.x * point.x + point.y * point.y),
                             sqrt(newPoint.x * newPoint.x + newPoint.y * newPoint.y), 0.00001);
  
}

- (void)testTranslation {
  CGAffineTransform rotation = CGAffineTransformMakeTranslation(-3.0, 3.0);
  CGPoint point = CGPointMake(4.0, 3.0);
  CGPoint newPoint = CGAffineTransformApplyToPoint(rotation, point);
  XCTAssertEqualWithAccuracy(newPoint.x,
                             point.x - 3.0, 0.00001);
  XCTAssertEqualWithAccuracy(newPoint.y,
                             point.y + 3.0, 0.00001);
  
}

- (void)testTranslationAndRotation {
  CGAffineTransform translation = CGAffineTransformMakeTranslation(-3.0, 3.0);
  CGAffineTransform rotation = CGAffineTransformMakeRotation(30.0 * M_PI / 180.0);
  CGAffineTransform transform = CGAffineTransformConcat(rotation, translation);
  CGPoint point = CGPointMake(4.0, 3.0);
  CGPoint oldOrigin = CGPointMake(0.0, 0.0);
  CGPoint newPoint = CGAffineTransformApplyToPoint(transform, point);
  CGPoint newOrigin = CGAffineTransformApplyToPoint(transform, oldOrigin);
  CGPoint delta = CGPointMake(newPoint.x - newOrigin.x, newPoint.y - newOrigin.y);
  XCTAssertEqualWithAccuracy(sqrt(point.x * point.x + point.y * point.y),
                             sqrt(delta.x * delta.x + delta.y * delta.y), 0.00001);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
