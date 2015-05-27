//
//  StartMenuScene.m
//  SupernovaProject
//
//  Created by Nicolas Nascimento on 22/03/15.
//  Copyright (c) 2015 NotACompany. All rights reserved.
//

#import "StartMenuScene.h"
#import "GameScene.h"
#import "Util.h"
#import "RoundedBackgroundLabelNode.h"
#import "Colors.h"
#import <AVFoundation/AVFoundation.h>
#import <GameKit/GameKit.h>
#import "GameViewController.h"


@interface StartMenuScene()

@property (nonatomic) SKNode *startButton;
@property (nonatomic) SKNode *scoreButton;
@property (nonatomic) SKNode *settingsButton;
@property (nonatomic) SKSpriteNode *title;
/*@property (nonatomic) RoundedBackgroundLabelNode *startButton;
@property (nonatomic) RoundedBackgroundLabelNode *scoreButton;
@property (nonatomic) RoundedBackgroundLabelNode *settingsButton;*/
@property (nonatomic) AVAudioPlayer *backgroundMusicPlayer;


@end

@implementation StartMenuScene

#define BUTTON_OFFSET 1.1
#define BACKGROUND_OFFSET_TO_TEXT 1.5
#define BUTTON_GLOW_WIDTH 0.0
#define TITLE_OFFSET 2.0


-(void)didMoveToView:(SKView *)view{
    

    if( !self.firstTime )
        _isMusicPlaying = YES;
    
    if( self.isMusicPlaying ){
        NSError *error;
        NSURL *backgroundMusicURL = [[NSBundle mainBundle] URLForResource:@"telainicio1" withExtension:@"mp3"];
        self.backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
        self.backgroundMusicPlayer.numberOfLoops = -1;
        [self.backgroundMusicPlayer prepareToPlay];
        [self.backgroundMusicPlayer play];
    }else{
        self.backgroundMusicPlayer = nil;
    }
    
    self.scene.backgroundColor = [SKColor blackColor];
    self.anchorPoint = CGPointMake(0.5,0.5);

    
    self.startButton = [SKSpriteNode spriteNodeWithImageNamed:@"goButton"];
    self.startButton.xScale = self.startButton.yScale = 0.5;
    self.startButton.name = @"Play";

    
    self.scoreButton = [SKSpriteNode spriteNodeWithImageNamed:@"rankingIcon2-1"];
    self.scoreButton.xScale = self.scoreButton.yScale = 0.5;
    self.scoreButton.name = @"Ranking";
    
    self.settingsButton = [SKSpriteNode spriteNodeWithImageNamed:(self.backgroundMusicPlayer.isPlaying ? @"unmuteIcon" : @"mute")];
    self.settingsButton.xScale = self.settingsButton.yScale = 0.4;
    self.settingsButton.name = @"Sound";

    
    self.startButton.position = CGPointMake(0, self.frame.size.height/8);
    self.scoreButton.position = CGPointMake(0 , ((self.startButton.position.y - self.startButton.frame.size.height/2 - self.scoreButton.frame.size.height/2) * BUTTON_OFFSET) - 18);
    
    self.settingsButton.position = CGPointMake(0 , (self.scoreButton.position.y - self.scoreButton.frame.size.height/2 - self.settingsButton.frame.size.height/2) * BUTTON_OFFSET);
    
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"background2"];
    background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    
    // code to add particles to background
    NSString *url = [[NSBundle mainBundle] pathForResource:@"starts" ofType:@"sks"];
    SKEmitterNode *particles = [NSKeyedUnarchiver unarchiveObjectWithFile:url];
//    [background addChild:particles];
    particles.alpha = 0.05;
    
    [self createTitle];
    
    [self addChild:background];
    //background.zPosition = 10;
//
    [self addChild:particles];
//    particles.zPosition = 20;
//    
    [self addChild:self.startButton];
    self.startButton.zPosition = 30;
//
    [self addChild:self.scoreButton];
    self.scoreButton.zPosition = 40;
//
    [self addChild:self.settingsButton];
    self.settingsButton.zPosition = 50;
//
    [self addChild:self.title];
    self.title.zPosition = 60;

}

