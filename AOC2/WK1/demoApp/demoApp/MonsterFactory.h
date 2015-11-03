//
//  MonsterFactory.h
//  demoApp
//
//  Created by Jeremiah Bonham on 3/8/14.
//  Copyright (c) 2014 Jeremiah.Bonham. All rights reserved.
//

#import <Foundation/Foundation.h>


//Base Class
#import "BaseMonster.h"
//Sub Class
#import "Orc.h"
//#import "Ghoul.h"
//#import "Dragon.h"

@interface MonsterFactory : NSObject

+(BaseMonster *)summonMonster : (int)EnumMonsterType;

@end

