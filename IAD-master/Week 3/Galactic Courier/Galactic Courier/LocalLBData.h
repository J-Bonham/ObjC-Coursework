//
//  LocalLBData.h
//  Galactic Courier
//
//  Created by Jeremiah Bonham on 6/17/15.
//  Copyright (c) 2015 Jeremiah.Bonham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalLBData : NSObject <NSCoding>

@property (nonatomic) NSNumber *scoreValue;
@property (nonatomic, strong) NSString *playerName;

@end
