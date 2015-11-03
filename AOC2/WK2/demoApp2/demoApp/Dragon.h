//
//  Dragon.h
//  demoApp
//
//  Created by Jeremiah Bonham on 3/3/14.
//  Copyright (c) 2014 Jeremiah.Bonham. All rights reserved.
//

#import "Monster.h"

@interface Dragon : Monster
{
    int dragonType;
}
//Dragon Types
typedef enum {FIRE, ACID, ICE}dragonType;

@property int dragonType;
@property int monsterLevel;
@property int dragonLevel;

-(void)calcMonsterXP;

@end
