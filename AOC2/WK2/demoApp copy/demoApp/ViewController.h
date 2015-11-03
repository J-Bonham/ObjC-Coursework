//
//  ViewController.h
//  demoApp
//
//  Created by Jeremiah Bonham on 3/3/14.
//  Copyright (c) 2014 Jeremiah.Bonham. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "monsterFactory.h"

@interface ViewController : UIViewController
{
    IBOutlet UIButton *orcButton;
    IBOutlet UIButton *ghoulButton;
    IBOutlet UIButton *dragonButton;
    
    IBOutlet UILabel *stepLabel;
    IBOutlet UIStepper *monsterStep;
    IBOutlet UIButton *calcXPButton;
    IBOutlet UITextField *totalXP;
    
}

-(IBAction)onMonsterButtonClick:(id)sender;
-(IBAction)stepperClick:(id)sender;
-(IBAction)calcXP:(id)sender;

@end
