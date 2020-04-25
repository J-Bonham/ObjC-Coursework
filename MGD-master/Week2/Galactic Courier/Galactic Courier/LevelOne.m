//
//  GameScene.m
//  Galactic Courier
//
//  Created by Jeremiah Bonham on 5/4/15.
//  Copyright (c) 2015 Jeremiah.Bonham. All rights reserved.
//

#import "LevelOne.h"
#import "GameOver.h"

@interface LevelOne ()
{
    //Player Node
    SKNode *ship;
    SKNode *brokenShip;

    
    //Background Nodes
    SKSpriteNode *bg1;
    SKSpriteNode *bg2;
    
    SKNode *asteroid;
    SKLabelNode *multiplier;

    SKNode *repair;
    
    // Sound Actions
    SKAction *playCollision;
    SKAction *playThruster;
    SKAction *playExplode;
    SKAction *playPowerUp;

    
    SKAction *rotation;
    
    //NSUInteger *scoreValue;
    //NSUInteger *playerHull;

    SKLabelNode *scoreText;
    SKLabelNode *hullText;
    SKLabelNode *gameOverText;

}

@property NSTimeInterval asteroidTimer;
@property NSTimeInterval AsteroidTimerUpdate;
@property (nonatomic, assign) int scoreValue;
@property (nonatomic, assign) int playerHull;
@property (nonatomic, assign) int multiplier;
@property (nonatomic, assign) int asteroidsMissed;



@end



@implementation LevelOne

static const uint32_t shipCategory = 1; // 0x1
static const uint32_t asteroidCategory = 2; //0x1 << 1
static const uint32_t powerUpCatergory = 4; //0x1 << 2
static const uint32_t bottomEdgeCategory = 8; //0x1 << 3
//static const uint32_t levelEnd = 16;  //0x1 << 4

-(instancetype)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
    }
    return self;
}

-(void)didMoveToView:(SKView *)view {
    
    self.scaleMode = SKSceneScaleModeAspectFill;

    //Create Sounds
    playCollision = [SKAction playSoundFileNamed:@"hit.mp3" waitForCompletion:YES];
    playThruster = [SKAction playSoundFileNamed:@"thruster.mp3" waitForCompletion:YES];
    playExplode = [SKAction playSoundFileNamed:@"explosion.mp3" waitForCompletion:YES];
    playPowerUp = [SKAction playSoundFileNamed:@"powerup.mp3" waitForCompletion:YES];
   
    _scoreValue = 0;
    _playerHull = 3;
    _asteroidsMissed = 0;
    _multiplier = 2;
   
    //Create Physics World
    self.backgroundColor = [SKColor blackColor];
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsWorld.contactDelegate = self;
    
    //Create Backgrounds
    bg1 = [SKSpriteNode spriteNodeWithImageNamed:@"bg020"];
    bg1.anchorPoint = CGPointZero;
    bg1.position = CGPointMake(0, 0);
    [self addChild:bg1];
    
    bg2 = [SKSpriteNode spriteNodeWithImageNamed:@"bg010"];
    bg2.anchorPoint = CGPointZero;
    bg2.position = CGPointMake(0, bg1.size.height - 5);
    [self addChild:bg2];
    
    //Score Label and Callout
    scoreText = [SKLabelNode labelNodeWithFontNamed:@"Arial Bold"];
    scoreText.text = @"Score";
    scoreText.fontSize = 14;
    scoreText.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame)-25);
    [self addChild:scoreText];
    
    SKLabelNode *score = [SKLabelNode labelNodeWithFontNamed:@"Arial Bold"];
    score.text = @"";
    score.fontSize = 14;
    score.position = CGPointMake(CGRectGetMidX(self.frame) + 50, CGRectGetMaxY(self.frame)-25);
    [self addChild:score];
    
    //Hull Label and Callout
    hullText = [SKLabelNode labelNodeWithFontNamed:@"Arial Bold"];
    hullText.text = @"Ship Hull: 3";
    hullText.fontSize = 14;
    hullText.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-50);
    [self addChild:hullText];
    
    multiplier = [SKLabelNode labelNodeWithFontNamed:@"Arial Bold"];
    multiplier.text = @"";
    multiplier.fontSize = 30;
    multiplier.position = CGPointMake(CGRectGetMidX(self.frame)+ 230,CGRectGetMidY(self.frame) + 350);
    [self addChild:multiplier];
  
    
    //Add Player Ship
    
    ship = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
    ship.position = CGPointMake(CGRectGetMidX(self.frame),
                                CGRectGetMinY(self.frame) + 100);
    ship.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:ship.frame.size];
    ship.physicsBody.dynamic = NO;
    ship.physicsBody.mass = 0.04;
    ship.physicsBody.categoryBitMask = shipCategory;
    ship.physicsBody.contactTestBitMask = asteroidCategory;
    ship.physicsBody.collisionBitMask =  0;
    
    [self addChild:ship];
    
    repair = [SKSpriteNode spriteNodeWithImageNamed:@"repair"];
    CGPoint otherPoint = CGPointMake(400, self.frame.size.height - 50);
    repair.position = otherPoint;
    repair.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:repair.frame.size];
    repair.physicsBody.categoryBitMask = powerUpCatergory;
    repair.physicsBody.contactTestBitMask = shipCategory;
    repair.physicsBody.collisionBitMask = 0;
    [self addChild:repair];
    
    
    SKNode *bottomEdge = [SKNode node];
    bottomEdge.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:CGPointMake(0, 1) toPoint:CGPointMake(self.frame.size.width, 1)];
    bottomEdge.physicsBody.categoryBitMask = bottomEdgeCategory;
    [self addChild:bottomEdge];
    repair.physicsBody.categoryBitMask = bottomEdgeCategory;
    repair.physicsBody.contactTestBitMask = asteroidCategory;
    repair.physicsBody.collisionBitMask = 0;
    
    brokenShip = [SKSpriteNode spriteNodeWithImageNamed:@"explosion"];
    brokenShip.position = ship.position;
    
    gameOverText = [SKLabelNode labelNodeWithFontNamed:@"Arial Bold"];
    gameOverText.text = @"Game Over";
    gameOverText.fontSize = 24;
    gameOverText.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
}


