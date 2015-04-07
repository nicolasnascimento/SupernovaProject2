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

@interface StartMenuScene()

/*@property (nonatomic) SKNode *startButton;
@property (nonatomic) SKNode *scoreButton;
@property (nonatomic) SKNode *settingsButton;*/
@property (nonatomic) SKSpriteNode *title;
@property (nonatomic) RoundedBackgroundLabelNode *startButton;
@property (nonatomic) RoundedBackgroundLabelNode *scoreButton;
@property (nonatomic) RoundedBackgroundLabelNode *settingsButton;
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
    NSError *error;
    NSURL *backgroundMusicURL = [[NSBundle mainBundle] URLForResource:@"telainicio1" withExtension:@"mp3"];
    self.backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
    self.backgroundMusicPlayer.numberOfLoops = -1;
    [self.backgroundMusicPlayer prepareToPlay];
    if( self.isMusicPlaying ){
        [self.backgroundMusicPlayer play];
    }
    
    self.scene.backgroundColor = [SKColor blackColor];
    self.anchorPoint = CGPointMake(0.5,0.5);
    
    SKColor* blue = [SKColor colorWithRed:50.0/255.0 green:106.0/255.0 blue:145.0/255.0 alpha:1];
    SKColor* orange = [SKColor colorWithRed:243.0/255.0 green:60.0/255.0 blue:0.0/255.0 alpha:1];
    
    self.startButton = [[RoundedBackgroundLabelNode alloc] initWithText:@"Play" textColor:blue backgroundColor:[SKColor whiteColor] textOffsetToMargin:1 font:[Colors font] fontSize:64];
    self.startButton.name = self.startButton.label.name = @"Play";
    self.scoreButton = [[RoundedBackgroundLabelNode alloc] initWithText:@"Ranking" textColor:[SKColor whiteColor] backgroundColor:orange textOffsetToMargin:1 font:@"Bangla Sangam MN" fontSize:28];
    self.scoreButton.name = self.scoreButton.label.name = @"Levels";
    
    self.settingsButton = [[RoundedBackgroundLabelNode alloc] initWithText:(self.backgroundMusicPlayer.isPlaying ? @"Sound" : @"No Sound") textColor:blue backgroundColor:[SKColor whiteColor] textOffsetToMargin:1 font:@"Bangla Sangam MN" fontSize:16];
    self.settingsButton.name = self.settingsButton.label.name = @"Sound";

    
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
    
    //background.blendMode = SKBlendModeMultiply
    
    [self createTitle];
    
    [self addChild:background];
    background.zPosition = 10;
    
    [self addChild:particles];
    particles.zPosition = 20;
    
    [self addChild:self.startButton];
    self.startButton.zPosition = 30;
    
    [self addChild:self.scoreButton];
    self.scoreButton.zPosition = 40;
    
    [self addChild:self.settingsButton];
    self.settingsButton.zPosition = 50;
    
    [self addChild:self.title];
    self.title.zPosition = 60;
}

-(void)createTitle{
    self.title = [SKSpriteNode spriteNodeWithImageNamed:@"title"];
    self.title.position = CGPointMake(0, self.frame.size.height/2 - self.title.frame.size.height*TITLE_OFFSET);
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
        if( [node.name isEqualToString:@"Sound"] ){
            if(_isMusicPlaying){
                [self.backgroundMusicPlayer stop];
                _isMusicPlaying = NO;
                self.settingsButton.label.text = @"No Sound";
            }else {
                [self.backgroundMusicPlayer play];
                _isMusicPlaying = YES;
                self.settingsButton.label.text = @"Sound";

            }
        }
    }
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
