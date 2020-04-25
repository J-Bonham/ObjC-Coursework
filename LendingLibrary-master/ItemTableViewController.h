//
//  ItemTableViewController.h
//  LendingLibrary
//
//  Created by Jeremiah Bonham on 9/15/14.
//  Copyright (c) 2014 Jeremiah.Bonham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddItemViewController.h"


@interface ItemTableViewController : UITableViewController <AddItemViewControllerDelegate, NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end
