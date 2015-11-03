//
//  AddViewController.h
//  demoApp
//
//  Created by Jeremiah Bonham on 2/22/14.
//  Copyright (c) 2014 Jeremiah.Bonham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface AddViewController : UIViewController
{
    IBOutlet UITextField *eventInfo;
    NSString *eventInfoString;
    
   }

@property IBOutlet UITextField *eventInfo;
@property NSString *eventInfoString;

@end
