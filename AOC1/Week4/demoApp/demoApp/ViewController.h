//
//  ViewController.h
//  demoApp
//
//  Created by Jeremiah Bonham on 2/22/14.
//  Copyright (c) 2014 Jeremiah.Bonham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddViewController.h"

@interface ViewController : UIViewController
{
    //adding IBOutlets
    IBOutlet UITextView *eventTextView;
    IBOutlet UITextField *eventInfo;
    NSString *eventInfoString;
}

//created onClick IBAction
-(IBAction)onClick:(id)sender;

@end