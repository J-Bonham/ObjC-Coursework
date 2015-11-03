//
//  Orc.m
//  demoApp
//
//  Created by Jeremiah Bonham on 3/3/14.
//  Copyright (c) 2014 Jeremiah.Bonham. All rights reserved.
//

#import "Orc.h"

@implementation Orc

@synthesize HP;

-(id)init
{
    self = [super init];
    if (self != nil)
    {
        [self setHitPoints:5];
        [self setMonsterName:nil];
    }
    return self;
}

-(void)calcMonsterHP
{

}

@end
