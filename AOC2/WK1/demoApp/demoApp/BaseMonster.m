//
//  BaseMonster.m
//  demoApp
//
//  Created by Jeremiah Bonham on 3/8/14.
//  Copyright (c) 2014 Jeremiah.Bonham. All rights reserved.
//

#import "BaseMonster.h"

@implementation BaseMonster

@synthesize monsterName, monsterType, monsterHP, monsterLevel;

-(id)init
{
    self = [super init];
    if (self != nil)
    {
        [self setMonsterName:nil];
        [self setMonsterType:monsterType[0]];
        [self setMonsterHP:5];
        [self setMonsterLevel:1];
    }
    return self;
}

-(void)calcMonsterThreat
{
    NSLog(@"The summoned Monster has threat level of %i",monsterHP * monsterLevel);
}

@end
