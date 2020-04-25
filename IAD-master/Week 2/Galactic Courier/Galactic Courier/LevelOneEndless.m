//
//  LevelOneHard.m
//  Galactic Courier
//
//  Created by Jeremiah Bonham on 6/8/15.
//  Copyright (c) 2015 Jeremiah.Bonham. All rights reserved.
//

#import "LevelOneEndless.h"
#import "GameOver.h"
#import "YouWin.h"

@interface LevelOneEndless ()
{
    //Player Node
    SKNode *ship;
    SKNode *shield;
    SKNode *shieldPowerUp;
    
    SKNode *finishLine;
    SKShapeNode *rect;
    SKShapeNode *rect2;
    
    SKShapeNode *health1;
    SKShapeNode *health2;
    SKShapeNode *health3;
    
    //Background Nodes
    SKSpriteNode *bg1;
    SKSpriteNode *bg2;
    
    SKSpriteNode *stars1;
    SKSpriteNode *stars2;
    
    SKNode *asteroid;
    
    SKLabelNode *multiplierText;
    SKLabelNode *pauseButton;
    SKLabelNode *healthText;
    
    SKNode *repair;
    
    // Sound Actions
    SKAction *playCollision;
    SKAction *playThruster;
    SKAction *playExplode;
    SKAction *playPowerUp;
    SKAction *playRepair;
    SKAction *playshield;

    
    SKAction *flashAction;
    SKAction *rotation;
    
    SKLabelNode *scoreText;
    SKLabelNode *hullText;
    SKLabelNode *flashLabel;
    
    SKEmitterNode *smoke;
    
}

@property NSTimeInterval asteroidTimer;
@property NSTimeInterval AsteroidTimerUpdate;
@property NSTimeInterval shieldTimer;
@property NSTimeInterval shieldTimerUpdate;

@property (nonatomic, assign) int scoreValue;
@property (nonatomic, assign) int playerHull;
@property (nonatomic, assign) int multiplier;
@property (nonatomic, assign) int asteroidsMissed;
@property (nonatomic) BOOL pausesIncomingScene;
@end

@implementation LevelOneEndless

@synthesize multiplier;
@synthesize pausesIncomingScene;

static const uint32_t shipCategory = 1; // 0x1
static const uint32_t asteroidCategory = 2; //0x1 << 1
static const uint32_t powerUpCategory = 4; //0x1 << 2
static const uint32_t bottomEdgeCategory = 8; //0x1 << 3
static const uint32_t levelEnd = 16;  //0x1 << 4
static const uint32_t sheildCategory = 32;  //0x1 << 5

-(instancetype)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
    }
    return self;
}

