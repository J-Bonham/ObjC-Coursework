//
//  Monster.m
//  demoApp
//
//  Created by Jeremiah Bonham on 3/3/14.
//  Copyright (c) 2014 Jeremiah.Bonham. All rights reserved.
//

#import "Monster.h"

@implementation Monster

@synthesize monsterHP, monsterName, monsterType, monsterLevel, monsterXP;

-(id)init
{
    self = [super init];
    if (self != nil)
    {
     monsterLevel = 1;
        monsterXP = 15;
    }
    return self;
}


-(void)calcMonsterXP;
{

}

@end
