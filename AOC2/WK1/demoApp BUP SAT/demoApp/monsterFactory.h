//
//  monsterFactory.h
//  demoApp
//
//  Created by Jeremiah Bonham on 3/3/14.
//  Copyright (c) 2014 Jeremiah.Bonham. All rights reserved.
//

#import <Foundation/Foundation.h>

//Base Class
#import "Monster.h"
//Sub Class
#import "Orc.h"
#import "Ghoul.h"
#import "Dragon.h"

@interface monsterFactory : NSObject

+(Monster *)summonMonster : (int)EnumMonsterType;

@end
