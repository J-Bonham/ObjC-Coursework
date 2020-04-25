//
//  YouWin.m
//  Galactic Courier
//
//  Created by Jeremiah Bonham on 5/17/15.
//  Copyright (c) 2015 Jeremiah.Bonham. All rights reserved.
//

#import "YouWin.h"
#import "LevelOne.h"

@implementation YouWin

-(void)didMoveToView:(SKView *)view {
    
    self.scaleMode = SKSceneScaleModeAspectFill;


    SKLabelNode *winner = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
    
    winner.text = @"You Win!";
    winner.fontColor = [SKColor whiteColor];
    winner.fontSize = 40;
    winner.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [self addChild:winner];
    
    
    SKLabelNode *playAgain = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
    
    playAgain.text = @"Tap To Play Again";
    playAgain.fontColor = [SKColor whiteColor];
    playAgain.fontSize = 20;
    playAgain.position = CGPointMake(self.frame.size.width/2, -50);
    
    SKAction *moveLabel = [SKAction moveToY:(self.frame.size.height/2 - 40) duration: 1.0];
    [playAgain runAction:moveLabel];
    
    [self addChild:playAgain];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
        LevelOne *firstScene = [LevelOne sceneWithSize:self.size];
        [self.view presentScene:firstScene transition:[SKTransition doorsOpenHorizontalWithDuration:(1.25)]];
}



@end
