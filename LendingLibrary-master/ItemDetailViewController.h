//
//  ItemDetailViewController.h
//  LendingLibrary
//
//  Created by Jeremiah Bonham on 9/15/14.
//  Copyright (c) 2014 Jeremiah.Bonham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"
#import <AddressBookUI/AddressBookUI.h>
#import <MessageUI/MessageUI.h>

@interface ItemDetailViewController : UIViewController <MFMailComposeViewControllerDelegate, ABPeoplePickerNavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *firstName;
@property (nonatomic, strong) Item *currentItem;
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextField *typeField;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *dateField;
@property (weak, nonatomic) IBOutlet UISlider *sliderValue;
@property (weak, nonatomic) IBOutlet UITextField *noteField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *contactsButton;
@property (weak, nonatomic) IBOutlet UIButton *reminderButton;
@property IBOutlet UISlider *slider;
@property IBOutlet UILabel *sliderText;
@property (weak, nonatomic) IBOutlet UIButton *cancelReminder;
@property NSDate *date;
@property (weak, nonatomic) IBOutlet UIView *modalWindow;

- (IBAction)cancelModal:(id)sender;
- (IBAction)showContacts:(id)sender;
- (IBAction)edit:(id)sender;
- (IBAction)done:(id)sender;
- (IBAction)email:(id)sender;
- (IBAction)setNotify:(id)sender;

- (IBAction)notifyinOneWeek:(id)sender;
- (IBAction)notifyinTwoWeeks:(id)sender;
- (IBAction)notifyinThreeWeeks:(id)sender;

@end
