//
//  AddViewController.h
//  demoApp
//
//  Created by Jeremiah Bonham on 3/17/14.
//  Copyright (c) 2014 Jeremiah.Bonham. All rights reserved.
//
//  AOC2:Week3
//

#import <UIKit/UIKit.h>
//Save delegate
@protocol SaveEventDelegate <NSObject>
//setting addEventText as required
@required
-(void)DidSave:(NSString*)addEventText;

@end

@interface AddViewController : UIViewController <UITextFieldDelegate>

{
    id<SaveEventDelegate> delegate;
    IBOutlet UITextField *addEventText;
    IBOutlet UIDatePicker *datePicker;
    NSString *dateText;
    NSString *newEvent;
}

@property (nonatomic, retain)IBOutlet UIDatePicker *datePicker;

@property (strong) id<SaveEventDelegate> delegate;

@end