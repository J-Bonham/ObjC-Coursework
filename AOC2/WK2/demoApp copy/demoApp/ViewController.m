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
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)onClick:(id)sender
{
	// Reset the Buttons
    orcButton.enabled = true;
    ghoulButton.enabled = true;
    dragonButton.enabled = true;
    calcXPButton.enabled = true;
    
	// Reset the Property Values, Labels, and Steppers
    stepLabel.text = @"0";
    monsterStep.value = 0;
    monsterStep.hidden = false;
	
	UIButton *monsterButton = (UIButton*)sender;
    if (monsterButton != nil) {
    	
    	if (monsterButton.tag == 0) {
            stepLabel.text = @"1";
            monsterStep.value = 1;
            
        } else if (monsterButton.tag == 1) {
            stepLabel.text = @"1";
            monsterStep.value = 1;
        } else if (monsterButton.tag == 2) {
            stepLabel.text = @"1";
            monsterStep.value = 1;
        }
        monsterButton.enabled = false;
        calcXPButton.tag = monsterButton.tag;
    }
}

-(IBAction)stepperClick:(id)sender
{
    UIStepper *step = (UIStepper*)sender;
    if (step != nil) {
    	int stepVal = step.value;
        if (step.tag == 0) {
        	stepLabel.text = [NSString stringWithFormat:@"%d", stepVal];
        }
    }
    totalXP.text = @"";
}
/*
-(IBAction)calcXP:(id)sender
{
	NSLog(@"WORKING");
    int monsterStepVal = monsterStep.value;
    
	if (calcXPButton.tag == 0) {
    	
    	Orc *heroSmasher = (Orc*) [monsterFactory summonMonster:ORC];
        if (heroSmasher != nil)
        {
            [heroSmasher setMonsterName:@"Hero Smasher"];
            [heroSmasher setMonsterLevel:6];
            
            [heroSmasher calcMonsterXP];
            monsterStepVal = [heroSmasher monsterLevel];
            
        } else if (calcXPButton.tag == 1) {
            
            Ghoul *scaryUndead = (Ghoul*) [monsterFactory summonMonster:GHOUL];
            if (scaryUndead  != nil)
            {
                [scaryUndead setMonsterName:@"Slenderman"];
                [scaryUndead setMonsterLevel:9];
            } else if (calcXPButton.tag == 2) {
                
                Dragon *giantLizard = (Dragon*) [monsterFactory summonMonster:DRAGON];
                if (giantLizard  != nil)
                {
                    [giantLizard setMonsterName:@"Glaurung"];
                    [giantLizard setMonsterLevel: 15];
                    
                    
                }
                
                
                
                
                totalXP.text = [NSString stringWithFormat:@"Combinred value is  XP." ];
            }
        }
    }
}
 */
@end
