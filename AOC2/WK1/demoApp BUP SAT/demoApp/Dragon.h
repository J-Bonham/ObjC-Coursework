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
    int *dragonType;
}

typedef enum {FIRE, ACID, ICE}dragonType;

@property int dType;
@property int hp;
@property int level;

@end
