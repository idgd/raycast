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

#import "IDView.h"

@interface ViewController () <IDTickerDelegate>

@end

@implementation ViewController

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

- (void)ticked:(IDTicker *)ticker {
	((IDView *)self.view).renderPaths = self.map.renderLines;
	[self.view setNeedsDisplay];
}

- (void) movePlayer:(UIPanGestureRecognizer *)tapGR {
	CGPoint location = [self.tapGR translationInView:self.view];
	
	self.map.player.POS = CGPointMake(self.map.player.POS.x +
																			location.x / 200,
																			self.map.player.POS.y +
																			location.y / 200);
}

- (void)viewDidLoad {
	
	[super viewDidLoad];
	
	self.tapGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(movePlayer:)];
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
	wall5.b = CGPointMake(1, 0);
	wall5.c = CGPointMake(1, 1);
	wall5.d = CGPointMake(0, 1);
	
	self.map.player = [[IDCamera alloc]init];
	self.map.player.FOV = M_PI / 3;
	self.map.player.ROT = 0;
	self.map.player.POS = CGPointMake(-5, -5);
	self.map.player.bounds = self.view.frame.size;
	
	self.map.blocks = @[wall0, wall1, wall2, wall3, wall5];
	
	self.tick = [[IDTicker alloc]init];
	
	self.tick.render = self.map;
	self.tick.delegate = self;
	
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
