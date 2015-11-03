//
//  ViewController.h
//  demoAPP
//
//  Created by Jeremiah Bonham on 2/7/14.
//  Copyright (c) 2014 Jeremiah.Bonham. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

{
    UILabel *title;
    UILabel *author;
    UILabel *authorName;
    UILabel *published;
    UILabel *publishedDate;
    UILabel *summary;
    UILabel *plotSummary;
    UILabel *list;
    UILabel *listOfItems;
    NSArray *details;
    NSMutableString *detailString;
  
}


@end
