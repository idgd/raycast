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
#import "IDEnemy.h"
#import "IDMazeWorld.h"
#import "IDBackgroundView.h"

#import "IDView.h"

@interface ViewController () <IDTickerDelegate>

@property(nonatomic, strong) IBOutlet IDView *gameView;

@end

@implementation ViewController

- (void)ticked:(IDTicker *)ticker {
	
	self.gameView.renderPaths = self.map.renderLines;
	self.gameView.enemyPaths = self.map.enemies;
	
	if(self.location.x <= self.gameView.bounds.size.width / 2.0) {
		
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
				
				[collRECT intersectionWithPoint:playerLine flag:&beep];
				if (beep) {
					newPoint = self.map.player.POS; //Well... this works better than using the intersection point :P Ideally we'd use the intersection point + a small margin of error, but this simulates that in an ok way.
				}
				
			}
			
		}
    
    self.map.player.POS = newPoint;

  } else {
		
		self.map.player.ROT += self.translation.x / 5000.0 * M_PI;
		
	}
	
	[self.gameView setNeedsDisplay];
	
}

- (void) movePlayer:(UIPanGestureRecognizer *)tapGR {
	
	if(tapGR.state == UIGestureRecognizerStateBegan) {
		
		self.location = [self.tapGR locationInView:self.gameView];
		
	} else if(tapGR.state == UIGestureRecognizerStateChanged) {
		
		self.translation = [self.tapGR translationInView:self.gameView];
		
	} else if(tapGR.state == UIGestureRecognizerStateEnded) {
		
		self.translation = CGPointZero;
		self.location = CGPointZero;
		
	}
	
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  self.gameView.frame = self.view.bounds;
  self.map.player.bounds = self.gameView.frame.size;
}

- (void)viewDidLoad {
	
	[super viewDidLoad];
  self.gameView.backgroundColor = [UIColor clearColor];
  self.gameView.opaque = NO;
  
	self.tapGR = [[UIPanGestureRecognizer alloc]
								initWithTarget:self action:@selector(movePlayer:)];
	[self.gameView addGestureRecognizer:self.tapGR];
	
	self.map = [[IDRender alloc]init];
	
	self.map.player = [[IDCamera alloc]init];
	self.map.player.FOV = M_PI / 3.0;
	self.map.player.ROT = -M_PI / 2.0;
	self.map.player.POS = CGPointMake(3.0, 3.0);
	
  self.map.blocks = [IDMazeWorld createWorld];
	
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