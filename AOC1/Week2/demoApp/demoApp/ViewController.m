//
//  ViewController.m
//  demoApp
//
//  Created by Jeremiah Bonham on 2/12/14.
//  Copyright (c) 2014 Jeremiah.Bonham. All rights reserved.
//
//  Week2 Project
//
//  AOC1: 1402
//
//  Create and call methods
//
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

//1
//Create a method called Add. This method will take two NSInteger or int types and return the result of an addition between these two.

- (int)add:(int)num1 num2:(int)num2
{
    return num1 + num2;
}

//2
//Create a BOOL method called Compare that takes two NSInteger values. Return YES or NO based on whether the values are equal.

- (BOOL)compare:(NSInteger)num3 num4:(NSInteger)num4
{
    if (num3 == num4){
        return YES;
    } else {
        return NO;
    }
}

//3
//Create a method called Append. This method will take two NSStrings and return a new NSString containing the appended strings using an NSMutableString and the appendString method.

- (NSString*)append:(NSString*)string1 string2:(NSString*)string2
{
    NSMutableString *newString = [[NSMutableString alloc] init];
    [newString appendFormat:@"%@ %@", string1, string2];
    return newString;
}

//4
//Create a method called DisplayAlertWithString. This method will take as a parameter an NSString. Take the passed in NSString and display it in an alert view using UIAlertView. You may pass in a second string to use as the Alert's title, if you like.

- (void)displayAlertWithString:(NSString*)alertString title:(NSString*)title
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@", title] message:[NSString stringWithFormat:@"%@", alertString] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    if (alertView != nil) {
        [alertView show];
    }
}

- (void)viewDidLoad
{
    //1
    //Call the Append method with two NSStrings. Capture the result in a variable and display a UIAlertView with the appended string using displayAlertWithString.
    
    NSString *string1 = (@"This is a demonstration of");
    NSString *string2 = (@"appending strings.");
    NSString *appendedString = [self append:string1 string2:string2];
    
    [self displayAlertWithString:appendedString title:@"Appending Strings"];
    
    
    //2
    //Call the Add function passing in two integer values. Capture the return of this function into a variable.
    //3
    //Bundle the returned integer into an NSNumber and then convert it to a NSString and pass it to the DisplayAlertWithString function.
    //4
    //Give it some text for the title. The message will read, "The number is 00". Replace the 00 with the integer passed into the function.
   
    // 6. Call the Add function passing in two integer values. Capture the return of this function into a variable.
    
    int num1 = 40;
    int num2 = 2;
    int additionResult = [self add:num1 num2:num2];
    
    NSNumber *intConvertedtoNum = [[NSNumber alloc] initWithInt:additionResult];
    NSString *numbToString = [intConvertedtoNum stringValue];
    NSString *theNumIs = @"The number is ";
    NSString *finalOutput = [theNumIs stringByAppendingString:numbToString];
    
    [self displayAlertWithString:finalOutput title: @"The Answer to life, the Universe, and everything."];
    
    //5
    //Call the Compare function with two integer values. If Compare returns YES, display an UIAlertView both with the input values and the result using the DisplayAlertWithString function
    
    NSInteger value1 = 5;
    NSInteger value2 = 5;
    BOOL numCompare = [self compare:value1 num4:value2];
    if (numCompare) {
        NSString *numCompareString = [NSString stringWithFormat:@"Value 1 is %ld, and Value 2 is %ld. These are the same.", (long)value1, (long)value2];
        [self displayAlertWithString:numCompareString title:@"Comparing"];
    }

    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
