//
//  GameViewController.m
//  SupernovaProject
//
//  Created by Nicolas Nascimento on 20/03/15.
//  Copyright (c) 2015 NotACompany. All rights reserved.
//
@import GoogleMobileAds;


#import "GameViewController.h"
#import "GameScene.h"
#import "StartMenuScene.h"
#import "Util.h"
#import <GameKit/GameKit.h>

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self setGameCenter];
    [self setUpScene];
    [self setLeaderboard];
    
    self.bannerView.adUnitID = @"ca-app-pub-8789333906443858/4175135124";
    self.bannerView.rootViewController = self;
    [self.bannerView loadRequest:[GADRequest request]];
    
    [self setupAd];
    
    [[UnityAds sharedInstance] setDelegate:self];

}

-(void)setupAd{
    self.interstitial = [[GADInterstitial alloc] init];
    self.interstitial.adUnitID = @"ca-app-pub-8789333906443858/5931069920";
    
    GADRequest *request = [GADRequest request];
    // Requests test ads on test devices.
    request.testDevices = @[@"2077ef9a63d2b398840261c8221a0c9b"];
    [self.interstitial loadRequest:request];
}


-(void)setUpScene{
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.ignoresSiblingOrder = YES;
    
    // Create and configure the scene.
    StartMenuScene *scene = [StartMenuScene unarchiveFromFile:@"StartScene"];

    
    scene.scaleMode = SKSceneScaleModeAspectFill;
    //scene.parent = self;
    
    // Present the scene.
    [skView presentScene:scene];
    //gameScene.delegateContainerViewController=self;

    
}

-(void) unityAdsVideoCompleted:(NSString *)rewardItemKey skipped:(BOOL)skipped{
    SKView * skView = (SKView *)self.view;
    GameScene *scene = (GameScene *)skView.scene;
    [scene.backgroundMusicPlayer play];
}

-(void)setGameCenter{
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error){
        if (viewController != nil){
            [self presentViewController:viewController animated:YES completion:nil];
        }
        else if ([GKLocalPlayer localPlayer].isAuthenticated){
            NSLog(@"enableGameCenter");
            self.playerIsAuthenticated = YES;
        }
        else{
            //[self disableGameCenter];
            self.playerIsAuthenticated = NO;
            NSLog(@"%@",error);
        }
    };
}

-(void)setLeaderboard{
    GKLeaderboard *leaderboardRequest = [[GKLeaderboard alloc] init];
    leaderboardRequest.identifier = @"grp.GeneralRanking";
    [leaderboardRequest loadScoresWithCompletionHandler:^(NSArray *scores, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        } else if (scores) {
            for (int i=0; i<leaderboardRequest.scores.count && i < 3; i++) {
                GKScore *score = scores[i];
                if( score ){
                    score.context = 0;
                }
                //NSLog(@"Local player's score: %@", score.player.alias);
                
                NSUserDefaults *data = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.supernova.OrbitAll"];
                [data setObject:[NSNumber numberWithInteger:score.value] forKey:[NSString stringWithFormat:@"score%d",i]];
                [data setObject:score.player.alias forKey:[NSString stringWithFormat:@"name%d",i]];
                [data synchronize];
                
                
            }
        }
    }];
}

-(void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController{
    [gameCenterViewController dismissViewControllerAnimated:YES completion:nil];
    //[self setUpScene];
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