-(void)didMoveToView:(SKView *)view {
    
    self.scaleMode = SKSceneScaleModeAspectFill;
    pausesIncomingScene = NO;
    
    //Create Sounds
    playCollision = [SKAction playSoundFileNamed:@"hit.mp3" waitForCompletion:NO];
    playThruster = [SKAction playSoundFileNamed:@"thruster.mp3" waitForCompletion:NO];
    playExplode = [SKAction playSoundFileNamed:@"explosion.mp3" waitForCompletion:NO];
    playPowerUp = [SKAction playSoundFileNamed:@"powerup.mp3" waitForCompletion:NO];
    playRepair = [SKAction playSoundFileNamed:@"repair.mp3" waitForCompletion:NO];
    playshield = [SKAction playSoundFileNamed:@"shieldSound.mp3" waitForCompletion:NO];
    
    
    _scoreValue = 0;
    _playerHull = 3;
    _asteroidsMissed = 0;
    multiplier = 2;
    
    //Create Physics World
    self.backgroundColor = [SKColor blackColor];
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsWorld.contactDelegate = self;
    self.physicsWorld.gravity = CGVectorMake(0.0f, -5.8f);
    
    //Create Backgrounds
    bg1 = [SKSpriteNode spriteNodeWithImageNamed:@"bg020"];
    bg1.anchorPoint = CGPointZero;
    bg1.position = CGPointMake(0, 0);
    bg1.zPosition = 0;
    [self addChild:bg1];
    
    bg2 = [SKSpriteNode spriteNodeWithImageNamed:@"bg010"];
    bg2.anchorPoint = CGPointZero;
    bg2.position = CGPointMake(0, bg1.size.height - 5);
    bg2.zPosition = 0;
    [self addChild:bg2];
    
    //Create Backgrounds
    stars1 = [SKSpriteNode spriteNodeWithImageNamed:@"stars020"];
    stars1.anchorPoint = CGPointZero;
    stars1.position = CGPointMake(0, 0);
    [self addChild:stars1];
    
    stars2 = [SKSpriteNode spriteNodeWithImageNamed:@"stars020"];
    stars2.anchorPoint = CGPointZero;
    stars2.position = CGPointMake(0, stars1.size.height - 5);
    [self addChild:stars2];
    
    repair = [SKSpriteNode spriteNodeWithImageNamed:@"repair"];
    repair.zPosition = 1.0f;
    repair.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:1];
    
    
    repair.position = CGPointMake((self.frame.size.width) /2, 66667);
    //CGPointMake(25, 10000);
    
    repair.physicsBody.categoryBitMask = powerUpCategory;
    [self addChild:repair];
    repair.physicsBody.contactTestBitMask = shipCategory;
    repair.physicsBody.collisionBitMask = 0;
    
    
    
    shieldPowerUp = [SKSpriteNode spriteNodeWithImageNamed:@"ShieldPowerUp"];
    shieldPowerUp.zPosition = 1.0f;
    shieldPowerUp.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:1];
    shieldPowerUp.position = CGPointMake((self.frame.size.width) /2, 133334);
    shieldPowerUp.physicsBody.categoryBitMask = sheildCategory;
    [self addChild:shieldPowerUp];
    shieldPowerUp.physicsBody.contactTestBitMask = shipCategory;
    shieldPowerUp.physicsBody.collisionBitMask = 0;
    
    
    //HUD
    
    //Score Label and Callout
    scoreText = [SKLabelNode labelNodeWithFontNamed:@"Arial Bold"];
    scoreText.text = @"Score";
    scoreText.fontSize = 14;
    scoreText.zPosition = 1;
    scoreText.position = CGPointMake(CGRectGetMidX(self.frame) + 70, CGRectGetMaxY(self.frame)-35);
    [self addChild:scoreText];
    
    //Hull Label and Callout
    pauseButton = [SKLabelNode labelNodeWithFontNamed:@"Arial Bold"];
    pauseButton.text = @"Pause";
    pauseButton.fontSize = 14;
    pauseButton.zPosition = 1;
    pauseButton.position = CGPointMake(CGRectGetMidX(self.frame) + 180, CGRectGetMaxY(self.frame)-35);
    [self addChild:pauseButton];
    
    multiplierText = [SKLabelNode labelNodeWithFontNamed:@"Arial Bold"];
    multiplierText.text = @"";
    multiplierText.zPosition = 1;
    multiplierText.fontSize = 30;
    multiplierText.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
    [self addChild:multiplierText];
    
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
    
    shield = [SKSpriteNode spriteNodeWithImageNamed:@"Shield"];
    shield.alpha = 0;
    [ship addChild:shield];
    
    
    
    SKNode *bottomEdge = [SKNode node];
    bottomEdge.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:CGPointMake(0, 1) toPoint:CGPointMake(self.frame.size.width, 1)];
    bottomEdge.physicsBody.categoryBitMask = bottomEdgeCategory;
    [self addChild:bottomEdge];
    bottomEdge.physicsBody.categoryBitMask = bottomEdgeCategory;
    bottomEdge.physicsBody.contactTestBitMask = asteroidCategory;
    bottomEdge.physicsBody.collisionBitMask = 0;
    
    
    //Level End
    finishLine = [SKSpriteNode spriteNodeWithImageNamed:@"finish"];
    finishLine.zPosition = 1;
    finishLine.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:1];
    finishLine.physicsBody.mass = .05;
    finishLine.position = CGPointMake(500, 200001);
    [self addChild:finishLine];
    finishLine.physicsBody.categoryBitMask = levelEnd;
    finishLine.physicsBody.contactTestBitMask = bottomEdgeCategory;
    finishLine.physicsBody.collisionBitMask = 0;
    
    
    health1 = [SKShapeNode shapeNodeWithRect: CGRectMake(0, 0, 50, 25)];
    health1.zPosition = 1;
    health1.fillColor = [SKColor greenColor];
    health1.position = CGPointMake(CGRectGetMidX(self.frame) - 150, CGRectGetMaxY(self.frame) - 60);
    [self addChild:health1];
    
    health2 = [SKShapeNode shapeNodeWithRect: CGRectMake(0, 0, 50, 25)];
    health2.zPosition = 1;
    health2.fillColor = [SKColor greenColor];
    health2.position = CGPointMake(CGRectGetMidX(self.frame) - 95, CGRectGetMaxY(self.frame) - 60);
    [self addChild:health2];
    
    health3 = [SKShapeNode shapeNodeWithRect: CGRectMake(0, 0, 50, 25)];
    health3.zPosition = 1;
    health3.fillColor = [SKColor greenColor];
    health3.position = CGPointMake(CGRectGetMidX(self.frame) -40, CGRectGetMaxY(self.frame) - 60);
    [self addChild:health3];
    
    healthText = [SKLabelNode labelNodeWithFontNamed:@"Arial Bold"];
    healthText.text = @"Ship Hull";
    healthText.position = CGPointMake(CGRectGetMidX(self.frame) -70, CGRectGetMaxY(self.frame)-25);
    [self addChild:healthText];
    
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

