//
//  Orc.m
//  demoApp
//
//  Created by Jeremiah Bonham on 3/8/14.
//  Copyright (c) 2014 Jeremiah.Bonham. All rights reserved.
//

#import "Orc.h"

@implementation Orc

-(id)init
{
    self = [super init];
    if (self != nil)
    {
        [self setMonsterName:nil];
        [self setMonsterHP:5];
        [self setMonsterLevel:1];
        
    }
    return self;
}

-(void) calcMonsterHP
{
    
}

@end
