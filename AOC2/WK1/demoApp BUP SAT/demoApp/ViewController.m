//
//  ViewController.m
//  demoApp
//
//  Created by Jeremiah Bonham on 3/3/14.
//  Copyright (c) 2014 Jeremiah.Bonham. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
 
  
    //Monster Labels, 1-3
    monsterLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 50, 100, 30)];
    monsterLabel1.text = @"Monster 1";
    monsterLabel1.backgroundColor = [UIColor colorWithRed:0.114 green:0.208 blue:0.239 alpha:1];
    monsterLabel1.textColor = [UIColor whiteColor];
    monsterLabel1.textAlignment = NSTextAlignmentCenter;
    
    monsterLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(20, 150, 100, 30)];
    monsterLabel2.text = @"Monster 2";
    monsterLabel2.backgroundColor = [UIColor colorWithRed:0.114 green:0.208 blue:0.239 alpha:1];
    monsterLabel2.textColor = [UIColor whiteColor];
    monsterLabel2.textAlignment = NSTextAlignmentCenter;
    
    monsterLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(20, 250, 100, 30)];
    monsterLabel3.text = @"Monster 3";
    monsterLabel3.backgroundColor = [UIColor colorWithRed:0.114 green:0.208 blue:0.239 alpha:1];
    monsterLabel3.textColor = [UIColor whiteColor];
    monsterLabel3.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:monsterLabel1];
    [self.view addSubview:monsterLabel2];
    [self.view addSubview:monsterLabel3];
    
    //Output to Labels
    monsterText1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 85, 200, 45)];
    monsterText1.backgroundColor = [UIColor lightGrayColor];
    [monsterText1 setFont:[UIFont systemFontOfSize:12]];
    monsterText1.numberOfLines = 3;
    
    monsterText2 = [[UILabel alloc]initWithFrame:CGRectMake(20, 185, 200, 45)];
    monsterText2.backgroundColor = [UIColor lightGrayColor];
    [monsterText2 setFont:[UIFont systemFontOfSize:12]];
    monsterText2.numberOfLines = 3;
    
    monsterText3 = [[UILabel alloc]initWithFrame:CGRectMake(20, 285, 200, 45)];
    monsterText3.backgroundColor = [UIColor lightGrayColor];
    [monsterText3 setFont:[UIFont systemFontOfSize:12]];
    monsterText3.numberOfLines = 3;
    
    [self.view addSubview:monsterText1];
    [self.view addSubview:monsterText2];
    [self.view addSubview:monsterText3];
    
    NSArray *monsterType = [[NSArray alloc]initWithObjects:@"Orc", @"Ghoul", @"Dragon", nil];
    
    Orc *heroSmasher = (Orc*) [monsterFactory summonMonster:ORC];
    if (heroSmasher != nil)
    {
        [heroSmasher setMonsterName:@"Hero Smasher"];
        [heroSmasher setHitPoints:12];
        [heroSmasher setMonsterType:monsterType[0]];
        
        //testing output in console
        NSLog(@"An %@ stands before you. It's name is %@ and it has %i health.", [heroSmasher monsterType], [heroSmasher monsterName], [heroSmasher hitPoints]);
        
        monsterText1.text = [NSString stringWithFormat:@" Name: %@ \n Type: %@ \n HitPoints: %i", [heroSmasher monsterName],[heroSmasher monsterType],[heroSmasher hitPoints]];
    }
    

    Ghoul *scaryUndead = (Ghoul*) [monsterFactory summonMonster:GHOUL];
    if (scaryUndead  != nil)
    {
        [scaryUndead setMonsterName:@"Slenderman"];
        [scaryUndead setHitPoints:9];
        [scaryUndead setMonsterType:monsterType[1]];
        
        //testing output in console
        NSLog(@"An %@ stands before you. It's name is %@ and it has %i health.", [scaryUndead monsterType], [scaryUndead monsterName], [scaryUndead hitPoints]);
        
        monsterText2.text = [NSString stringWithFormat:@" Name: %@ \n Type: %@ \n HitPoints: %i",[scaryUndead monsterName],[scaryUndead monsterType],[scaryUndead hitPoints]];
    }

    Dragon *giantLizard = (Dragon*) [monsterFactory summonMonster:DRAGON];
    if (giantLizard  != nil)
    {
        [giantLizard setMonsterName:@"Glaurung"];
        [giantLizard setHitPoints: ];
        [giantLizard setMonsterType:monsterType[2]];

        //testing output in console
        NSLog(@"A %@ stands before you. His name is %@ and he has %i health.", [giantLizard monsterType], [giantLizard monsterName], [giantLizard hitPoints]);
        
        monsterText3.text = [NSString stringWithFormat:@" Name: %@ \n Type: %@ \n HitPoints: %i", [giantLizard monsterName],[giantLizard monsterType],[giantLizard hitPoints]];
    }
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

//assignment instruction for reference
/*
 Your app should use the factory to instantiate one of each of the three subclasses and add their string and numeric member values to three labels placed on the primary view. When adding the values to the labels, be sure to use the accessor methods provided by the base class to get the members, and do not just hard-code the values in the labels. For example:
 
 turkeylabel.text = [NSString stringWithFormat:@"The %@ are combined and you must %@.", [thanksgivingMeal ingredients], [thanksgivingMeal instructions]];
 
 Your app should also call the custom mutator method (such as setPounds on the turkey recipe class) to set the unique data member for each class, and then use the corresponding accessor to show the value in another set of labels:
 
 turkeycustom.text = [NSString stringWithFormat:@"The %d pound turkey needs to cook %d minutes.", [thanksgivingMeal pounds], [thanksgivingMeal calculateCookingTimeMinutes]];
 
 
 
 The calculation method must be called for each subclass and its result (the return value)  must be displayed on one of the labels.
 */

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
