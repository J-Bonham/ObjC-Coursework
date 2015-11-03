//
//  Dragon.m
//  demoApp
//
//  Created by Jeremiah Bonham on 3/3/14.
//  Copyright (c) 2014 Jeremiah.Bonham. All rights reserved.
//

#import "Dragon.h"

@implementation Dragon

@synthesize dType, hp, level;

-(id)init
{
    if (dType == FIRE){
        [self setHitPoints:(hp *10)];
        [self setLevel:5];
    } else if (dType == ACID){
        [self setHitPoints:(hp *8)];
        [self setLevel:8];
    } else if (dType == ICE){
        [self setHitPoints:(hp *5)];
        [self setLevel:3];
    }
    return self;
}

-(void)calcMonsterHP
{    
    [self setHitPoints:(hp * level)];
    NSLog(@"The summoned Dragon has %i hitpoints", self.hitPoints);
}

@end

