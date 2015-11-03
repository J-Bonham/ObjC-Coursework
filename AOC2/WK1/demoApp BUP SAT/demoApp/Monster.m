//
//  Monster.m
//  demoApp
//
//  Created by Jeremiah Bonham on 3/3/14.
//  Copyright (c) 2014 Jeremiah.Bonham. All rights reserved.
//

#import "Monster.h"

@implementation Monster

@synthesize monsterName, monsterType, monsterLevel;

-(id)init
{
    self = [super init];
    if (self != nil)
    {
        [self setMonsterName:nil];
        [self setMonsterType:monsterType[0]];
        [self setMonsterLevel:2];

    }
    return self;
}

-(void)calcMonsterHP
{
   
}

@end
