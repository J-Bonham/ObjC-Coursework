//
//  ViewController.m
//  demoApp
//
//  Created by Jeremiah Bonham on 3/17/14.
//  Copyright (c) 2014 Jeremiah.Bonham. All rights reserved.
//
//  AOC2:Week3
//

#import "ViewController.h"
//import second view
#import "AddViewController.h"

@interface ViewController ()

@end

@implementation ViewController
//saving
-(void)DidSave:(NSString *)eventName
{
    NSString *stringFromField = eventTextView.text;
    if ([stringFromField isEqual: @""]) {
        NSString *stringWithCarReturn = [stringFromField stringByAppendingFormat:@"%@ \n", eventName];
        eventTextView.text = stringWithCarReturn;
    } else {
        NSString *newString = [stringFromField stringByAppendingFormat:@"%@ \n", eventName];
        eventTextView.text = newString;
    }
}

-(IBAction)onClick:(id)sender
{
    UIButton *button = (UIButton*)sender;
    if (button) {
        if (button.tag == 0) {
            AddViewController *addView = [[AddViewController alloc] initWithNibName:@"AddViewController" bundle:nil];
            if (addView) {
                 addView.delegate = (id)self;
                [self presentViewController:addView animated:TRUE completion:nil];
            }
        }
    }
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
