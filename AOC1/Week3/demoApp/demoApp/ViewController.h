//
//  ViewController.h
//  demoApp
//
//  Created by Jeremiah Bonham on 2/19/14.
//  Copyright (c) 2014 Jeremiah.Bonham. All rights reserved.
//
//  AOC1:Week3
//

#import <UIKit/UIKit.h>

#import "AddViewController.h"

@interface ViewController : UIViewController
{
    //adding IBOutlets
    IBOutlet UITextView *eventTextView;
    IBOutlet UIButton *addEvent;
}

//created onClick IBAction
-(IBAction)onClick:(id)sender;


@end
