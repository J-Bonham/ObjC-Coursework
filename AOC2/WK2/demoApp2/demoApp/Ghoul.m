//
//  Ghoul.m
//  demoApp
//
//  Created by Jeremiah Bonham on 3/3/14.
//  Copyright (c) 2014 Jeremiah.Bonham. All rights reserved.
//

#import "Ghoul.h"

@implementation Ghoul

@synthesize monsterLevel;

-(NSString*)runAway
{
    if (silverWeakness == YES){
        NSString *silverYes = (@"You have silver, stand your ground!");
        return silverYes;
        } else if (silverWeakness == NO){
        NSString *silverNo = (@"You have no silver, you should run!");
        return silverNo;
        }
    return nil;
}

-(void)calcMonsterXP
{
    int silverweakness = 3;
    [self setMonsterXP:(self.monsterXP + silverweakness)];
}

@end
