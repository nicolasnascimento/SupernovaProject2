//
//  GameViewController.h
//  SupernovaProject
//

//  Copyright (c) 2015 NotACompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <GameKit/GameKit.h>

@interface GameViewController : UIViewController <GKGameCenterControllerDelegate>

@property BOOL playerIsAuthenticated;

@end
