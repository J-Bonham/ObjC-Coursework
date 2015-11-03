//
//  Ghoul.h
//  demoApp
//
//  Created by Jeremiah Bonham on 3/3/14.
//  Copyright (c) 2014 Jeremiah.Bonham. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Monster.h"

@interface Ghoul : Monster
{
    BOOL silverWeakness;
}
-(void)calcMonsterXP;

@end
