//
//  ViewController.m
//  demoApp
//
//  Created by Jeremiah Bonham on 2/22/14.
//  Copyright (c) 2014 Jeremiah.Bonham. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(void) saveAll
{
    NSUserDefaults *storedData  = [NSUserDefaults standardUserDefaults];
    if (storedData != nil)
    {
        NSString *eventString = eventTextView.text;
        [storedData setObject:eventString forKey:@"event"];
        //Save Data
        [storedData synchronize];
    }
}


-(IBAction)onClick:(id)sender
{
    NSUserDefaults *storedData  = [NSUserDefaults standardUserDefaults];
    if (storedData != nil)
        {
            NSString *eventString = eventTextView.text;
            [storedData setObject:eventString forKey:@"event"];
            //Save Data
            [storedData synchronize];
        }
}

- (void)viewDidLoad
{
    NSUserDefaults *storedData  = [NSUserDefaults standardUserDefaults];
    if (storedData != nil)
    {
        NSString *eventString = [storedData objectForKey:@"event"];
        eventTextView.text = eventString;
    }
    
    ;
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)back:(UIStoryboardSegue *)segue
{
    
}


-(IBAction)done:(UIStoryboardSegue *)segue
{

    AddViewController *addNewSegue = segue.sourceViewController;
    NSString *newText = addNewSegue.eventInfoString;
    newText = [newText stringByAppendingString:@"\n\n"];
    eventTextView.text = [eventTextView.text stringByAppendingString:newText];
    
}





-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"unwindToVC"])
    {
        NSUserDefaults *storedData  = [NSUserDefaults standardUserDefaults];
        if (storedData != nil)
        {
            NSMutableString *eventString = [storedData objectForKey:@"event"];
            AddViewController *addViewSeg = segue.sourceViewController;
            eventString = [[NSMutableString alloc] init];
            [eventString appendString:addViewSeg.eventInfoString];
            [eventString appendString:@"\n"];
            [eventString appendString:eventInfo.text];
            
        }
        
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
