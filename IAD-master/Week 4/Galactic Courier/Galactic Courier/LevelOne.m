//
//  GameScene.m
//  Galactic Courier
//
//  Created by Jeremiah Bonham on 5/4/15.
//  Copyright (c) 2015 Jeremiah.Bonham. All rights reserved.
//

#import "LevelOne.h"
#import "GameOver.h"
#import "YouWin.h"
#import "GameKitHelper.h"
#import "LocalLBData.h"

@interface LevelOne () {
    
    //Player Node
    SKNode *ship;
    SKNode *brokenShip;
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
    SKAction *playBGM;
    SKAction *playshield;

    SKAction *flashAction;
    SKAction *rotation;

    SKLabelNode *scoreText;
    SKLabelNode *hullText;
    SKLabelNode *gameOverText;
    SKLabelNode *flashLabel;

    SKEmitterNode *smoke;
    
}

@property NSTimeInterval asteroidTimer;
@property NSTimeInterval AsteroidTimerUpdate;

@property (nonatomic, assign) NSString* name;
@property (nonatomic, assign) int scoreValue;
@property (nonatomic, assign) int playerHull;
@property (nonatomic, assign) int multiplier;
@property (nonatomic, assign) int asteroidsMissed;
@property (nonatomic) BOOL pausesIncomingScene;

@property (nonatomic) BOOL lowFinalScore;
@property (nonatomic) BOOL lvl1;
@property (nonatomic) BOOL highFinalScore;


@property NSMutableArray* localLB;

@end

@implementation LevelOne

@synthesize multiplier;
@synthesize pausesIncomingScene;
@synthesize name;


static const uint32_t shipCategory = 1; // 0x1
static const uint32_t asteroidCategory = 2; //0x1 << 1
static const uint32_t bottomEdgeCategory = 8; //0x1 << 3
static const uint32_t levelEnd = 16;  //0x1 << 4

-(instancetype)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
    
    }
    return self;
}

-(void)didMoveToView:(SKView *)view {
    
    //Remember to comment out when done testing!!!!
    //[self resetAllAchievements];
  
    self.scaleMode = SKSceneScaleModeAspectFill;
    pausesIncomingScene = NO;
    _lowFinalScore = NO;
    _highFinalScore = NO;
    _lvl1 = NO;


    NSData *localLBData = [[NSUserDefaults standardUserDefaults] objectForKey:@"leaderboard2"];
    _localLB = [NSKeyedUnarchiver unarchiveObjectWithData:localLBData];
    
    if (_localLB == nil){
        
        _localLB = [[NSMutableArray alloc] init];
        
    }

    //Create Sounds
    playCollision = [SKAction playSoundFileNamed:@"hit.mp3" waitForCompletion:YES];
    playThruster = [SKAction playSoundFileNamed:@"thruster.mp3" waitForCompletion:YES];
    playExplode = [SKAction playSoundFileNamed:@"explosion.mp3" waitForCompletion:YES];
    playPowerUp = [SKAction playSoundFileNamed:@"powerup.mp3" waitForCompletion:YES];
    playshield = [SKAction playSoundFileNamed:@"shieldSound.mp3" waitForCompletion:NO];
    
    _scoreValue = 0;
    _playerHull = 3;
    _asteroidsMissed = 0;
    multiplier = 2;
   
    name = @"";
    
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
    
    SKNode *bottomEdge = [SKNode node];
    bottomEdge.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:CGPointMake(0, 1) toPoint:CGPointMake(self.frame.size.width, 1)];
    bottomEdge.physicsBody.categoryBitMask = bottomEdgeCategory;
    [self addChild:bottomEdge];
    bottomEdge.physicsBody.categoryBitMask = bottomEdgeCategory;
    bottomEdge.physicsBody.contactTestBitMask = asteroidCategory;
    bottomEdge.physicsBody.collisionBitMask = 0;
    
    brokenShip = [SKSpriteNode spriteNodeWithImageNamed:@"explosion"];
    brokenShip.position = ship.position;
    
    gameOverText = [SKLabelNode labelNodeWithFontNamed:@"Arial Bold"];
    gameOverText.text = @"Game Over";
    gameOverText.fontSize = 24;
    gameOverText.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    
    finishLine = [SKSpriteNode spriteNodeWithImageNamed:@"finish"];
    //finishLine.alpha = 0.0;
    finishLine.zPosition = 1;
    finishLine.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:1];
    finishLine.physicsBody.mass = .05;
    finishLine.position = CGPointMake(500, 100000);
    finishLine.physicsBody.categoryBitMask = levelEnd;
    [self addChild:finishLine];
    
    finishLine.physicsBody.categoryBitMask = levelEnd;
    finishLine.physicsBody.contactTestBitMask = bottomEdgeCategory;
    finishLine.physicsBody.collisionBitMask = 0;

    rect = [SKShapeNode shapeNodeWithRect: CGRectMake(0, 0, CGRectGetMaxX(self.frame), CGRectGetMaxY(self.frame))];
    //rect.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
    rect.zPosition = 1;
    rect.fillColor = [SKColor blackColor];
    rect.alpha = .5;

    rect2 = [SKShapeNode shapeNodeWithRect: CGRectMake(0, 0, CGRectGetMaxX(self.frame), CGRectGetMaxY(self.frame))];
    rect2.zPosition = 1;
    rect2.fillColor = [SKColor whiteColor];
    rect2.alpha = .5;
    
    [self flashMessage:@"" atPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)) duration:.1];
    
    
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
    //healthText.fontSize = 12;
    [self addChild:healthText];
    
}


