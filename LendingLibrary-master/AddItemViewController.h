//
//  AddItemViewController.h
//  LendingLibrary
//
//  Created by Jeremiah Bonham on 9/15/14.
//  Copyright (c) 2014 Jeremiah.Bonham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"
#import <AddressBookUI/AddressBookUI.h>

@protocol AddItemViewControllerDelegate;

@interface AddItemViewController : UIViewController <ABPeoplePickerNavigationControllerDelegate,  UITextFieldDelegate>


@property (weak, nonatomic) NSString *nameVal;
@property (weak, nonatomic) UILabel *firstName;
@property (weak, nonatomic) UILabel *email;

@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextField *typeField;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *dateField;
@property (weak, nonatomic) IBOutlet UISlider *sliderValue;
@property (weak, nonatomic) NSString *sliderLengthText;

@property (weak, nonatomic) IBOutlet UITextField *noteField;
@property IBOutlet UISlider *slider;
@property IBOutlet UILabel *sliderText;

@property (strong,nonatomic) NSDate *date;
@property IBOutlet UIDatePicker *datePicker;
@property (nonatomic, weak) id <AddItemViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *selectDate;
@property (nonatomic, strong) Item *currentItem;
- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;
- (IBAction)showContacts:(id)sender;
- (IBAction)selectDate:(id)sender;
- (IBAction)showDateSelectButton:(id)sender;
- (IBAction)updateLabelFromPicker:(id)sender;

@end

@protocol AddItemViewControllerDelegate

-(void)addItemDidSave;
-(void)addItemCanceled:(Item *)itemToDelete;

@end


