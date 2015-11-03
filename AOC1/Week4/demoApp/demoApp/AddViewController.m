//
//  AddViewController.m
//  demoApp
//
//  Created by Jeremiah Bonham on 2/22/14.
//  Copyright (c) 2014 Jeremiah.Bonham. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()

@end

@implementation AddViewController
@synthesize  eventInfo;
@synthesize  eventInfoString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

//Close Keyboard
-(IBAction)closeKey:(id)sender
{
    //checking for button click
    NSLog(@"Close");
    //close keyboard
    [eventInfo resignFirstResponder];
}

//clear text when clicked to edit
-(IBAction)clearEventText:(id)sender
{
    [eventInfo setText:@""];
}

- (BOOL) shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([eventInfo.text isEqual:@""] || [eventInfo.text isEqual:@"Enter New Event Here......"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Event" message:@"Event cannot be left blank or with the default message." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
            return NO;
        
    } else {
        eventInfoString = eventInfo.text;
   
}
return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
