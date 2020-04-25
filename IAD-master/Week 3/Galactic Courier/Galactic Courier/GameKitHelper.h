//
//  GameKitHelper.h
//  Galactic Courier
//
//  Created by Jeremiah Bonham on 6/13/15.
//  Copyright (c) 2015 Jeremiah.Bonham. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

extern NSString *const PresentAuthenticationViewController;
extern NSString *const LocalPlayerIsAuthenticated;

@interface GameKitHelper : NSObject

@property (nonatomic, readonly) UIViewController *authenticationViewController;
@property (nonatomic, readonly) NSError *lastError;

+ (instancetype)sharedGameKitHelper;
- (void)authenticateLocalPlayer;
- (void) sendScoreToLeaderBoard: (int64_t)score forLeaderboardID:(NSString*)identifier;


@end