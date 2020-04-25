//
//  LevelSelect.m
//  Galactic Courier
//
//  Created by Jeremiah Bonham on 6/8/15.
//  Copyright (c) 2015 Jeremiah.Bonham. All rights reserved.
//

#import "LevelSelect.h"
#import "LevelOne.h"
#import "LevelOneHard.h"
#import "LevelOneEndless.h"


@interface LevelSelect ()
{
    
    SKSpriteNode *background;

    SKSpriteNode *norm;
    SKSpriteNode *hard;
    SKSpriteNode *endless;
    
    
}

@end

@implementation LevelSelect


-(void)didMoveToView:(SKView *)view {
    
    self.scaleMode = SKSceneScaleModeAspectFill;
    
    self.backgroundColor = [SKColor grayColor];
    
    background = [SKSpriteNode spriteNodeWithImageNamed:@"lvlSelBG"];
    background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [self addChild:background];
    
    norm = [SKSpriteNode spriteNodeWithImageNamed:@"norm"];
    norm.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 65);
    [self addChild:norm];
    
    hard = [SKSpriteNode spriteNodeWithImageNamed:@"hard"];
    hard.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 55);
    [self addChild:hard];

    endless = [SKSpriteNode spriteNodeWithImageNamed:@"endless"];
    endless.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 175);
    [self addChild:endless];

    
}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self.scene];
    
    if(CGRectContainsPoint(norm.frame, touchLocation)) {
        NSLog(@"Normal");
        LevelOne *normal = [LevelOne sceneWithSize:self.size];
        [self.view presentScene:normal transition:[SKTransition doorsOpenHorizontalWithDuration:(1.25)]];
    }
   
    if(CGRectContainsPoint(hard.frame, touchLocation)) {
        NSLog(@"Hard");
        LevelOneHard *harder = [LevelOneHard sceneWithSize:self.size];
        [self.view presentScene:harder transition:[SKTransition doorsOpenHorizontalWithDuration:(1.25)]];
    }
    
    if(CGRectContainsPoint(endless.frame, touchLocation)) {
        NSLog(@"Endless");
        LevelOneEndless *neverEnd = [LevelOneEndless sceneWithSize:self.size];
        [self.view presentScene:neverEnd transition:[SKTransition doorsOpenHorizontalWithDuration:(1.25)]];
    }
    
}


@end
