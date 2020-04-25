//
//  LeaderBoard.m
//  Galactic Courier
//
//  Created by Jeremiah Bonham on 6/15/15.
//  Copyright (c) 2015 Jeremiah.Bonham. All rights reserved.
//

#import "LeaderBoard.h"
#import "TitleScreen.h"
#import "LocalLBData.h"

@interface LeaderBoard () <UITableViewDataSource, UITableViewDelegate>
{
    SKLabelNode *leaderBoardTitle;
    SKLabelNode *returnToMenu;
    SKLabelNode *share;

    SKSpriteNode *bg1;
    SKSpriteNode *stars1;

}

@property NSMutableArray* localLB;

@property (nonatomic) UITableView *lbTable;
@property (nonatomic) UISegmentedControl *tableTitle;
@property (nonatomic) NSArray *cellText;
@property (nonatomic) LocalLBData *score;

@end

@implementation LeaderBoard

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
    
    leaderBoardTitle = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
    leaderBoardTitle.text = @"Local Leaderboard";
    leaderBoardTitle.fontColor = [SKColor greenColor];
    leaderBoardTitle.fontSize = 40;
    leaderBoardTitle.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame) - 100);
    [self addChild:leaderBoardTitle];
    
    _lbTable = [[UITableView alloc] initWithFrame:CGRectMake(200, 230, 400, 500)];
    _lbTable.delegate = self;
    _lbTable.dataSource = self;
    [self.view addSubview:_lbTable];
    
    _tableTitle = [[UISegmentedControl alloc] initWithItems:@[@"Highest Scores"]];
    _tableTitle.frame = CGRectMake(200, 200, 400, 30);
    _tableTitle.selectedSegmentIndex = 0;
    [self.view addSubview:_tableTitle];
    [_lbTable reloadData];

    share = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
    share.text = @"Share to Facebook";
    share.fontSize = 30;
    share.fontColor = [SKColor greenColor];
    share.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMinY(self.frame) + 150);
    [self addChild:share];
 
    returnToMenu = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
    returnToMenu.text = @"Main Menu";
    returnToMenu.fontSize = 30;
    returnToMenu.fontColor = [SKColor greenColor];
    returnToMenu.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMinY(self.frame) + 100);
    [self addChild:returnToMenu];
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"leaderboard"];
    _localLB = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    if (_localLB == nil){
        
        _localLB = [[NSMutableArray alloc] init];
     
    } else {
        
        _cellText = [_localLB sortedArrayUsingComparator:^NSComparisonResult(LocalLBData *firstVal, LocalLBData *secondVal) {
        return [secondVal.scoreValue compare:firstVal.scoreValue];
        }];
    }
    
    [_lbTable reloadData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = @"cell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    _score = [_cellText objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", _score.playerName];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", _score.scoreValue];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    [_cellText count];
    return [_cellText count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    _score = [_cellText objectAtIndex:indexPath.row];
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self.scene];

    if(CGRectContainsPoint(returnToMenu.frame, touchLocation)) {
    NSLog(@"Return");
        [_lbTable removeFromSuperview];
        _lbTable = nil;
        
        [_tableTitle removeFromSuperview];
        _tableTitle = nil;
         
        TitleScreen *firstScene = [TitleScreen sceneWithSize:self.size];
        [self.view presentScene:firstScene transition:[SKTransition doorsCloseHorizontalWithDuration:(1.25)]];
      
    }
}

@end