-(void)createTitle{

    self.title = [SKSpriteNode spriteNodeWithImageNamed:@"title"];

    
    self.title.position = CGPointMake(0, self.frame.size.height/2 - self.title.frame.size.height*TITLE_OFFSET);
}

-(void)showLeaderboardAndAchievements:(BOOL)shouldShowLeaderboard{
    GKGameCenterViewController *gcViewController = [[GKGameCenterViewController alloc] init];
    
    gcViewController.gameCenterDelegate = (GameViewController *)self.view.window.rootViewController;

    
    if (shouldShowLeaderboard) {
        gcViewController.viewState = GKGameCenterViewControllerStateLeaderboards;
        gcViewController.leaderboardIdentifier = @"GeneralRanking";
    }
    else{
        gcViewController.viewState = GKGameCenterViewControllerStateAchievements;
    }
    
    [self.view.window.rootViewController presentViewController:gcViewController animated:YES completion:nil];
}

-(void)startPlayMusic{
    //if( !self.firstTime )
      //  _isMusicPlaying = YES;
    NSError *error;
    NSURL *backgroundMusicURL = [[NSBundle mainBundle] URLForResource:@"telainicio1" withExtension:@"mp3"];
    self.backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
    self.backgroundMusicPlayer.numberOfLoops = -1;
    [self.backgroundMusicPlayer prepareToPlay];
    if( self.isMusicPlaying ){
        [self.backgroundMusicPlayer play];
    }
}
-(void)stopPlayMusic{
    self.backgroundMusicPlayer = nil;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    for( UITouch *touch in touches ){
        SKNode *node = [self nodeAtPoint:[touch locationInNode:self]];
        
        if( [node.name isEqualToString:@"Play"] ){
            [self.backgroundMusicPlayer stop];
            if(_isMusicPlaying){
                [self.startButton runAction:[SKAction playSoundFileNamed:@"002.mp3" waitForCompletion:NO]];
            }
            [self runAnimationForGameStart];
        }
        
        if( [node.name isEqualToString:@"Ranking"] ){
            [self showLeaderboardAndAchievements:YES];
        }
        
        if( [node.name isEqualToString:@"Sound"] ){
            if(_isMusicPlaying){
                _isMusicPlaying = NO;
                [self stopPlayMusic];
                [self recreateSettingsButtonWithName:@"mute"];
            }else {
                _isMusicPlaying = YES;
                [self startPlayMusic];
                [self recreateSettingsButtonWithName:@"unmuteIcon"];
                
            }
        }
    }
}

-(void)recreateSettingsButtonWithName:(NSString *)name{
    [self.settingsButton removeFromParent];
    self.settingsButton = [SKSpriteNode spriteNodeWithImageNamed:name];
    self.settingsButton.name = @"Sound";
    self.settingsButton.zPosition = 50;
    self.settingsButton.xScale = self.settingsButton.yScale = 0.4;
    self.settingsButton.position = CGPointMake(0 , (self.scoreButton.position.y - self.scoreButton.frame.size.height/2 - self.settingsButton.frame.size.height/2) * BUTTON_OFFSET);
    [self addChild:self.settingsButton];
}


-(void)runAnimationForGameStart{
    
    SKAction *moveLeft = [SKAction moveToX:self.frame.size.width/2 duration:1];
    SKAction *moveRight = [SKAction moveToX:-self.frame.size.width/2 duration:1];
    SKAction *fade = [SKAction fadeAlphaTo:0 duration:1];
    [self.title runAction:fade];
    [self.startButton runAction:moveRight completion:^{
        GameScene *scene = [[GameScene alloc] initWithSize:self.view.frame.size]; //[GameScene unarchiveFromFile:@"GameScene"];
        scene.playingMusic = _isMusicPlaying;
        scene.scaleMode = SKSceneScaleModeResizeFill;
        SKTransition *transition = [SKTransition fadeWithDuration:1.0];
        
        [self.view presentScene:scene transition:transition];
    }];
    [self.scoreButton runAction:moveLeft];
    [self.settingsButton runAction:moveRight];
}




@end
