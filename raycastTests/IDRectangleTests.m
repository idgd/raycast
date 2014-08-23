//
//  IDRectangleTests.m
//  raycast
//
//  Created by Bill Dudney on 8/23/14.
//  Copyright (c) 2014 Isaac Dudney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "IDRectangle.h"
#import "IDLine.h"

@interface IDRectangleTests : XCTestCase

@end

@implementation IDRectangleTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testInterectionPointBottom {
  IDRectangle *wall0 = [[IDRectangle alloc]init];
  wall0.a = CGPointMake(-10, -10);
  wall0.b = CGPointMake(-10, 10);
  wall0.c = CGPointMake(-15, 10);
  wall0.d = CGPointMake(-15, -10);
  
  IDLine *line = [[IDLine alloc] init];
  line.start = CGPointMake(-14.0, -14.0);
  line.end = CGPointMake(-12.0, -6.0);
  
  BOOL flag = NO;
  CGPoint point = [wall0 intersectionWithPoint:line flag:&flag];
  XCTAssert(flag, @"Should Intersect");
  XCTAssertEqualWithAccuracy(point.x, -13.0, 0.00001, @"point.x should be -13.0");
  XCTAssertEqualWithAccuracy(point.y, -10.0, 0.00001, @"point.y should be -10.0");
}

- (void)testInterectionPointRight {
  IDRectangle *wall0 = [[IDRectangle alloc]init];
  wall0.a = CGPointMake(-10, -10);
  wall0.b = CGPointMake(-10, 10);
  wall0.c = CGPointMake(-15, 10);
  wall0.d = CGPointMake(-15, -10);
  
  IDLine *line = [[IDLine alloc] init];
  line.start = CGPointMake(-8.0, 3.0);
  line.end = CGPointMake(-12.0, 2.0);
  
  BOOL flag = NO;
  CGPoint point = [wall0 intersectionWithPoint:line flag:&flag];
  XCTAssert(flag, @"Should Intersect");
  XCTAssertEqualWithAccuracy(point.x, -10.0, 0.00001, @"point.x should be -10.0");
  XCTAssertEqualWithAccuracy(point.y, 2.5, 0.00001, @"point.y should be 2.5");
}

- (void)testInterectionPointRightFail {
  IDRectangle *wall0 = [[IDRectangle alloc]init];
  wall0.a = CGPointMake(-10, -10);
  wall0.b = CGPointMake(-10, 10);
  wall0.c = CGPointMake(-15, 10);
  wall0.d = CGPointMake(-15, -10);
  
  IDLine *line = [[IDLine alloc] init];
  line.start = CGPointMake(-8.0, 3.0);
  line.end = CGPointMake(-9.5, 2.626);
  
  BOOL flag = NO;
  CGPoint point = [wall0 intersectionWithPoint:line flag:&flag];
  XCTAssert(!flag, @"Should Not Intersect");
  XCTAssertEqualWithAccuracy(point.x, 0.0, 0.00001, @"point.x should be 0.0");
  XCTAssertEqualWithAccuracy(point.y, 0.0, 0.00001, @"point.y should be 0.0");
}

- (void)testInterectionPointRightFailHorizontal {
  IDRectangle *wall0 = [[IDRectangle alloc]init];
  wall0.a = CGPointMake(-10, -10);
  wall0.b = CGPointMake(-10, 10);
  wall0.c = CGPointMake(-15, 10);
  wall0.d = CGPointMake(-15, -10);
  
  IDLine *line = [[IDLine alloc] init];
  line.start = CGPointMake(-8.0, 3.0);
  line.end = CGPointMake(-9.5, 3.0);
  
  BOOL flag = NO;
  CGPoint point = [wall0 intersectionWithPoint:line flag:&flag];
  XCTAssert(!flag, @"Should Not Intersect");
  XCTAssertEqualWithAccuracy(point.x, 0.0, 0.00001, @"point.x should be 0.0");
  XCTAssertEqualWithAccuracy(point.y, 0.0, 0.00001, @"point.y should be 0.0");
}

- (void)testInterectionPointRightHorizontal {
  IDRectangle *wall0 = [[IDRectangle alloc]init];
  wall0.a = CGPointMake(-10, -10);
  wall0.b = CGPointMake(-10, 10);
  wall0.c = CGPointMake(-15, 10);
  wall0.d = CGPointMake(-15, -10);
  
  IDLine *line = [[IDLine alloc] init];
  line.start = CGPointMake(-8.0, 3.0);
  line.end = CGPointMake(-12.0, 3.0);
  
  BOOL flag = NO;
  CGPoint point = [wall0 intersectionWithPoint:line flag:&flag];
  XCTAssert(flag, @"Should Intersect");
  XCTAssertEqualWithAccuracy(point.x, -10.0, 0.00001, @"point.x should be -10.0");
  XCTAssertEqualWithAccuracy(point.y, 3.0, 0.00001, @"point.y should be 3.0");
}

- (void)testFailedInterectionPoint {
  IDRectangle *wall0 = [[IDRectangle alloc]init];
  wall0.a = CGPointMake(-10, -10);
  wall0.b = CGPointMake(-10, 10);
  wall0.c = CGPointMake(-15, 10);
  wall0.d = CGPointMake(-15, -10);
  
  IDLine *line = [[IDLine alloc] init];
  line.start = CGPointMake(-14.0, -14.0);
  line.end = CGPointMake(-13.5, -12.0);
  
  BOOL flag = NO;
  CGPoint point = [wall0 intersectionWithPoint:line flag:&flag];
  XCTAssert(!flag, @"Should Intersect");
  XCTAssertEqualWithAccuracy(point.x, 0.0, 0.00001, @"point.x should be 0.0");
  XCTAssertEqualWithAccuracy(point.y, 0.0, 0.00001, @"point.y should be 0.0");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