//Ship Controls
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        CGPoint newPosition = CGPointMake(location.x, 100);
        int minDuration = 1.0;
        int maxDuration = 2.0;
        int rangeDuration = maxDuration - minDuration;
        int actualDuration = (arc4random() % rangeDuration) + minDuration;
        
        ship.position = newPosition;
        
        SKAction * actionMove = [SKAction moveTo:CGPointMake(ship.position.x, 100) duration:actualDuration];
        [ship runAction:actionMove];
        
    }
    
}

// Thruster Sound for Ship
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self runAction:playThruster];
}

//Asteroid Collision
- (void)player:(SKSpriteNode *)player didCollideWithShip:(SKSpriteNode *)asteroid {
    NSLog(@"Hit");
    //[self runAction:[SKAction playSoundFileNamed:@"hit.mp3" waitForCompletion:YES]];
    [asteroid removeFromParent];
    
    _playerHull = _playerHull - 1;
    hullText.text = [NSString stringWithFormat:@"Ship Hull %i", self->_playerHull];
    
    NSLog(@"%i", _playerHull);
    _asteroidsMissed = 0;
     multiplier.text = @"";

    if (_scoreValue <= 50) {
        _scoreValue = 0;
    } else {
        _scoreValue = _scoreValue - 10;
    }
    
    if (_playerHull > 0){
        [self runAction:playCollision];

    }
    
    if (_playerHull == 0) {
        NSLog(@"GAME OVER");
        
        GameOver *firstScene = [GameOver sceneWithSize:self.size];
        [self.view presentScene:firstScene transition:[SKTransition doorsOpenHorizontalWithDuration:(1.25)]];

    }
  
}

