//
//  LocalLBData.m
//  Galactic Courier
//
//  Created by Jeremiah Bonham on 6/17/15.
//  Copyright (c) 2015 Jeremiah.Bonham. All rights reserved.
//

#import "LocalLBData.h"

@implementation LocalLBData

@synthesize scoreValue;
@synthesize playerName;

-(id)initWithCoder:(NSCoder *)code{
    
    if (self = [super init]){
        
        self.playerName = [code decodeObjectForKey:@"name"];
        self.scoreValue = [code decodeObjectForKey:@"score"];
    }
    
    return self;
    
}

-(void) encodeWithCoder:(NSCoder *)code{
    
    [code encodeObject:playerName forKey:@"name"];
    [code encodeObject:scoreValue forKey:@"score"];
    
}

@end
