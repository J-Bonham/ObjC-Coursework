//
//  GameScene.m
//  Galactic Courier
//
//  Created by Jeremiah Bonham on 5/4/15.
//  Copyright (c) 2015 Jeremiah.Bonham. All rights reserved.
//

#import "GameScene.h" 

@interface GameScene ()
{
    SKNode *ship;
    SKNode *bg1;
    SKNode *bg2;
    SKNode *bg3;
    SKNode *bg4;
    SKNode *asteroid;
    SKNode *repair;

}

@property NSTimeInterval asteroidTimer;
@property NSTimeInterval AsteroidTImerUpdate;

@end

@implementation GameScene

static const uint32_t shipCategory = 1;
static const uint32_t asteroidCategory = 2;

-(void)didMoveToView:(SKView *)view {
    
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsWorld.contactDelegate = self;
    
    self.backgroundColor = [SKColor blackColor];
   
    //Background Creation
    bg1 = [SKSpriteNode spriteNodeWithImageNamed:@"bg1"];
    bg1.position = CGPointMake(CGRectGetMidX(self.frame)/2, CGRectGetMidY(self.frame)/2);
    [self addChild:bg1];
    
//    SKAction* movebackground = [SKAction moveByX:0 y:-bg1.frame.size.width duration:0.005 * bg1.frame.size.width];
//    SKAction* movebackgroundForever = [SKAction repeatActionForever:[SKAction sequence:@[movebackground, movebackground]]];
//    [bg1 runAction:movebackgroundForever];
    
    
    //Score
    SKLabelNode *score = [SKLabelNode labelNodeWithFontNamed:@"Arial Bold"];

    score.text = @"Score";
    score.fontSize = 14;
    score.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMaxY(self.frame)-25);
    
    [self addChild:score];
    
    ship = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
    ship.position = CGPointMake(CGRectGetMidX(self.frame),
                                CGRectGetMinY(self.frame) + 100);
    ship.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:ship.frame.size];
    ship.physicsBody.dynamic = NO;
    ship.physicsBody.mass = 0.04;
    
    
    ship.physicsBody.categoryBitMask = shipCategory;
    ship.physicsBody.contactTestBitMask = asteroidCategory;
    ship.physicsBody.collisionBitMask =  asteroidCategory;
    
    
    [self addChild:ship];
    
     asteroid = [SKSpriteNode spriteNodeWithImageNamed:@"asteroid"];
     CGPoint centerPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height - 50);
     asteroid.position = centerPoint;
     asteroid.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:asteroid.frame.size];
     asteroid.physicsBody.categoryBitMask = asteroidCategory;
     asteroid.physicsBody.contactTestBitMask = shipCategory;
     asteroid.physicsBody.collisionBitMask = shipCategory;
     [self addChild:asteroid];

    repair = [SKSpriteNode spriteNodeWithImageNamed:@"repair"];
    CGPoint otherPoint = CGPointMake(400, self.frame.size.height - 50);
    repair.position = otherPoint;
    repair.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:repair.frame.size];
//    repair.physicsBody.categoryBitMask = asteroidCategory;
//    repair.physicsBody.contactTestBitMask = shipCategory;
//    repair.physicsBody.collisionBitMask = shipCategory;
    [self addChild:repair];
    
}


// Ship Controls
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        CGPoint newPosition = CGPointMake(location.x, 100);
        
        ship.position = newPosition;

    }
    
}

// Thruster Sound for Ship
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
        [self runAction:[SKAction playSoundFileNamed:@"thruster.mp3" waitForCompletion:YES]];
    
}

//Asteroid Collision Sound
- (void)player:(SKSpriteNode *)player didCollideWithShip:(SKSpriteNode *)asteroid {
    NSLog(@"Hit");

    [self runAction:[SKAction playSoundFileNamed:@"hit.mp3" waitForCompletion:YES]];


}

-(void)didBeginContact:(SKPhysicsContact *)contact
{

    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else
    {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }

    if ((firstBody.categoryBitMask & shipCategory) != 0 &&
        (secondBody.categoryBitMask & asteroidCategory) != 0)
    {
        [self player:(SKSpriteNode *) firstBody.node didCollideWithShip:(SKSpriteNode *) secondBody.node];
    }
}



//Add Asteroid - Getting ahead of myself a bit here

//- (void)addAsteroid {
//    
//    // Create sprite
//    asteroid = [SKSpriteNode spriteNodeWithImageNamed:@"asteroid"];
//    int minX = asteroid.frame.size.width / 15;
//    int maxX = self.frame.size.width - asteroid.frame.size.width / 15;
//    int rangeX = maxX - minX;
//    int actualX = (arc4random() % rangeX) + minX;
//    
//
//    asteroid.position = CGPointMake(actualX, self.frame.size.width + asteroid.frame.size.width/5);
//    asteroid.position = centerPoint;
//    asteroid.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:asteroid.frame.size];
//    asteroid.physicsBody.dynamic = YES;
//    
//    asteroid.physicsBody.categoryBitMask = asteroidCategory;
//    asteroid.physicsBody.contactTestBitMask = shipCategory;
//    asteroid.physicsBody.collisionBitMask =  shipCategory;
//    
//    
//    [self addChild:asteroid];
//    
//    // Determine speed of the asteroid
//    int minDuration = 1.0;
//    int maxDuration = 3.0;
//    int rangeDuration = maxDuration - minDuration;
//    int actualDuration = (arc4random() % rangeDuration) + minDuration;
//    
//    // Create the actions
//    SKAction * actionMove = [SKAction moveTo:CGPointMake(actualX, -asteroid.frame.size.width/2) duration:actualDuration];
//    SKAction * actionMoveDone = [SKAction removeFromParent];
//    [asteroid runAction:[SKAction sequence:@[actionMove, actionMoveDone]]];
//    
//}

//- (void)updateWithTimeSinceLastUpdate:(CFTimeInterval)timeSinceLast {
//    
//    self.asteroidTimer += timeSinceLast;
//    if (self.asteroidTimer > .5) {
//        self.asteroidTimer = 0;
//        [self addAsteroid];
//    }
//}

- (void)update:(NSTimeInterval)currentTime {
//    CFTimeInterval timeSinceLast = currentTime - self.AsteroidTImerUpdate;
//    self.AsteroidTImerUpdate = currentTime;
//    if (timeSinceLast > 1) { // more than a second since last update
//        timeSinceLast = 1.0 / 10.0;
//        self.AsteroidTImerUpdate = currentTime;
//    }
//    [self updateWithTimeSinceLastUpdate:timeSinceLast];
    
}

@end
