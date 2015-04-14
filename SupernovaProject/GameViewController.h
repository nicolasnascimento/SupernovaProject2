//
//  GameViewController.h
//  SupernovaProject
//

//  Copyright (c) 2015 NotACompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <GameKit/GameKit.h>
#import <iAd/iAd.h>

@interface GameViewController : UIViewController <GKGameCenterControllerDelegate, ADBannerViewDelegate>

@property BOOL playerIsAuthenticated;
@property (nonatomic, strong) ADBannerView *banner;

@end
