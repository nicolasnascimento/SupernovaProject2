//
//  StartMenuScene.h
//  SupernovaProject
//
//  Created by Nicolas Nascimento on 22/03/15.
//  Copyright (c) 2015 NotACompany. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface StartMenuScene : SKScene <SKSceneDelegate>


@property (nonatomic) BOOL firstTime;
@property (nonatomic) BOOL isMusicPlaying;

-(void)showGameCenterFromHandoff;
-(void)showLeaderboardAndAchievements:(BOOL)shouldShowLeaderboard;

@end
