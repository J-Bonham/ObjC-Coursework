//
//  AddViewController.h
//  demoApp
//
//  Created by Jeremiah Bonham on 2/19/14.
//  Copyright (c) 2014 Jeremiah.Bonham. All rights reserved.
//
//  AOC1:Week3
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
}
//Had trouble seperating the tag of each onClick, went with seperate buttons until I get better
//-(IBAction)onClick:(id)sender;

@property (strong) id<SaveEventDelegate> delegate;

@end