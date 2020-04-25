//
//  TitleScreen.m
//  Galactic Courier
//
//  Created by Jeremiah Bonham on 5/11/15.
//  Copyright (c) 2015 Jeremiah.Bonham. All rights reserved.
//

#import "TitleScreen.h"
#import "LevelSelect.h"
#import "Tut.h"
#import "Credits.h"
#import <GameKit/GameKit.h>
#import "GameKitHelper.h"
#import "LeaderBoard.h"

@interface TitleScreen ()
{
    SKLabelNode *startGame;
    SKLabelNode *instructions;
    SKLabelNode *credits;
    SKLabelNode *gcText;
    SKLabelNode *localLB;
    
    SKSpriteNode *bg1;
    SKSpriteNode *title;
    SKSpriteNode *stars1;

}

@end

@implementation TitleScreen


-(void)didMoveToView:(SKView *)view {
    
    self.scaleMode = SKSceneScaleModeAspectFill;
    
    self.backgroundColor = [SKColor blackColor];
    
    bg1 = [SKSpriteNode spriteNodeWithImageNamed:@"bg010"];
    bg1.anchorPoint = CGPointZero;
    bg1.position = CGPointMake(0, 0);
    [self addChild:bg1];
    
    stars1 = [SKSpriteNode spriteNodeWithImageNamed:@"stars010"];
    stars1.anchorPoint = CGPointZero;
    stars1.position = CGPointMake(0, 0);
    [self addChild:stars1];
    
    title = [SKSpriteNode spriteNodeWithImageNamed:@"title"];
    title.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 175);
    
    [self addChild:title];
    
    startGame = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
    
    startGame.text = @"Start";
    startGame.fontColor = [SKColor greenColor];
    startGame.fontSize = 40;
    startGame.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [self addChild:startGame];
    
    gcText = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
    
    gcText.text = @"Game Center";
    gcText.fontColor = [SKColor greenColor];
    gcText.fontSize = 40;
    gcText.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 75);
    [self addChild:gcText];
    
    localLB = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
    localLB.text = @"Local Leaderboard";
    localLB.fontColor = [SKColor greenColor];
    localLB.fontSize = 40;
    localLB.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 150);
    [self addChild:localLB];
    
    instructions = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
    instructions.text = @"Instructions";
    instructions.fontColor = [SKColor greenColor];
    instructions.fontSize = 40;
    instructions.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 225);
    [self addChild:instructions];
    
    credits = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
    
    credits.text = @"Credits";
    credits.fontColor = [SKColor greenColor];
    credits.fontSize = 40;
    credits.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 300);
    [self addChild:credits];
    

}



- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self.scene];
    
    if(CGRectContainsPoint(startGame.frame, touchLocation)) {
        NSLog(@"Start");
        LevelSelect *game = [LevelSelect sceneWithSize:self.size];
        [self.view presentScene:game transition:[SKTransition doorsOpenHorizontalWithDuration:(1.25)]];
    }
    
    
    if(CGRectContainsPoint(instructions.frame, touchLocation)) {
        NSLog(@"TUT");
        Tut *tutorial = [Tut sceneWithSize:self.size];
        [self.view presentScene:tutorial transition:[SKTransition doorsOpenHorizontalWithDuration:(1.25)]];
        
    }
    
    if(CGRectContainsPoint(credits.frame, touchLocation)) {
        NSLog(@"Credits");
        Credits *creds = [Credits sceneWithSize:self.size];
        [self.view presentScene:creds transition:[SKTransition doorsOpenHorizontalWithDuration:(1.25)]];
        
    }
    

    
    if(CGRectContainsPoint(gcText.frame, touchLocation)) {
        NSLog(@"gameCenter");

        if ([GKLocalPlayer localPlayer].isAuthenticated) {
            
                [[GKLocalPlayer localPlayer] loadDefaultLeaderboardIdentifierWithCompletionHandler:^(NSString *leaderboardIdentifier, NSError *error) {
            
                    GKGameCenterViewController *leaderboardViewController = [[GKGameCenterViewController alloc] init];
                    UIViewController *rootViewController = self.view.window.rootViewController;
            
                    [leaderboardViewController setGameCenterDelegate:self];
                    [rootViewController presentViewController:leaderboardViewController animated:YES completion:nil];
            
                }];
            
        } else {
            
            UIAlertView *noGameCenter = [[UIAlertView alloc] initWithTitle:@"Not Connected To Game Center" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            noGameCenter.alertViewStyle = UIAlertViewStyleDefault;
            [noGameCenter show];

        }
    }
    
    if(CGRectContainsPoint(localLB.frame, touchLocation)) {
        NSLog(@"local");
        LeaderBoard *gameCenterLB = [LeaderBoard sceneWithSize:self.size];
        [self.view presentScene:gameCenterLB transition:[SKTransition doorsOpenHorizontalWithDuration:(1.25)]];
        
    }
    
}


-(void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController {
    
    UIViewController *rootViewController = self.view.window.rootViewController;
    [rootViewController dismissViewControllerAnimated:YES completion:nil];
}



@end
