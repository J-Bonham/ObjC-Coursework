//
//  AddItemViewController.m
//  LendingLibrary
//
//  Created by Jeremiah Bonham on 9/15/14.
//  Copyright (c) 2014 Jeremiah.Bonham. All rights reserved.
//

#import "AddItemViewController.h"

@interface AddItemViewController ()

@end

@implementation AddItemViewController

@synthesize titleField, typeField, nameField, emailField, dateField, sliderValue, noteField, slider, datePicker;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil

{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    titleField.text = [self.currentItem title];
    typeField.text = [self.currentItem type];
    nameField.text = [self.currentItem name];
    emailField.text = [self.currentItem email];
    noteField.text = [self.currentItem notes];
    
    datePicker.hidden = YES;
    _selectDate.hidden = YES;
    
    NSNumber *sliderLength = [[NSNumber alloc] initWithFloat:floor(self.slider.value)];
    NSString *sliderLengthText = [NSString stringWithFormat:@"%@", sliderLength];
    _sliderText.text = sliderLengthText;
  
    datePicker.date = [self.currentItem date];
    NSDateFormatter *formattedDate = [[NSDateFormatter alloc]init];

    [formattedDate setDateFormat:@"MMMM dd, yyyy"];
    dateField.text = [formattedDate stringFromDate:_date];
    
    dateField.delegate = self;
    
   datePicker = [[UIDatePicker alloc]init];
   [datePicker setDatePickerMode:UIDatePickerModeDate];

    self.dateField.inputView = datePicker;
}

- (IBAction)showDateSelectButton:(id)sender{
    _selectDate.hidden = NO;

}

- (IBAction)updateLabelFromPicker:(id)sender {
    
    NSDateFormatter *formattedDate = [[NSDateFormatter alloc]init];
    [formattedDate setDateFormat:@"MMMM dd, yyyy"];
    self.dateField.text = [formattedDate stringFromDate:self.datePicker.date];
    self.dateField.text = [formattedDate stringFromDate:datePicker.date];
}

- (IBAction)selectDate:(id)sender{
    
    [self.dateField resignFirstResponder];
    _selectDate.hidden = YES;
    
    
    NSDate *pickedDate = [self.datePicker date];
    [self.currentItem setDate:pickedDate];
    NSLog(@"%@", pickedDate);
    
    NSDateFormatter *formattedDate = [[NSDateFormatter alloc]init];
    [formattedDate setDateFormat:@"yyyy MMMM dd"];
    NSString *datePickedText = [[NSString alloc] init];
    datePickedText = [formattedDate stringFromDate:datePicker.date];
    self.dateField.text = datePickedText;
    NSLog(@"%@", datePickedText);



    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender{
    [self.delegate addItemCanceled:[self currentItem]];
}


//when save is clicked
- (IBAction)save:(id)sender{
    
    [self.currentItem setTitle:titleField.text];
    [self.currentItem setType:typeField.text];
    [self.currentItem setName:nameField.text];
    [self.currentItem setEmail:emailField.text];
    
    NSNumber *sliderLength = [[NSNumber alloc] initWithFloat:floor(self.slider.value)];
    NSString *sliderLengthText = [NSString stringWithFormat:@"%@", sliderLength];
    _sliderText.text = sliderLengthText;
    [self.currentItem setLength:sliderLength];
    
    NSDate *pickedDate = [self.datePicker date];
    [self.currentItem setDate:pickedDate];
    NSLog(@"%@", pickedDate);

    [self.currentItem setNotes:noteField.text];
    [self.delegate addItemDidSave];
    
}

- (void)viewDidUnload
{
    [self setTitleField:nil];
    [self setNameField:nil];
    [self setTypeField:nil];
    [self setEmailField:nil];
    [self setNoteField:nil];
   
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (IBAction)showContacts:(id)sender
{
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];;
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [[peoplePicker presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}


- (BOOL)peoplePickerNavigationController:

    (ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    [self displayPerson:person];
    
    [[peoplePicker presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    
    return NO;
    
}

//pulls contacts
- (void)displayPerson:(ABRecordRef)person

{
    NSString* name = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    self.firstName.text = name;
    nameField.text = name;
    NSString* emailAd = nil;
    ABMultiValueRef emailAdDetails = ABRecordCopyValue(person, kABPersonEmailProperty);
    
    if (ABMultiValueGetCount(emailAdDetails) > 0) {
        emailAd = (__bridge_transfer NSString*)
        ABMultiValueCopyValueAtIndex(emailAdDetails, 0);
    } else {
        emailAd = @"[None]";
    }
    self.email.text = emailAd;
    emailField.text = emailAd;
    CFRelease(emailAdDetails);
}

- (BOOL)peoplePickerNavigationController:

(ABPeoplePickerNavigationController *)peoplePicker

      shouldContinueAfterSelectingPerson:(ABRecordRef)person
                                property:(ABPropertyID)property
                              identifier:(ABMultiValueIdentifier)identifier

    {
    return NO;
}




- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    [self peoplePickerNavigationController:peoplePicker shouldContinueAfterSelectingPerson:person property:property identifier:identifier];
    NSString* emailAd = nil;
    ABMultiValueRef emailAdDetails = ABRecordCopyValue(person, kABPersonEmailProperty);
    
    NSString* name = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    self.firstName.text = name;
    nameField.text = name;

    
    if (ABMultiValueGetCount(emailAdDetails) > 0) {
        emailAd = (__bridge_transfer NSString*)
        ABMultiValueCopyValueAtIndex(emailAdDetails, 0);
    } else {
        emailAd = @"[None]";
    }
    self.email.text = emailAd;
    emailField.text = emailAd;
    CFRelease(emailAdDetails);
    
}

//Close Keyboard when Touching outside of the textfields
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)sliderValueChanged:(id)sender
{
    // Set the label text to the value of the slider as it changes
    self.sliderText.text = [NSString stringWithFormat:@"%0.f", floor(self.slider.value)];
}

@end
