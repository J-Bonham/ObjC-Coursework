//
//  BaseMonster.h
//  demoApp
//
//  Created by Jeremiah Bonham on 3/8/14.
//  Copyright (c) 2014 Jeremiah.Bonham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseMonster : NSObject
{
    int EnumMonsterType;
}

typedef enum {ORC,GHOUL,DRAGON}EnumMonsterType;

@property NSString *monsterName;
@property NSArray *monsterType;
@property int monsterHP;
@property int monsterLevel;

-(id)init;

-(void)calcMonsterThreat;

@end
