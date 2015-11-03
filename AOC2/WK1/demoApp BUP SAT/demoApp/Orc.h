//
//  Orc.h
//  demoApp
//
//  Created by Jeremiah Bonham on 3/3/14.
//  Copyright (c) 2014 Jeremiah.Bonham. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Monster.h"

@interface Orc : Monster
{
    int orcType;
}

typedef enum {ARCHER, CHIEF, PEON}orcType;




@end
