//
//  GameKitHelper.m
//  Galactic Courier
//
//  Created by Jeremiah Bonham on 6/13/15.
//  Copyright (c) 2015 Jeremiah.Bonham. All rights reserved.
//

#import "GameKitHelper.h"

@implementation GameKitHelper {
    BOOL _enableGameCenter;
}

NSString *const PresentAuthenticationViewController = @"PresentAuthenticationViewController";

+ (instancetype)sharedGameKitHelper
{
    static GameKitHelper *sharedGameKitHelper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedGameKitHelper = [[GameKitHelper alloc] init];
    });
    return sharedGameKitHelper;
}

- (id)init
{
    self = [super init];
    if (self) {
        _enableGameCenter = YES;
    }
    
    return self;
}

- (void)authenticateLocalPlayer
{
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    localPlayer.authenticateHandler  =
    ^(UIViewController *viewController, NSError *error) {
        [self setLastError:error];
        
        if(viewController != nil) {
            [self setAuthenticationViewController:viewController];
        } else if([GKLocalPlayer localPlayer].isAuthenticated) {
            _enableGameCenter = YES;
        } else {
            _enableGameCenter = NO;
        }
    };
}

- (void)setAuthenticationViewController:(UIViewController *)authenticationViewController {
    if (authenticationViewController != nil) {
        _authenticationViewController = authenticationViewController;
        [[NSNotificationCenter defaultCenter]
         postNotificationName:PresentAuthenticationViewController
         object:self];
    }
}

- (void)setLastError:(NSError *)error {
    _lastError = [error copy];
    if (_lastError) {
        NSLog(@"GameKitHelper ERROR: %@",
              [[_lastError userInfo] description]);
    }
}


-(void)sendScoreToLeaderBoard:(int64_t)score forLeaderboardID:(NSString *)identifier {
    
    GKScore *_score = [[GKScore alloc] initWithLeaderboardIdentifier:identifier];
    _score.value = score;
    _score.context = 0;
    _score.shouldSetDefaultLeaderboard = YES;
    
    [GKScore reportScores:@[_score] withCompletionHandler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }];
    
}

- (void) retrieveAchievmentMetadata {
    
    self.AchievementDescriptionDictionary = [[NSMutableDictionary alloc] initWithCapacity:6];
    
    [GKAchievementDescription loadAchievementDescriptionsWithCompletionHandler:
     ^(NSArray *descriptions, NSError *error) {
         if (error != nil) {
             NSLog(@"Error %@", error);
             
         } else {
             
             if (descriptions != nil) {
                 for (GKAchievementDescription* descriptionObj in descriptions) {
                     [_AchievementDescriptionDictionary setObject: descriptionObj forKey: descriptionObj.identifier];
                 }
             }
         }
    }];
}


- (void) resetAchievements {
    
    _AchievementDescriptionDictionary = [[NSMutableDictionary alloc] init];
    [GKAchievement resetAchievementsWithCompletionHandler:^(NSError *error)
     
    {
        if (error != nil)
            NSLog(@"Error %@", error);
    }];
}





@end
