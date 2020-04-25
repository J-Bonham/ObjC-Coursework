//
//  Credits.m
//  Galactic Courier
//
//  Created by Jeremiah Bonham on 5/27/15.
//  Copyright (c) 2015 Jeremiah.Bonham. All rights reserved.
//

#import "Credits.h"
#import "TitleScreen.h"

@interface Credits ()
{
    
    SKSpriteNode *tut;
    SKLabelNode *backText;
    SKSpriteNode *stars1;
    
}

@end


@implementation Credits


-(void)didMoveToView:(SKView *)view {
    
    self.scaleMode = SKSceneScaleModeAspectFill;
    
    self.backgroundColor = [SKColor blackColor];
    
    stars1 = [SKSpriteNode spriteNodeWithImageNamed:@"stars010"];
    stars1.anchorPoint = CGPointZero;
    stars1.position = CGPointMake(0, 0);
    [self addChild:stars1];
    
    backText = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
    backText.text = @"Touch Screen to Return to Menu";
    backText.fontColor = [SKColor whiteColor];
    backText.fontSize = 20;
    backText.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame) - 40);
    [self addChild:backText];
    
    
    
    tut = [SKSpriteNode spriteNodeWithImageNamed:@"cred"];
    tut.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    
    [self addChild:tut];
    
    
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    TitleScreen *firstScene = [TitleScreen sceneWithSize:self.size];
    [self.view presentScene:firstScene transition:[SKTransition doorsCloseHorizontalWithDuration:(1.25)]];
}

@end