-(void)pauseGame
{
    
    self.scene.view.paused = YES;
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
        CGPoint touchLocation = [touch locationInNode:self];
        [self runAction:playThruster];
        
        if (touchLocation.y > self.size.height -100 && (self.scene.view.paused = !self.scene.view.paused)) {
            
            [self performSelector:@selector(pauseGame) withObject:nil afterDelay:1/60.0];
            
        }
    }
}


-(void)flashMessage:(NSString *)message atPosition:(CGPoint)position duration:(NSTimeInterval)duration{
    
    
    //make a label that is invisible
    flashLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial Bold"];
    flashLabel.position = position;
    flashLabel.fontSize = 24;
    flashLabel.fontColor = [SKColor whiteColor];
    flashLabel.text = message;
    flashLabel.alpha = .30;
    flashLabel.zPosition = 100;
    [self addChild:flashLabel];
    //make an animation sequence to flash in and out the label
    flashAction = [SKAction sequence:@[[SKAction fadeInWithDuration:duration/.5], [SKAction waitForDuration:duration], [SKAction fadeOutWithDuration:duration/.5]]];
    
    [flashLabel runAction:flashAction completion:^{[flashLabel removeFromParent];}];
    
}

//Asteroid Collision
- (void)player:(SKSpriteNode *)player didCollideWithShip:(SKSpriteNode *)asteroidHit {
    NSLog(@"Hit");
    [asteroidHit removeFromParent];
    
   
    
    if (shield.alpha != 0){
        NSLog(@"shields up");
    } else {
     
        [self flashMessage:@"OUCH!!!" atPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-30) duration:.5];
    
    _playerHull = _playerHull - 1;
    hullText.text = [NSString stringWithFormat:@"Ship Hull %i", self->_playerHull];
    
    NSLog(@"%i", _playerHull);
    _asteroidsMissed = 0;
    multiplierText.text = @"";
    
    if (_scoreValue <= 50) {
        _scoreValue = 0;
    } else {
        _scoreValue = _scoreValue - 10;
    }
    
    if (_playerHull == 2) {
        [health3 removeFromParent];
        smoke = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"smoke" ofType:@"sks"]];
        smoke.zPosition = 1;
        [ship addChild:smoke];
    }
    
    if (_playerHull == 1){
        [health2 removeFromParent];
        
    }
    
    
    if (_playerHull > 0){
        [self runAction:playCollision];
        
    }
    
    if (_playerHull == 0) {
        NSLog(@"GAME OVER");
        
        
        GameOver *gameOverScene = [GameOver sceneWithSize:self.size];
        [self.view presentScene:gameOverScene];
        
    }
    
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
    

    
    
    if ((firstBody.categoryBitMask & shipCategory) != 0 &&
        (secondBody.categoryBitMask & powerUpCategory) != 0)
    {
        [self repair:(SKSpriteNode *) firstBody.node didGetRepair:(SKSpriteNode *) secondBody.node];
    }
    
    if ((firstBody.categoryBitMask & shipCategory) != 0 &&
        (secondBody.categoryBitMask & sheildCategory) != 0)
    {
        [self shield:(SKSpriteNode *) firstBody.node didgetshield:(SKSpriteNode *) secondBody.node];
    }
    
    
    
}


-(void)shield:(SKSpriteNode *)finishLine didgetshield:(SKSpriteNode *)ship {
    
    NSLog(@"shield!!!!!");
    [self runAction:playshield];
    [shieldPowerUp removeFromParent];
    shield.alpha = 1.0;
    SKAction *fadeAction = [SKAction fadeOutWithDuration:2];
    [shield runAction:fadeAction];
    
    
}

-(void)repair:(SKNode *)finishLine didGetRepair:(SKSpriteNode *)ship {
    
    NSLog(@"repair!!!!!");
    [repair removeFromParent];
    [self runAction:playRepair];
    
    if (_playerHull == 3){
        _scoreValue = _scoreValue + 1000;
        
    }
    
    if (_playerHull == 2){
        [self addChild:health3];
        _playerHull = _playerHull + 1;
        
    }
    
    if (_playerHull == 1){
        [self addChild:health2];
        _playerHull = _playerHull + 1;
        
    }
    
    
    
}


