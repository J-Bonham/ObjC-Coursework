//
//  TitleScreen.m
//  Galactic Courier
//
//  Created by Jeremiah Bonham on 5/11/15.
//  Copyright (c) 2015 Jeremiah.Bonham. All rights reserved.
//

#import "TitleScreen.h"

@implementation TitleScreen


-(instancetype)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        
         
        
        SKLabelNode *tryAgain = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
        
        tryAgain.text = @"Tap To Play";
        tryAgain.fontColor = [SKColor whiteColor];
        tryAgain.fontSize = 20;
        tryAgain.position = CGPointMake(size.width/2, -50);
        
        SKAction *moveLabel = [SKAction moveToY:(size.height/2 - 40) duration: 1.0];
        [tryAgain runAction:moveLabel];
        
        [self addChild:tryAgain];
        
        
        
    }
    return self;
};

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    TitleScreen *firstScene = [TitleScreen sceneWithSize:self.size];
    [self.view presentScene:firstScene transition:[SKTransition doorsOpenHorizontalWithDuration:(1.25)]];
}

@end
