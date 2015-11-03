//
//  Orc.m
//  demoApp
//
//  Created by Jeremiah Bonham on 3/3/14.
//  Copyright (c) 2014 Jeremiah.Bonham. All rights reserved.
//

#import "Orc.h"

@implementation Orc

@synthesize monsterLevel, orcType;

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(int)summonOrc
{
   
    if (orcType == PEON)
    {
        return -3;
    }
    
    else if (orcType == ARCHER)
    {
        return 2;
    }
    
    else if (orcType == CHIEF)
    {
        return 5;
    } else {
        return 0;
    }
}

-(void)calcMonsterXP
{
    
}
     
@end
