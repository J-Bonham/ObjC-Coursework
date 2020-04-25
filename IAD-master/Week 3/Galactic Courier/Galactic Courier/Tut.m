//
//  Tut.m
//  Galactic Courier
//
//  Created by Jeremiah Bonham on 5/26/15.
//  Copyright (c) 2015 Jeremiah.Bonham. All rights reserved.
//

#import "Tut.h"
#import "TitleScreen.h"

@interface Tut ()
{

    SKSpriteNode *tut;
    SKLabelNode *backText;

}

@end


@implementation Tut


-(void)didMoveToView:(SKView *)view {
    
    self.scaleMode = SKSceneScaleModeAspectFill;
    
    self.backgroundColor = [SKColor blackColor];
   
    backText = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
    backText.text = @"Touch Screen to Return to Menu";
    backText.fontColor = [SKColor whiteColor];
    backText.fontSize = 20;
    backText.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame) - 40);
    [self addChild:backText];
    
    
    tut = [SKSpriteNode spriteNodeWithImageNamed:@"tut"];
    tut.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));

    [self addChild:tut];

    
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    TitleScreen *firstScene = [TitleScreen sceneWithSize:self.size];
    [self.view presentScene:firstScene transition:[SKTransition doorsCloseHorizontalWithDuration:(1.25)]];
}


@end
