//
//  Item.h
//  LendingLibrary
//
//  Created by Jeremiah Bonham on 9/15/14.
//  Copyright (c) 2014 Jeremiah.Bonham. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Item : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * length;
@property (nonatomic, retain) NSString * notes;

@end
