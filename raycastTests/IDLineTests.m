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
#import "IDRay.h"

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
  CGPoint intercetionPoint = [one intersectionPointWithLine:two intersects:&intersects];
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
  CGPoint intercetionPoint = [one intersectionPointWithLine:two intersects:&intersects];
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
  CGPoint intercetionPoint = [one intersectionPointWithLine:two intersects:&intersects];
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
  CGPoint intercetionPoint = [one intersectionPointWithLine:two intersects:&intersects];
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
  CGPoint intercetionPoint = [one intersectionPointWithLine:two intersects:&intersects];
  XCTAssert(intersects, @"%@ Should Intersect %@", one, two);
  XCTAssertEqualWithAccuracy(intercetionPoint.x, 2.0, 0.000001, @"X should be 2.0");
  XCTAssertEqualWithAccuracy(intercetionPoint.y, 0.0, 0.000001, @"Y should be 0.0");
}

- (void)testNotIntersectParrallel {
  IDLine *one = [[IDLine alloc] init];
  one.start = CGPointMake(0.0, 0.0);
  one.end = CGPointMake(4.0, 1.0);
  
  IDLine *two = [[IDLine alloc] init];
  two.start = CGPointMake(-4.0, -2.0);
  two.end = CGPointMake(0.0, -1.0);
  
  // intersection should be 2.0, 0.0
  BOOL intersects = NO;
  CGPoint intercetionPoint = [one intersectionPointWithLine:two intersects:&intersects];
  XCTAssert(!intersects, @"%@ Should Not Intersect %@", one, two);
  XCTAssertEqualWithAccuracy(intercetionPoint.x, 0.0, 0.000001, @"X should be 0.0");
  XCTAssertEqualWithAccuracy(intercetionPoint.y, 0.0, 0.000001, @"Y should be 0.0");
}

- (void)testRayAndLineIntercept {
  IDLine *one = [[IDLine alloc] init];
  one.start = CGPointMake(-4.0, 1.0);
  one.end = CGPointMake(4.0, -4.0);
  
  IDRay *ray = [[IDRay alloc] init];
  ray.origin = (CGPoint){1.0, 0.0};
  ray.direction = CGPointMake(cos(30.0 * M_PI / 180.0), sin(30.0 * M_PI / 180.0));
  
  BOOL intersects = NO;
  CGPoint intercetionPoint = [one intersectionPointWithRay:ray intersects:&intersects];
  XCTAssert(!intersects, @"%@ Should Not Intersect %@", one, ray);
  XCTAssertEqualWithAccuracy(intercetionPoint.x, 0.0, 0.000001, @"X should be 0.0");
  XCTAssertEqualWithAccuracy(intercetionPoint.y, 0.0, 0.000001, @"Y should be 0.0");
}

- (void)testRayAndLineInterceptRayVerticalLineSegmentAcute {
  IDLine *one = [[IDLine alloc] init];
  one.start = CGPointMake(-4.0, 4.0);
  one.end = CGPointMake(4.0, -4.0);
  
  IDRay *ray = [[IDRay alloc] init];
  ray.origin = (CGPoint){1.0, -2.0};
  ray.direction = CGPointMake(0.0, 1.0);
  
  BOOL intersects = NO;
  CGPoint intercetionPoint = [one intersectionPointWithRay:ray intersects:&intersects];
  XCTAssert(intersects, @"%@ Should Intersect %@", one, ray);
  XCTAssertEqualWithAccuracy(intercetionPoint.x,  1.0, 0.000001, @"X should be  1.0");
  XCTAssertEqualWithAccuracy(intercetionPoint.y, -1.0, 0.000001, @"Y should be -1.0");
}

- (void)testRayAndLineInterceptRayAcuteLineSegmentVertical {
  IDLine *one = [[IDLine alloc] init];
  one.start = CGPointMake(4.0, 4.0);
  one.end = CGPointMake(4.0, -4.0);
  
  IDRay *ray = [[IDRay alloc] init];
  ray.origin = (CGPoint){2.0, -1.0};
  ray.direction = CGPointMake(cos(45.0 * M_PI / 180.0), sin(45.0 * M_PI / 180.0));
  
  BOOL intersects = NO;
  CGPoint intercetionPoint = [one intersectionPointWithRay:ray intersects:&intersects];
  XCTAssert(intersects, @"%@ Should Intersect %@", one, ray);
  XCTAssertEqualWithAccuracy(intercetionPoint.x,  4.0, 0.000001, @"X should be 4.0");
  XCTAssertEqualWithAccuracy(intercetionPoint.y,  1.0, 0.000001, @"Y should be 1.0");
}

- (void)testRayAndLineInterceptRayAcuteLineSegmentAcute {
  IDLine *one = [[IDLine alloc] init];
  one.start = CGPointMake(0.0, 3.0);
  one.end = CGPointMake(3.0, -3.0);
  
  IDRay *ray = [[IDRay alloc] init];
  ray.origin = (CGPoint){-1.0, -1.0};
  ray.direction = CGPointMake(cos(45.0 * M_PI / 180.0), sin(45.0 * M_PI / 180.0));
  
  BOOL intersects = NO;
  CGPoint intercetionPoint = [one intersectionPointWithRay:ray intersects:&intersects];
  XCTAssert(intersects, @"%@ Should Intersect %@", one, ray);
  XCTAssertEqualWithAccuracy(intercetionPoint.x,  1.0, 0.000001, @"X should be 1.0");
  XCTAssertEqualWithAccuracy(intercetionPoint.y,  1.0, 0.000001, @"Y should be 1.0");
}

//- (void)testRayAndLineInterceptRayAcuteLineSegmentHorizontal {
//  IDLine *one = [[IDLine alloc] init];
//  one.start = CGPointMake(-10.0, 10.0);
//  one.end = CGPointMake(10.0, 10.0);
//  
//  IDRay *ray = [[IDRay alloc] init];
//  ray.origin = (CGPoint){-3.882, -4.519};
//  ray.slope = 2484.369709;
//  
//  BOOL intersects = NO;
//  CGPoint intercetionPoint = [one intersectionPointWithRay:ray intersects:&intersects];
//  XCTAssert(intersects, @"%@ Should Intersect %@", one, ray);
//  XCTAssertEqualWithAccuracy(intercetionPoint.x,  -3.876, 0.001, @"X should be -3.876");
//  XCTAssertEqualWithAccuracy(intercetionPoint.y,  10.0, 0.000001, @"Y should be 10.0");
//}

- (void)testRayAndLineInterceptRay45LineSegmentVertical {
  IDLine *one = [[IDLine alloc] init];
  one.start = CGPointMake(10.0, 10.0);
  one.end = CGPointMake(10.0, -10.0);
  
  IDRay *ray = [[IDRay alloc] init];
  ray.origin = (CGPoint){-5.0, -5.0};
  ray.direction = CGPointMake(cos(-45.0 * M_PI / 180.0), sin(-45.0 * M_PI / 180.0));
  
  BOOL intersects = NO;
  CGPoint intercetionPoint = [one intersectionPointWithRay:ray intersects:&intersects];
  XCTAssert(!intersects, @"%@ Should Not Intersect %@", one, ray);
  XCTAssertEqualWithAccuracy(intercetionPoint.x,  0.0, 0.001, @"X should be 0.0");
  XCTAssertEqualWithAccuracy(intercetionPoint.y,  0.0, 0.001, @"Y should be 0.0");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
