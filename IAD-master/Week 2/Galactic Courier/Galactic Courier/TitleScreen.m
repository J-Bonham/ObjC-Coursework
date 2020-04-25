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

@interface TitleScreen ()
{
    SKLabelNode *startGame;
    SKLabelNode *instructions;
    SKLabelNode *credits;
    
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
    //title.anchorPoint = CGPointZero;
    title.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 175);
    
    [self addChild:title];
    
    
    startGame = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
    
    startGame.text = @"Start";
    startGame.fontColor = [SKColor greenColor];
    startGame.fontSize = 40;
    startGame.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [self addChild:startGame];
    
    
    instructions = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
    
    instructions.text = @"Instructions";
    instructions.fontColor = [SKColor greenColor];
    instructions.fontSize = 40;
    instructions.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 75);
    [self addChild:instructions];
    
    credits = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
    
    credits.text = @"Credits";
    credits.fontColor = [SKColor greenColor];
    credits.fontSize = 40;
    credits.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 150);
    [self addChild:credits];

}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
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
}






@end
