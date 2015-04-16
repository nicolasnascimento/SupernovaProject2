//
//  GameViewController.h
//  SupernovaProject
//

//  Copyright (c) 2015 NotACompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <GameKit/GameKit.h>

@import GoogleMobileAds;

@interface GameViewController : UIViewController <GKGameCenterControllerDelegate, GADInterstitialDelegate>

@property BOOL playerIsAuthenticated;
@property (strong, nonatomic) IBOutlet GADBannerView *bannerView;
@property(nonatomic, strong) GADInterstitial *interstitial;

-(void)setupAd;

@end
