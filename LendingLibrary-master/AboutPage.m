//
//  AboutPage.m
//  LendingLibrary
//
//  Created by Jeremiah Bonham on 9/21/14.
//  Copyright (c) 2014 Jeremiah.Bonham. All rights reserved.
//

#import "AboutPage.h"

@implementation AboutPage

- (IBAction)email:(id)sender{
    
    //open email in modal here
    NSLog(@"Email tapped");
    
    NSString *emailTitle = @"About Lending Library";
    //NSString *itemBorrowed = [[NSString alloc] initWithString:[_currentItem title]];
    NSString *messageBody = (@"Hello. I was just working with your app and.......(enter the bug you found, other issue, and other feedback you may have)........");
    
    NSArray *toRecipents = [NSArray arrayWithObject: @"jeremiah.bonham@gmail.com"];
    
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

-(IBAction)rate:(id)sender{
    
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.itunes.com/lendinglibrary"]];
}

@end
