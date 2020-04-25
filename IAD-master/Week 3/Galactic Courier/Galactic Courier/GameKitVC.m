//
//  GameKitVC.m
//  Galactic Courier
//
//  Created by Jeremiah Bonham on 6/15/15.
//  Copyright (c) 2015 Jeremiah.Bonham. All rights reserved.
//

#import "GameKitVC.h"
#import "GameKitHelper.h"

@interface GameKitVC ()

@end

@implementation GameKitVC

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(showAuthenticationViewController)
     name:PresentAuthenticationViewController
     object:nil];
    
    //Check against gameCenter to make sure we have everything working.
    [[GameKitHelper sharedGameKitHelper] authenticateLocalPlayer];
}

- (void)showAuthenticationViewController
{
    GameKitHelper *gameKitUtil = [GameKitHelper sharedGameKitHelper];
    
    [self.topViewController presentViewController:
     gameKitUtil.authenticationViewController
                                         animated:YES
                                       completion:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
