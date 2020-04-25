//
//  YouWin.m
//  Galactic Courier
//
//  Created by Jeremiah Bonham on 5/17/15.
//  Copyright (c) 2015 Jeremiah.Bonham. All rights reserved.
//

#import "YouWin.h"
#import "LevelOne.h"
#import "TitleScreen.h"

@interface YouWin ()
{

    
    SKSpriteNode *bg1;
    SKSpriteNode *stars1;
    
}
@end

@implementation YouWin

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


    SKLabelNode *winner = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
    
    winner.text = @"You Win!";
    winner.fontColor = [SKColor whiteColor];
    winner.fontSize = 40;
    winner.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [self addChild:winner];
    
    
    SKLabelNode *playAgain = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
    
    playAgain.text = @"Tap To Continue";
    playAgain.fontColor = [SKColor whiteColor];
    playAgain.fontSize = 20;
    playAgain.position = CGPointMake(self.frame.size.width/2, -50);
    
    SKAction *moveLabel = [SKAction moveToY:(self.frame.size.height/2 - 40) duration: 1.0];
    [playAgain runAction:moveLabel];
    
    [self addChild:playAgain];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
        TitleScreen *firstScene = [TitleScreen sceneWithSize:self.size];
        [self.view presentScene:firstScene transition:[SKTransition doorsOpenHorizontalWithDuration:(1.25)]];
}



@end