-(void)finishLine:(SKNode *)finishLine didLevelEnd:(SKSpriteNode *)bottomEdge {
    
    NSLog(@"WIN!!!!!");
    
    
    YouWin *winScene = [YouWin sceneWithSize:self.size];
    [self.view presentScene:winScene transition:[SKTransition doorsOpenHorizontalWithDuration:(1.25)]];
    
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
        multiplierText.text = @"X2";
        [self runAction:playPowerUp];
    }
    
    if (shield.alpha != 0){
        _scoreValue = _scoreValue + 100;
        multiplierText.text = @"X5";
        //[self runAction:playPowerUp];
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
    
    asteroid.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:(asteroid.frame.size.width / 2)];
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

- (void)addShieldPowerUp {
    
    shieldPowerUp = [SKSpriteNode spriteNodeWithImageNamed:@"ShieldPowerUp"];
    int minX = asteroid.frame.size.width;
    int maxX = self.frame.size.width - asteroid.frame.size.width;
    int rangeX = maxX - minX;
    int actualX = (arc4random() % rangeX) + minX;
    
    asteroid.position = CGPointMake(actualX, self.frame.size.width + asteroid.frame.size.width/5);
    shieldPowerUp.position = CGPointMake(actualX, self.frame.size.width + shieldPowerUp.frame.size.width / 5);
    
    shieldPowerUp.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:(shieldPowerUp.frame.size.width / 2)];
    shieldPowerUp.physicsBody.dynamic = YES;
    shieldPowerUp.physicsBody.categoryBitMask = sheildCategory;
    shieldPowerUp.physicsBody.contactTestBitMask = shipCategory;
    shieldPowerUp.physicsBody.collisionBitMask =  0;
    
    [self addChild:shieldPowerUp];
    
    //int minDuration = .5;
    int duration = 2.0;
    //int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % duration);
    
    // Create the actions
    SKAction * actionMove2 = [SKAction moveTo:CGPointMake(actualX, -shieldPowerUp.frame.size.width/2) duration:actualDuration];
    SKAction * actionMoveDone2 = [SKAction removeFromParent];
    [shieldPowerUp runAction: [SKAction sequence:@[actionMove2, actionMoveDone2]]];
    
}



// Scrolling Background

-(void)moveBackground
{
    bg1.position = CGPointMake(bg1.position.x, bg1.position.y-2);
    bg2.position = CGPointMake(bg2.position.x, bg2.position.y-2);
    
    if (bg1.position.y < -bg1.size.height){
        bg1.position = CGPointMake(bg1.position.x, bg2.position.y  + bg2.size.height);
    }
    
    if (bg2.position.y < -bg2.size.height) {
        bg2.position = CGPointMake(bg2.position.x, bg1.position.y + bg1.size.height);
    }
    
    stars1.position = CGPointMake(stars1.position.x, stars1.position.y-10);
    stars2.position = CGPointMake(stars2.position.x, stars2.position.y-10);
    
    
    if (stars1.position.y < -stars1.size.height){
        stars1.position = CGPointMake(stars1.position.x, stars2.position.y  + stars2.size.height);
    }
    
    if (stars2.position.y < -stars2.size.height) {
        stars2.position = CGPointMake(stars2.position.x, stars1.position.y + stars1.size.height);
    }
    
    
    
    
}






- (void)updateWithTimeSinceLastUpdate:(CFTimeInterval)timeSinceLast {
    
    self.asteroidTimer += timeSinceLast;
    if (self.asteroidTimer > .5) {
        self.asteroidTimer = 0;
        [self addAsteroid];
    }
    
    self.shieldTimer += timeSinceLast;
    if (self.shieldTimer > .5) {
        self.shieldTimer = 0;
        [self addShieldPowerUp];
    }
    

}



    
- (void)update:(NSTimeInterval)currentTime {
    
    [self moveBackground];
    
    CFTimeInterval timeSinceLast = currentTime - self.AsteroidTimerUpdate;
    self.AsteroidTimerUpdate = currentTime;
    if (timeSinceLast > 10) {
        timeSinceLast = 1.0 / 10.0;
        self.AsteroidTimerUpdate = currentTime;
    }
  
    
    CFTimeInterval timeSinceLast2 = currentTime - self.AsteroidTimerUpdate;
    self.AsteroidTimerUpdate = currentTime;
    if (timeSinceLast2 > .1) {
        timeSinceLast2 = .1 / 200.0;
        self.AsteroidTimerUpdate = currentTime;


    }
    
    [self updateWithTimeSinceLastUpdate:timeSinceLast];
    [self updateWithTimeSinceLastUpdate:timeSinceLast2];

    }


    
@end