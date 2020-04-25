//
//  ItemDetailViewController.m
//  LendingLibrary
//
//  Created by Jeremiah Bonham on 9/15/14.
//  Copyright (c) 2014 Jeremiah.Bonham. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "AppDelegate.h"

@interface ItemDetailViewController ()

@end

@implementation ItemDetailViewController

@synthesize titleField, typeField, nameField, emailField, dateField, sliderValue, noteField, sliderText, date;


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
    date = [self.currentItem date];
    //NSLog(@"%@", date);
    
    NSDateFormatter *formattedDate = [[NSDateFormatter alloc]init];
    [formattedDate setDateFormat:@"MMMM dd YYYY"];
    dateField.text = [formattedDate stringFromDate:date];
    
    date = [self.currentItem date];
    NSNumber *sliderLength = [[NSNumber alloc] init];
        sliderLength = [self.currentItem length];

    NSString *sliderLengthText = [NSString stringWithFormat:@"%@", sliderLength];
    
    sliderLength = [self.currentItem length];
    
    float value = [sliderLength floatValue];;
    _slider.value = value;
    sliderText.text = sliderLengthText;
    [self.currentItem setLength:sliderLength];
    
    self.sliderText.text = [NSString stringWithFormat:@"%@", sliderLength];
    
    _contactsButton.hidden = YES;
    _saveButton.hidden = YES;
    _modalWindow.hidden = YES;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)edit:(id)sender{
    
    titleField.enabled = YES;
    typeField.enabled = YES;
    nameField.enabled = YES;
    emailField.enabled = YES;
    dateField.enabled = YES;
    _slider.enabled = YES;
    noteField.enabled = YES;

    titleField.borderStyle = UITextBorderStyleLine;
    typeField.borderStyle = UITextBorderStyleLine;
    nameField.borderStyle = UITextBorderStyleLine;
    emailField.borderStyle = UITextBorderStyleLine;
    dateField.borderStyle = UITextBorderStyleLine;
    noteField.borderStyle = UITextBorderStyleLine;
    
    _editButton.enabled = YES;
    _doneButton.hidden = NO;
    _saveButton.hidden = NO;
    _contactsButton.hidden = NO;
    _editButton.enabled = NO;

}

- (IBAction)done:(id)sender{
    
    titleField.enabled = NO;
    typeField.enabled = NO;
    nameField.enabled = NO;
    emailField.enabled = NO;
    dateField.enabled = NO;
    _slider.enabled = NO;
    noteField.enabled = NO;
    _contactsButton.hidden = YES;
    
    titleField.borderStyle = UITextBorderStyleNone;
    typeField.borderStyle = UITextBorderStyleNone;
    nameField.borderStyle = UITextBorderStyleNone;
    emailField.borderStyle = UITextBorderStyleNone;
    dateField.borderStyle = UITextBorderStyleNone;
    noteField.borderStyle = UITextBorderStyleNone;
    
    _editButton.enabled = YES;
    _doneButton.hidden = YES;
    _saveButton.hidden = YES;
    
    _currentItem.title = titleField.text;
    _currentItem.type = typeField.text;
    _currentItem.name = nameField.text;
    _currentItem.email = emailField.text;
    _currentItem.notes = noteField.text;
    
    NSString *dateStr = [[NSString alloc] init];
    dateStr = dateField.text;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMMM dd, yyyy"];
    NSDate *dateConverter = [dateFormat dateFromString:dateStr];
    _currentItem.date = dateConverter;
    
    
    
    NSNumber *sliderLength = [[NSNumber alloc] initWithFloat:floor(self.slider.value)];
    [self.currentItem setLength:sliderLength];
    
    self.sliderText.text = [NSString stringWithFormat:@"%@", sliderLength];
    
    AppDelegate *myAppDel = (AppDelegate *) [[UIApplication sharedApplication]delegate];
   
    [myAppDel saveContext];
    
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

(ABPeoplePickerNavigationController *)peoplePicker

      shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    [self displayPerson:person];
    
    [[peoplePicker presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    
    return NO;
    
}

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
    _contactsButton.hidden = YES;
   
}

- (IBAction)email:(id)sender{
    
    NSLog(@"Email tapped");
    NSString *emailTitle = @"Just a reminder";
    NSString *messageBody = (@"Hello. This is just a simple reminder that you borrowed an item from me a while ago and I was just looking to get it back soon.     Thank you");
    
    NSArray *toRecipents = [NSArray arrayWithObject: [_currentItem email]];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:YES];
    [mc setToRecipients:toRecipents];
    [self presentViewController:mc animated:YES completion:NULL];
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (IBAction)setNotify:(id)sender{
    
    _modalWindow.hidden = NO;

}

- (IBAction)cancelModal:(id)sender{
    
    _modalWindow.hidden = YES;
}



- (IBAction)notifyinOneWeek:(id)sender{
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:604800];
        localNotification.alertBody = @"Remeber, you have items on loan.";
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];

}

- (IBAction)notifyinTwoWeeks:(id)sender{
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:1209600];
    localNotification.alertBody = @"Remeber, you have items on loan.";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
}

- (IBAction)notifyinThreeWeeks:(id)sender{
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:1814400];
    localNotification.alertBody = @"Remeber, you have items on loan.";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
}

@end
