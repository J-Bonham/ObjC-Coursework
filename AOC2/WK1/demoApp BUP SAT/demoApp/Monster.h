//
//  Monster.h
//  demoApp
//
//  Created by Jeremiah Bonham on 3/3/14.
//  Copyright (c) 2014 Jeremiah.Bonham. All rights reserved.
//

//Generic Base Class - Monster

#import <Foundation/Foundation.h>

@interface Monster : NSObject
{
    int EnumMonsterType;
}

typedef enum {ORC,GHOUL,DRAGON}EnumMonsterType;

@property NSString *monsterName;
@property NSArray *monsterType;
@property int monsterLevel;


-(id)init;

-(void)calcMonsterHP;

@end