//Contact Method
-(void)didBeginContact:(SKPhysicsContact *)contact {
    
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

//Contact Method
-(void)didEndContact:(SKPhysicsContact *)contactEnd {
    
    SKPhysicsBody *firstBody, *secondBody;
    
    if (contactEnd.bodyA.categoryBitMask < contactEnd.bodyB.categoryBitMask)
    {
        firstBody = contactEnd.bodyA;
        secondBody = contactEnd.bodyB;
    }
    else
    {
        firstBody = contactEnd.bodyB;
        secondBody = contactEnd.bodyA;
    }
    
    
    if ((firstBody.categoryBitMask & asteroidCategory) != 0 &&
        (secondBody.categoryBitMask & bottomEdgeCategory) != 0)
    {
        [self asteroid:(SKSpriteNode *) firstBody.node asteroidLeftScene:(SKSpriteNode *) secondBody.node];
    }
    
}

-(void)asteroid:(SKSpriteNode *)asteroid asteroidLeftScene:(SKSpriteNode *)bottomEdge {
    
   // NSLog(@"ADDING TO SCORE");
    _asteroidsMissed = _asteroidsMissed + 1;
   
    if (_asteroidsMissed < 10){
    _scoreValue = _scoreValue + 10;
    }
    
    if (_asteroidsMissed >= 20){
        _scoreValue = _scoreValue + 20;
   }
    
    if (_asteroidsMissed == 20){
        _scoreValue = _scoreValue + 20;
        multiplier.text = @"X2";
        [self runAction:playPowerUp];
    }
    
    scoreText.text = [NSString stringWithFormat:@"Score: %i", self->_scoreValue];
}



//Add Asteroids

- (void)addAsteroid {
    
    // Create sprite
    asteroid = [SKSpriteNode spriteNodeWithImageNamed:@"asteroid"];
    int minX = asteroid.frame.size.width;
    int maxX = self.frame.size.width - asteroid.frame.size.width;
    int rangeX = maxX - minX;
    int actualX = (arc4random() % rangeX) + minX;
    
    asteroid.position = CGPointMake(actualX, self.frame.size.width + asteroid.frame.size.width/5);
    
    asteroid.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:asteroid.frame.size];
    asteroid.physicsBody.dynamic = YES;
    asteroid.physicsBody.categoryBitMask = asteroidCategory;
    asteroid.physicsBody.contactTestBitMask = shipCategory;
    asteroid.physicsBody.collisionBitMask =  0;
    
    [self addChild:asteroid];
    
    // Determine speed of the asteroid
    int minDuration = 1.0;
    int maxDuration = 3.0;
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    // Create the actions
    SKAction * actionMove = [SKAction moveTo:CGPointMake(actualX, -asteroid.frame.size.width/2) duration:actualDuration];
    SKAction * actionMoveDone = [SKAction removeFromParent];
    [asteroid runAction: [SKAction sequence:@[actionMove, actionMoveDone]]];
    
}

// Scrolling Background

-(void)moveBackground
{
    bg1.position = CGPointMake(bg1.position.x, bg1.position.y-5);
    bg2.position = CGPointMake(bg2.position.x, bg2.position.y-5);
    
    if (bg1.position.y < -bg1.size.height){
        bg1.position = CGPointMake(bg1.position.x, bg2.position.y  + bg2.size.height);
    }
    
    if (bg2.position.y < -bg2.size.height) {
        bg2.position = CGPointMake(bg2.position.x, bg1.position.y + bg1.size.height);
    }
    
    
}

- (void)updateWithTimeSinceLastUpdate:(CFTimeInterval)timeSinceLast {
    
    self.asteroidTimer += timeSinceLast;
    if (self.asteroidTimer > .5) {
        self.asteroidTimer = 0;
        [self addAsteroid];
    }
}

- (void)update:(NSTimeInterval)currentTime {
    
    [self moveBackground];
    
    CFTimeInterval timeSinceLast = currentTime - self.AsteroidTimerUpdate;
    self.AsteroidTimerUpdate = currentTime;
    if (timeSinceLast > 1) {
        timeSinceLast = 1.0 / 10.0;
        self.AsteroidTimerUpdate = currentTime;
    }
    
    [self updateWithTimeSinceLastUpdate:timeSinceLast];
}


@end