//
//  Orc.h
//  demoApp
//
//  Created by Jeremiah Bonham on 3/8/14.
//  Copyright (c) 2014 Jeremiah.Bonham. All rights reserved.
//

#import "BaseMonster.h"

@interface Orc : BaseMonster
{
    int orcType;
}

typedef enum {ARCHER, CHIEF, PEON}orcType;


@end
