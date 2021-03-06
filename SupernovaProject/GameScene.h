//
//  GameScene.h
//  SupernovaProject
//

//  Copyright (c) 2015 NotACompany. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Util.h"
#import <AVFoundation/AVFoundation.h>


@interface GameScene : SKScene

// the level for the game
@property (nonatomic) NSInteger level;
@property (nonatomic) BOOL playingMusic;
@property (nonatomic) AVAudioPlayer *backgroundMusicPlayer;


@end
