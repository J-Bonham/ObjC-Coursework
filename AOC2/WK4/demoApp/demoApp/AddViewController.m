//
//  AddViewController.m
//  demoApp
//
//  Created by Jeremiah Bonham on 3/17/14.
//  Copyright (c) 2014 Jeremiah.Bonham. All rights reserved.
//
//  AOC2:Week3
//

#import "AddViewController.h"

@interface AddViewController ()

@end
@implementation AddViewController
@synthesize delegate, datePicker;

//Save Action
-(IBAction)save:(id)sender
{
        if (delegate) {
               if ([addEventText.text isEqual:@""] || [addEventText.text isEqual:@"Enter New Event Here......"])
               {
                   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Event" message:@"Event cannot be left blank or with the default message." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                if (alert)
                {
                [alert show];
                }
               } else {
            datePicker.minimumDate = [NSDate date];
            NSDate *datePicked = [datePicker date];
                   if(datePicked != nil)
                   {
                       NSDateFormatter *formattedDate = [[NSDateFormatter alloc]init];
                       if (formattedDate != nil)
                       {
                           [formattedDate setDateFormat:@"MMMM dd, h:mm a"];
                       }
                       dateText = [formattedDate stringFromDate:datePicked];
                   }

                   [self dismissViewControllerAnimated:TRUE completion:nil];
                   if (delegate != nil)
                   {
                       newEvent = [NSString stringWithFormat:@"%@ \n%@\n", dateText, addEventText.text];
                       [delegate DidSave:newEvent];
                   }
               }
                   
        }
}

//Close Keyboard
-(IBAction)closeKey:(id)sender
{
    //checking for button click
    NSLog(@"Close");
    //close keyboard
    [addEventText resignFirstResponder];
}

//clear text when clicked to edit
-(IBAction)clearEventText:(id)sender
{
    [addEventText setText:@""];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end