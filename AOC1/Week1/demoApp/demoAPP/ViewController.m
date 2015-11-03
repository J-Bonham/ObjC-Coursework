//
//  ViewController.m
//  demoAPP
//
//  Created by Jeremiah Bonham on 2/7/14.
//  Copyright (c) 2014 Jeremiah.Bonham. All rights reserved.
//
// UITextAlignment.... was throwing errors, so after a bit of research, I changed them to NSTextAlignment... to get rid of errors
//
// AOC1: 1402
// Week 1 Assignment
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    // BackGround Color
    self.view.backgroundColor = [UIColor colorWithRed:0.361 green:0.71 blue:0.596 alpha:1];
    
    // Title Label
    title = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 20.0f, 320.0f, 40.0f)];
    //Check for label creation
    if (title != nil)
    {
        title.backgroundColor = [UIColor colorWithRed:0.114 green:0.208 blue:0.239 alpha:1];
        title.text = @"The Hitchhiker's Guide to the Galaxy";
        title.textAlignment = NSTextAlignmentCenter;
        title.textColor = [UIColor whiteColor];
        title.font = [UIFont boldSystemFontOfSize:(18)];
    }
    
    //Author Label
    author = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 70.0f, 100.0f, 30.0f)];
    //Check for label creation
    if (author != nil)
    {
        author.backgroundColor = [UIColor colorWithRed:0.204 green:0.373 blue:0.431 alpha:1];
        author.text = @"Author:";
        author.textAlignment = NSTextAlignmentRight;
        author.textColor = [UIColor colorWithRed:0.467 green:0.851 blue:0.98 alpha:1];
    }
    
    //AuthorName Label
    authorName = [[UILabel alloc] initWithFrame:CGRectMake(100.0f, 70.0f, 220.0f, 30.0f)];
    //Check for label creation
    if (authorName != nil)
    {
        authorName.backgroundColor = [UIColor colorWithRed:0.467 green:0.851 blue:0.98 alpha:1];
        authorName.text = @"Douglas Adams";
        authorName.textColor = [UIColor purpleColor];
        //Not needed, as left is the default, there for demonstration purpose only
        authorName.textAlignment = NSTextAlignmentLeft;
    }
  
    //Published Label
    published = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 110.0f, 100.0f, 30.0f)];
    //Check for label creation
    if (published != nil)
    {
        published.backgroundColor = [UIColor colorWithRed:0.953 green:0.455 blue:0.149 alpha:1];
        published.text = @"Published:";
        published.textAlignment = NSTextAlignmentRight;
        published.textColor = [UIColor colorWithRed:0.984 green:0.906 blue:0.396 alpha:1];
    }

    //PublishedDate Label
    publishedDate = [[UILabel alloc] initWithFrame:CGRectMake(100.0f, 110.0f, 220.0f, 30.0f)];
    //Check for label creation
    if (publishedDate != nil)
    {
        publishedDate.backgroundColor = [UIColor colorWithRed:0.984 green:0.906 blue:0.396 alpha:1];
        publishedDate.text = @"October 12, 1979";
        publishedDate.textColor = [UIColor orangeColor];
        //Not needed, as left is the default, there for demonstration purpose only
        publishedDate.textAlignment = NSTextAlignmentLeft;
    }
    
    //Summary Label
    summary = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 150.0f, 80.0f, 20.0f)];
    //Check for label creation
    if (summary != nil)
    {
        summary.backgroundColor = [UIColor blueColor];
        summary.text = (@"Summary:");
        summary.textColor = [UIColor colorWithRed:0.949 green:0.898 blue:0.835 alpha:1];
    }
    
    //PlotSummary Label
    plotSummary = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 175.0f, 320.0f, 180.0f)];
    //Check for label creation
    if (plotSummary != nil)
    {
        plotSummary.backgroundColor = [UIColor purpleColor];
        plotSummary.textColor = [UIColor lightGrayColor];
        plotSummary.text =(@"Aurthur Dent is awoken by a bulldozer preparing to destroy his home.  This is to make room for a highway bypass.  Ironically, the same this is scheduled to happen to the Earth a few hours later to make room for an interstellar bypass.  Luckily, his friend Ford helps Arthur escape before the Earth is destroyed, and the rest of the story follows Arthur around the Galaxy.  Dressed only in his bath robe and armed with only a towel, hilarity ensues.");
        plotSummary.textAlignment = NSTextAlignmentCenter;
        plotSummary.font=[UIFont systemFontOfSize:14];
        plotSummary.numberOfLines = 10;

    }

    //List Label
    list = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 360.0f, 100.0f, 20.0f)];
    //Check for label creation
    if (list != nil)
    {
        list.backgroundColor = [UIColor blueColor];
        list.text = (@"List of Items:");
        list.textColor = [UIColor colorWithRed:0.408 green:0.729 blue:0.788 alpha:1];
    }
    
    
    //Initially, I had NSArray *details, but it was throwing errors
    //Details Array
    details = [[NSArray alloc] initWithObjects:@"Vogons", @"Towels", @"Intersteller Bypass", @"Paranoid Android", @"42", nil];
    //Initially, I had NSMutableString *detailString, but it was throwing errors
    //Details String
    detailString = [[NSMutableString alloc] initWithString:(@"")];
    //Loop to pull data from array
    for (int i=0; i<[details count]; i++)
    {
        //Logging to see how results are displayed
        // NSLog(@"%@", details[i]);
        [detailString appendString:[details objectAtIndex:(i)]];
        //adding comma after first 4 results
        if (i <= 3)
            {
                [detailString appendString:(@", ")];
            }
        //adding "and" after the 4th object from array in the string
        if (i==3)
            {
                [detailString appendString:(@"and ")];
            }
    }

    //List of Items Label
    listOfItems = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 385.0f, 320.0f, 80.0f)];
    
    //Check for label creation
    if (listOfItems != nil)
    {
        listOfItems.backgroundColor = [UIColor colorWithRed:0.114 green:0.208 blue:0.239 alpha:1];
        listOfItems.text = detailString;
        listOfItems.numberOfLines = 2;
        listOfItems.textAlignment = NSTextAlignmentCenter;
        listOfItems.textColor = [UIColor whiteColor];
    }
    
    //Adding subviews
    [self.view addSubview:title];
    [self.view addSubview:author];
    [self.view addSubview:authorName];
    [self.view addSubview:published];
    [self.view addSubview:publishedDate];
    [self.view addSubview:summary];
    [self.view addSubview:plotSummary];
    [self.view addSubview:list];
    [self.view addSubview:listOfItems];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
