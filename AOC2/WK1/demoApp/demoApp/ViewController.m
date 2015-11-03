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
    
    //Creating Orc
    
    Orc *heroSmasher = (Orc*) [MonsterFactory summonMonster:ORC];

    if (heroSmasher != nil)
    {
        [heroSmasher setMonsterName:@"Hero Smasher"];
        [heroSmasher setMonsterHP:12];
        [heroSmasher setMonsterType:monsterType[0]];
        
        //testing output in console
        NSLog(@"An %@ stands before you. It's name is %@ and it has %i health.", [heroSmasher monsterType], [heroSmasher monsterName], [heroSmasher monsterHP]);
        
        monsterText1.text = [NSString stringWithFormat:@" Name: %@ \n Type: %@ \n HitPoints: %i", [heroSmasher monsterName],[heroSmasher monsterType],[heroSmasher monsterHP]];
    }
    
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
