//
//  ViewController.m
//  raycast
//
//  Created by Isaac Dudney on 8/4/14.
//  Copyright (c) 2014 Isaac Dudney. All rights reserved.
//

#import "ViewController.h"

#import "IDRender.h"
#import "IDTicker.h"
#import "IDRectangle.h"
#import "IDRay.h"
#import "IDCamera.h"
#import "IDLine.h"

#import "IDView.h"

@interface ViewController () <IDTickerDelegate>

@end

@implementation ViewController

- (void)ticked:(IDTicker *)ticker {
	
	((IDView *)self.view).renderPaths = self.map.renderLines;
	
	if(self.location.x <= self.view.bounds.size.width / 2.0) {
		
		CGFloat speed = 1.0/500.0;
    
    CGPoint newPoint = CGPointMake(self.map.player.POS.x
                                   - cos(self.map.player.ROT) * self.translation.y * speed
                                   - sin(self.map.player.ROT) * self.translation.x * speed,
                                   self.map.player.POS.y
                                   - sin(self.map.player.ROT) * self.translation.y * speed
                                   + cos(self.map.player.ROT) * self.translation.x * speed);
    
    IDLine *playerLine = [[IDLine alloc]init];
    playerLine.start = self.map.player.POS;
    playerLine.end = newPoint;
		
		for (IDRectangle *collRECT in self.map.blocks) {
			
			if ([collRECT containsPoint:newPoint]) {
				
				BOOL beep = NO;
				
				/*CGPoint intersectionPoint = */[collRECT intersectionWithPoint:playerLine
																															 flag:&beep];
				if (beep) {
					newPoint = self.map.player.POS; //Well... this works better than using the intersection point :P Ideally we'd use the intersection point + a small margin of error, but this simulates that in an ok way.
				}
				
			}
			
		}
    
    self.map.player.POS = newPoint;
		
		//Forward vector:
		//X = cos(theta), Y = sin(theta)
		//Right vector:
		//X = sin(theta), Y = -cos(theta)
		//Both are negated in the actual translation because positive y pan is down, and positive x pan is left when it needs to be up and right.
		
	} else {
		
		self.map.player.ROT += self.translation.x / 5000.0 * M_PI;
		
	}
	
	[self.view setNeedsDisplay];
	
}

- (void) movePlayer:(UIPanGestureRecognizer *)tapGR {
	
	if(tapGR.state == UIGestureRecognizerStateBegan) {
		
		self.location = [self.tapGR locationInView:self.view];
		
	} else if(tapGR.state == UIGestureRecognizerStateChanged) {
		
		self.translation = [self.tapGR translationInView:self.view];
		
	} else if(tapGR.state == UIGestureRecognizerStateEnded) {
		
		self.translation = CGPointZero;
		self.location = CGPointZero;
		
	}
	
}

- (void)viewDidLoad {
	
	[super viewDidLoad];
	
	self.tapGR = [[UIPanGestureRecognizer alloc]
								initWithTarget:self action:@selector(movePlayer:)];
	[self.view addGestureRecognizer:self.tapGR];
	
	self.map = [[IDRender alloc]init];
	
	IDRectangle *wall0 = [[IDRectangle alloc]init];
	
	wall0.a = CGPointMake(-10, -10);
	wall0.b = CGPointMake(-10, 10);
	wall0.c = CGPointMake(-15, 10);
	wall0.d = CGPointMake(-15, -10);
	
	IDRectangle *wall1 = [[IDRectangle alloc]init];
	
	wall1.a = CGPointMake(-10, 10);
	wall1.b = CGPointMake(10, 10);
	wall1.c = CGPointMake(10, 15);
	wall1.d = CGPointMake(-10, 15);
	
	IDRectangle *wall2 = [[IDRectangle alloc]init];
	
	wall2.a = CGPointMake(10, 10);
	wall2.b = CGPointMake(10, -10);
	wall2.c = CGPointMake(15, -10);
	wall2.d = CGPointMake(15, 10);
	
	IDRectangle *wall3 = [[IDRectangle alloc]init];
	
	wall3.a = CGPointMake(-10, -10);
	wall3.b = CGPointMake(10, -10);
	wall3.c = CGPointMake(10, -15);
	wall3.d = CGPointMake(-10, -15);
	
	IDRectangle *wall4 = [[IDRectangle alloc]init];
	
	wall4.a = CGPointMake(20, 20);
	wall4.b = CGPointMake(25, 20);
	wall4.c = CGPointMake(25, 25);
	wall4.d = CGPointMake(20, 25);
	
	IDRectangle *wall5 = [[IDRectangle alloc]init];
	
	wall5.a = CGPointMake(0, 0);
	wall5.b = CGPointMake(2, 0);
	wall5.c = CGPointMake(2, 2);
	wall5.d = CGPointMake(0, 2);
	
	self.map.player = [[IDCamera alloc]init];
	self.map.player.FOV = M_PI / 2.0;
	self.map.player.ROT = 0;
	self.map.player.POS = CGPointMake(-5, -5);
	self.map.player.bounds = self.view.frame.size;
	
	self.map.blocks = @[wall0,wall1,wall2,wall3,wall4,wall5];
	
	self.tick = [[IDTicker alloc]init];
	
	self.tick.render = self.map;
	self.tick.delegate = self;
	
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (NSUInteger)supportedInterfaceOrientations
{
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
		return UIInterfaceOrientationMaskLandscape;
	} else {
		return UIInterfaceOrientationMaskLandscape;
	}
}

- (BOOL)prefersStatusBarHidden {
	return YES;
}

@end