//Ship Controls
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
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

-(void)pauseGame {
    
    self.scene.view.paused = YES;
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
    CGPoint touchLocation = [touch locationInNode:self];
        [self runAction:playThruster];

        if (touchLocation.y > self.size.height -100 && (self.scene.view.paused = !self.scene.view.paused)) {

          [self performSelector:@selector(pauseGame) withObject:nil afterDelay:1/60.0];
            
        }
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
       name = [alertView textFieldAtIndex:0].text;
        NSLog(@"Name Entered: %@", name);
        
        LocalLBData *currentInfo = [[LocalLBData alloc] init];
        currentInfo.playerName = [NSString stringWithString:name];
        currentInfo.scoreValue = [NSNumber numberWithUnsignedInteger:_scoreValue];
        [_localLB addObject:currentInfo];
        NSData *lbData = [NSKeyedArchiver archivedDataWithRootObject:_localLB];
        
        [[NSUserDefaults standardUserDefaults] setObject:lbData forKey:@"leaderboard2"];
        [[NSUserDefaults standardUserDefaults] synchronize];
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

        
        
        if (_scoreValue > 10000){
            NSLog(@"High Score Achiev earned!");
            _highFinalScore = YES;
            [self checkHighScoreAchiev];
        }
        
        
        
        if (_scoreValue < 500){
            NSLog(@"Bad Luck Achiev earned!");
            _lowFinalScore = YES;
            [self checkBadAtThisAchiev];
        }
        [self reportHighScore:_scoreValue];
        
//        GKScore *scoreReporter = [[GKScore alloc] initWithLeaderboardIdentifier:@"LeaderBoardAll"];
//        scoreReporter.value = _scoreValue;
//        [scoreReporter reportScoreWithCompletionHandler:^(NSError *error) {
//            if (error != nil){
//                NSLog(@"Score share Failed");
//            } else {
//                NSLog(@"Score shared");
//            }
//        }];
        
//        UIAlertView *nameAlert = [[UIAlertView alloc] initWithTitle:@"Local Leaderboard" message:@"Enter Your Name" delegate:self cancelButtonTitle:@"Add" otherButtonTitles: nil];
//        nameAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
//        UITextField * alertTextField = [alert textFieldAtIndex:0];
//        [nameAlert show];


        [[NSUserDefaults standardUserDefaults] setInteger:_scoreValue forKey:@"leaderboard2"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Hello!" message:@"Please enter your name:" delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        //UITextField * alertTextField = [alert textFieldAtIndex:0];
        [alert show];
        
        //NSLog(@"Name Entered: %@", [alertTextField text]);

        [self alertView:alert clickedButtonAtIndex:0];
        NSLog(@"Name Entered: %@", name);
        
//        LocalLBData *currentInfo = [[LocalLBData alloc] init];
//        currentInfo.playerName = [NSString stringWithString:name];
//        currentInfo.scoreValue = [NSNumber numberWithUnsignedInteger:_scoreValue];
//        [_localLB addObject:currentInfo];
//        NSData *lbData = [NSKeyedArchiver archivedDataWithRootObject:_localLB];
//        
//        [[NSUserDefaults standardUserDefaults] setObject:lbData forKey:@"leaderboard2"];
//        [[NSUserDefaults standardUserDefaults] synchronize];

        
        GameOver *gameOverScene = [GameOver sceneWithSize:self.size];
        [self.view presentScene:gameOverScene];
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
    
    if ((firstBody.categoryBitMask & levelEnd) != 0 &&
        (secondBody.categoryBitMask & bottomEdgeCategory) != 0)
    {
        [self finishLine:(SKSpriteNode *) firstBody.node didLevelEnd:(SKSpriteNode *) secondBody.node];
    }
    
    
}

-(void)finishLine:(SKNode *)finishLine didLevelEnd:(SKSpriteNode *)bottomEdge {

    NSLog(@"WIN!!!!!");
    
    [self checkLvl1Completion];
    [self checkTraining];
    [self reportHighScore:_scoreValue];
    
//    GKScore *scoreReporter = [[GKScore alloc] initWithLeaderboardIdentifier:@"LeaderBoardAll"];
//    scoreReporter.value = _scoreValue;
//    [scoreReporter reportScoreWithCompletionHandler:^(NSError *error) {
//        if (error != nil){
//            NSLog(@"Score share Failed");
//        } else {
//            NSLog(@"Score shared");
//        }
//    }];
//    
//    UIAlertView *nameAlert = [[UIAlertView alloc] initWithTitle:@"Local Leaderboards" message:@"Enter Your Name For Leaderboard" delegate:self cancelButtonTitle:@"Add" otherButtonTitles: nil];
//    nameAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
//    [nameAlert show];
//    
//    NSLog(@"The login field says %@.", [nameAlert textFieldAtIndex:0].text);
    
    [[NSUserDefaults standardUserDefaults] setInteger:_scoreValue forKey:@"leaderboard2"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    LocalLBData *currentInfo = [[LocalLBData alloc] init];
    //currentInfo.playerName = [nameAlert textFieldAtIndex:0].text;
    currentInfo.scoreValue = [NSNumber numberWithUnsignedInteger:_scoreValue];
    
    [_localLB addObject:currentInfo];
    
    NSData *lbData = [NSKeyedArchiver archivedDataWithRootObject:_localLB];
    
    [[NSUserDefaults standardUserDefaults] setObject:lbData forKey:@"leaderboard2"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
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

- (void) reportHighScore:(NSInteger) highScore {
    if ([GKLocalPlayer localPlayer].isAuthenticated) {
        GKScore* score = [[GKScore alloc] initWithLeaderboardIdentifier:@"LeaderBoardAll"];
        score.value = _scoreValue;
        [GKScore reportScores:@[score] withCompletionHandler:^(NSError *error) {
            if (error) {
                // handle error
            }
        }];
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

-(void)checkBadAtThisAchiev {
    
    bool lowScore = [[NSUserDefaults standardUserDefaults] boolForKey:@"lowScore"];
    if(!lowScore) {
        
        NSInteger finalScore = _scoreValue;
        finalScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"finalScore"];
        
        if(finalScore < 500) {
            
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"lowScore"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self reportAchievementIdentifier:@"badLuckID" percentComplete:100];
            
        }
    }
}

//Not Possible in Normal
-(void)checkHighScoreAchiev {
    
    bool highScore = [[NSUserDefaults standardUserDefaults] boolForKey:@"gl"];
    if(!highScore) {
        
        NSInteger finalScore = _scoreValue;
        finalScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"finalScore"];
        
        if(_scoreValue > 10000) {
            
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"gl"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self reportAchievementIdentifier:@"goodLuckID" percentComplete:100];
            
        }
    }
}

-(void)checkLvl1Completion {
                
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"lvl1"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self reportAchievementIdentifier:@"level1ID" percentComplete:100];

}

-(void)checkTraining {
    
    bool trainingComplete = [[NSUserDefaults standardUserDefaults] boolForKey:@"trainingComplete"];
    if(!trainingComplete) {
        
    int timesNormalCompleted = (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"timesNormalCompleted"];

        if(!timesNormalCompleted || timesNormalCompleted == 0) {
            [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"timesNormalCompleted"];
            
        }
            
        int completed = (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"timesNormalCompleted"];
            
            if(completed == 3) {
                NSLog(@"%d reached", completed);
                [self reportAchievementIdentifier:@"trainingID" percentComplete:100];
                
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"timesNormalCompleted"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            
            if(completed == 2) {
                completed ++;
                NSLog(@"%d reached", completed);
                [self reportAchievementIdentifier:@"trainingID" percentComplete:66];
                [[NSUserDefaults standardUserDefaults] setInteger:(NSInteger)completed forKey:@"timesNormalCompleted"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            
            if(completed == 1) {
                completed ++;
                NSLog(@"%d reached", completed);
                [self reportAchievementIdentifier:@"trainingID" percentComplete:33];
                [[NSUserDefaults standardUserDefaults] setInteger:(NSInteger)completed forKey:@"timesNormalCompleted"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }
    
}


            
        
        
     


- (void) reportAchievementIdentifier: (NSString*) identifier percentComplete: (float) percent
{
    GKAchievement *achievement = [[GKAchievement alloc] initWithIdentifier: identifier];
    if (achievement)
    {
        achievement.percentComplete = percent;
        achievement.showsCompletionBanner = YES;
        
        [GKAchievement reportAchievements:@[achievement] withCompletionHandler:^(NSError *error)
         {
             if (error != nil)
             {
                 NSLog(@"Error in reporting achievements: %@", error);
             } else {
                 NSLog(@"%@ Achievement reported to gameCenter", identifier);
             }
         }];
    }
}

- (void) resetAllAchievements {
    
    [GKAchievement resetAchievementsWithCompletionHandler:^(NSError *error)
     
    {
         if (error != nil) {
             NSLog(@"Could not reset achievements due to %@", error);
         } else {
             NSLog(@"Achievements Reset");
             
             [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"gl"];
             [[NSUserDefaults standardUserDefaults] synchronize];
             
             [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"lowScore"];
             [[NSUserDefaults standardUserDefaults] synchronize];
             
             [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"timesNormalCompleted"];
             [[NSUserDefaults standardUserDefaults] synchronize];
             
             [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"lvl1"];
             [[NSUserDefaults standardUserDefaults] synchronize];
            
         }
         
     }];
}

@end
