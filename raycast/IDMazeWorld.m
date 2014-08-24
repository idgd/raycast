//
//  IDMazeWorld.m
//  raycast
//
//  Created by Isaac Dudney on 8/24/14.
//  Copyright (c) 2014 Isaac Dudney. All rights reserved.
//

#import "IDMazeWorld.h"

#import "IDRectangle.h"

@implementation IDMazeWorld

+ (NSArray *) createWorld {
	
	IDRectangle *wall0 = [[IDRectangle alloc]init];
	
	wall0.a = CGPointMake(-5, 5);
	wall0.b = CGPointMake(-5, -70);
	wall0.c = CGPointMake(-10, -70);
	wall0.d = CGPointMake(-10, 5);
	
	IDRectangle *wall1 = [[IDRectangle alloc]init];
	
	wall1.a = CGPointMake(-5, 5);
	wall1.b = CGPointMake(25, 5);
	wall1.c = CGPointMake(25, 10);
	wall1.d = CGPointMake(-5, 10);
	
	IDRectangle *wall2 = [[IDRectangle alloc]init];
	
	wall2.a = CGPointMake(25, 5);
	wall2.b = CGPointMake(25, -70);
	wall2.c = CGPointMake(30, -70);
	wall2.d = CGPointMake(30, 5);
	
	IDRectangle *wall3 = [[IDRectangle alloc]init];
	
	wall3.a = CGPointMake(25, -70);
	wall3.b = CGPointMake(-5, -70);
	wall3.c = CGPointMake(-5, -75);
	wall3.d = CGPointMake(25, -75);
	
	IDRectangle *wall4 = [[IDRectangle alloc]init];
	
	wall4.a = CGPointMake(1, 5);
	wall4.b = CGPointMake(1, -10);
	wall4.c = CGPointMake(2, -10);
	wall4.d = CGPointMake(2, 5);
	
	IDRectangle *wall5 = [[IDRectangle alloc]init];
	
	wall5.a = CGPointMake(1, -15);
	wall5.b = CGPointMake(1, -30);
	wall5.c = CGPointMake(2, -30);
	wall5.d = CGPointMake(2, -15);
	
	IDRectangle *wall6 = [[IDRectangle alloc]init];
	
	wall6.a = CGPointMake(1, -30);
	wall6.b = CGPointMake(6, -30);
	wall6.c = CGPointMake(6, -31);
	wall6.d = CGPointMake(1, -31);
	
	IDRectangle *wall7 = [[IDRectangle alloc]init];
	
	wall7.a = CGPointMake(1, -35);
	wall7.b = CGPointMake(1, -50);
	wall7.c = CGPointMake(2, -50);
	wall7.d = CGPointMake(2, -35);
	
	IDRectangle *wall8 = [[IDRectangle alloc]init];
	
	wall8.a = CGPointMake(1, -40);
	wall8.b = CGPointMake(-5, -40);
	wall8.c = CGPointMake(-5, -41);
	wall8.d = CGPointMake(1, -41);
	
	IDRectangle *wall9 = [[IDRectangle alloc]init];
	
	wall9.a = CGPointMake(1, -55);
	wall9.b = CGPointMake(1, -70);
	wall9.c = CGPointMake(2, -70);
	wall9.d = CGPointMake(2, -55);
	
	IDRectangle *wall10 = [[IDRectangle alloc]init];
	
	wall10.a = CGPointMake(6, 5);
	wall10.b = CGPointMake(6, -50);
	wall10.c = CGPointMake(7, -50);
	wall10.d = CGPointMake(7, 5);
	
	IDRectangle *wall11 = [[IDRectangle alloc]init];
	
	wall11.a = CGPointMake(6, -55);
	wall11.b = CGPointMake(6, -70);
	wall11.c = CGPointMake(7, -70);
	wall11.d = CGPointMake(7, -55);
	
	IDRectangle *wall12 = [[IDRectangle alloc]init];
	
	wall12.a = CGPointMake(7, 0);
	wall12.b = CGPointMake(7, -1);
	wall12.c = CGPointMake(12, -1);
	wall12.d = CGPointMake(12, 0);
	
	IDRectangle *wall13 = [[IDRectangle alloc]init];
	
	wall13.a = CGPointMake(7, -5);
	wall13.b = CGPointMake(7, -6);
	wall13.c = CGPointMake(12, -6);
	wall13.d = CGPointMake(12, -5);
	
	IDRectangle *wall14 = [[IDRectangle alloc]init];
	
	wall14.a = CGPointMake(7, -55);
	wall14.b = CGPointMake(7, -56);
	wall14.c = CGPointMake(12, -56);
	wall14.d = CGPointMake(12, -55);
	
	IDRectangle *wall15 = [[IDRectangle alloc]init];
	
	wall15.a = CGPointMake(6, 5);
	wall15.b = CGPointMake(6, -50);
	wall15.c = CGPointMake(7, -50);
	wall15.d = CGPointMake(7, 5);
	
	IDRectangle *wall16 = [[IDRectangle alloc]init];
	
	wall16.a = CGPointMake(7, -45);
	wall16.b = CGPointMake(7, -44);
	wall16.c = CGPointMake(12, -44);
	wall16.d = CGPointMake(12, -45);
	
	IDRectangle *wall17 = [[IDRectangle alloc]init];
	
	wall17.a = CGPointMake(12, -45);
	wall17.b = CGPointMake(12, -50);
	wall17.c = CGPointMake(11, -50);
	wall17.d = CGPointMake(11, -45);
	
	IDRectangle *wall18 = [[IDRectangle alloc]init];
	
	wall18.a = CGPointMake(12, -30);
	wall18.b = CGPointMake(12, -35);
	wall18.c = CGPointMake(11, -35);
	wall18.d = CGPointMake(11, -30);
	
	IDRectangle *wall19 = [[IDRectangle alloc]init];
	
	wall19.a = CGPointMake(12, -25);
	wall19.b = CGPointMake(12, -15);
	wall19.c = CGPointMake(11, -15);
	wall19.d = CGPointMake(11, -25);
	
	IDRectangle *wall20 = [[IDRectangle alloc]init];
	
	wall20.a = CGPointMake(12, -10);
	wall20.b = CGPointMake(12, -5);
	wall20.c = CGPointMake(11, -5);
	wall20.d = CGPointMake(11, -10);
	
	NSArray *world = @[wall0,wall1,wall2,wall3,wall4,wall5,wall6,wall7,wall8,wall9,wall10,wall11,wall12,wall13,wall14,wall15,wall16,wall17,wall18,wall19,wall20];
	
	return world;
}

@end
