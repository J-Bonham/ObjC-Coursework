//
//  Dragon.m
//  demoApp
//
//  Created by Jeremiah Bonham on 3/3/14.
//  Copyright (c) 2014 Jeremiah.Bonham. All rights reserved.
//

#import "Dragon.h"

@implementation Dragon

@synthesize dragonLevel, monsterLevel, dragonType;

-(id)init
{
    if (dragonType == FIRE){
        [self setDragonLevel:15];
        
    } else if (dragonType == ACID){
        
        [self setDragonLevel:8];
    } else if (dragonType == ICE){
        
        [self setDragonLevel:3];
    }
    return self;
}

-(void)calcMonsterXP
{
    
}

@end

