//
//  monsterFactory.m
//  demoApp
//
//  Created by Jeremiah Bonham on 3/3/14.
//  Copyright (c) 2014 Jeremiah.Bonham. All rights reserved.
//

#import "monsterFactory.h"

@implementation monsterFactory

+(Monster *)summonMonster : (int)EnumMonsterType;
{
    //Create Orc
    if (EnumMonsterType == ORC)
        {
        return [[Orc alloc] init];
        }
    //Create Ghoul
    else if (EnumMonsterType == GHOUL)
        {
        return [[Ghoul alloc] init];
        }
    //Create Dragon
    else if (EnumMonsterType == DRAGON)
        {
        return [[Dragon alloc] init];
        } else {
            
        return nil;
    }
}

@end
