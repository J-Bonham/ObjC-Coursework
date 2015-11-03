//
//  Monster.m
//  demoApp
//
//  Created by Jeremiah Bonham on 3/3/14.
//  Copyright (c) 2014 Jeremiah.Bonham. All rights reserved.
//

#import "Monster.h"

@implementation Monster

@synthesize monsterHP, monsterName, monsterType, monsterLevel;

-(id)init
{
    self = [super init];
    if (self != nil)
    {
        [self setMonsterHP:1];
        [self setMonsterName:nil];
        [self setMonsterType:nil];
        [self setMonsterLevel:1];
    }
    return self;
}


-(void)calcMonsterXP;
{
    
}

@end
