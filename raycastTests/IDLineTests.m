//
//  IDLineTests.m
//  raycast
//
//  Created by Bill Dudney on 8/23/14.
//  Copyright (c) 2014 Isaac Dudney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "IDLine.h"

@interface IDLineTests : XCTestCase

@end

@implementation IDLineTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

// line one & line two

- (void)testIntersectionOneHorizontalAndTwoVertical {
  IDLine *one = [[IDLine alloc] init];
  one.start = CGPointMake(0.0, 0.0);
  one.end = CGPointMake(4.0, 0.0);
  
  IDLine *two = [[IDLine alloc] init];
  two.start = CGPointMake(1.0, -1.0);
  two.end = CGPointMake(1.0, 1.0);
  
  // intersection should be 1.0, 0.0
  BOOL intersects = NO;
  CGPoint intercetionPoint = [one intersectionPoint:two intersects:&intersects];
  XCTAssert(intersects, @"%@ Should Intersect %@", one, two);
  XCTAssertEqualWithAccuracy(intercetionPoint.x, 1.0, 0.000001, @"X should be 1.0");
  XCTAssertEqualWithAccuracy(intercetionPoint.y, 0.0, 0.000001, @"Y should be 0.0");
}

- (void)testIntersectionOneHorizontalAndTwoAcute {
  IDLine *one = [[IDLine alloc] init];
  one.start = CGPointMake(0.0, 0.0);
  one.end = CGPointMake(4.0, 0.0);
  
  IDLine *two = [[IDLine alloc] init];
  two.start = CGPointMake(0.0, -1.0);
  two.end = CGPointMake(4.0, 1.0);
  
  // intersection should be 2.0, 0.0
  BOOL intersects = NO;
  CGPoint intercetionPoint = [one intersectionPoint:two intersects:&intersects];
  XCTAssert(intersects, @"%@ Should Intersect %@", one, two);
  XCTAssertEqualWithAccuracy(intercetionPoint.x, 2.0, 0.000001, @"X should be 2.0");
  XCTAssertEqualWithAccuracy(intercetionPoint.y, 0.0, 0.000001, @"Y should be 0.0");
}

- (void)testIntersectionOneAcuteAndTwoHorizontal {
  IDLine *one = [[IDLine alloc] init];
  one.start = CGPointMake(0.0, -1.0);
  one.end = CGPointMake(4.0, 1.0);
  
  IDLine *two = [[IDLine alloc] init];
  two.start = CGPointMake(0.0, 0.0);
  two.end = CGPointMake(4.0, 0.0);
  
  // intersection should be 2.0, 0.0
  BOOL intersects = NO;
  CGPoint intercetionPoint = [one intersectionPoint:two intersects:&intersects];
  XCTAssert(intersects, @"%@ Should Intersect %@", one, two);
  XCTAssertEqualWithAccuracy(intercetionPoint.x, 2.0, 0.000001, @"X should be 2.0");
  XCTAssertEqualWithAccuracy(intercetionPoint.y, 0.0, 0.000001, @"Y should be 0.0");
}

- (void)testIntersectionOneAcuteAndTwoVertical {
  IDLine *one = [[IDLine alloc] init];
  one.start = CGPointMake(0.0, -1.0);
  one.end = CGPointMake(4.0, 1.0);
  
  IDLine *two = [[IDLine alloc] init];
  two.start = CGPointMake(1.0, -4.0);
  two.end = CGPointMake(1.0, 4.0);
  
  // intersection should be 2.0, 0.0
  BOOL intersects = NO;
  CGPoint intercetionPoint = [one intersectionPoint:two intersects:&intersects];
  XCTAssert(intersects, @"%@ Should Intersect %@", one, two);
  XCTAssertEqualWithAccuracy(intercetionPoint.x, 1.0, 0.000001, @"X should be 1.0");
  XCTAssertEqualWithAccuracy(intercetionPoint.y, -0.5, 0.000001, @"Y should be -0.5");
}

- (void)testIntersectionOneAcuteAndTwoAcute {
  IDLine *one = [[IDLine alloc] init];
  one.start = CGPointMake(0.0, -1.0);
  one.end = CGPointMake(4.0, 1.0);
  
  IDLine *two = [[IDLine alloc] init];
  two.start = CGPointMake(0.0, -4.0);
  two.end = CGPointMake(4.0, 4.0);
  
  // intersection should be 2.0, 0.0
  BOOL intersects = NO;
  CGPoint intercetionPoint = [one intersectionPoint:two intersects:&intersects];
  XCTAssert(intersects, @"%@ Should Intersect %@", one, two);
  XCTAssertEqualWithAccuracy(intercetionPoint.x, 2.0, 0.000001, @"X should be 2.0");
  XCTAssertEqualWithAccuracy(intercetionPoint.y, 0.0, 0.000001, @"Y should be 0.0");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
