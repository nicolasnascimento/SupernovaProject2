//
//  GameScene.m
//  SupernovaProject
//
//  Created by Nicolas Nascimento on 20/03/15.
//  Copyright (c) 2015 NotACompany. All rights reserved.
//

#import "GameScene.h"
#import "StartMenuScene.h"
#import "LevelInfo.h"
#import "OrbitNode.h"
#import "SpinnigNode.h"
#import "Planet.h"
#import "RoundedBackgroundLabelNode.h"
#import "PopUpMenu.h"
#import "Colors.h"
#import "GameViewController.h"
#import <GameKit/GameKit.h>
#import "GameViewController.h"

@interface GameScene()

@property (nonatomic) NSMutableArray *spinnigPlanets;
@property (nonatomic) SpinnigNode *centerNode;
@property (nonatomic) LevelInfo *levelInfo;
@property (nonatomic) LevelInfo *oldLevelInfo;
@property (nonatomic) RoundedBackgroundLabelNode *scoreNode;
@property (nonatomic) SKLabelNode *levelNode;

@end


@implementation GameScene

int adCount = 0;
bool paused = NO;
bool hasWatchedAd = NO;


-(void)didMoveToView:(SKView *)view {
    

    
    if( self.level <= 0 )
        self.level= 1;
    
    if(_playingMusic){
        [self playSoundWithName:@"telaJogo.mp3" extension:@"mp3"];
    }else {
        self.backgroundMusicPlayer = nil;
    }
    
    [self setLevel1];
    
}

-(void)playSoundWithName:(NSString *)name extension:(NSString *)extension{
    
    NSError *error;
    NSURL *backgroundMusicURL = [[NSBundle mainBundle] URLForResource:name withExtension:extension];
    self.backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
    self.backgroundMusicPlayer.numberOfLoops = -1;
    [self.backgroundMusicPlayer prepareToPlay];
    [self.backgroundMusicPlayer play];
}


-(void)setLevel1{
    
    if( hasWatchedAd ){
        self.levelInfo = self.oldLevelInfo;
    }
    
    if( !self.backgroundMusicPlayer.isPlaying ){
        [self.backgroundMusicPlayer prepareToPlay];
        if (!hasWatchedAd){
            [self.backgroundMusicPlayer play];
        }
    }
    
    if( self.levelInfo == nil ) {
        self.levelInfo = [LevelInfo defaultLevelInfo];
        NSLog(@"creating level");
    }else if( !hasWatchedAd ) {
        NSLog(@"goint to next level");
        self.levelInfo = [LevelInfo defaultLevelInfoWithLevel:self.levelInfo.currentLevel+1
                                                        score:self.levelInfo.currentScore
                                               spinningPeriod:self.levelInfo.spinningPeriod*0.9];
    }else{
        hasWatchedAd = NO;
        NSLog(@"has watched ad");
    }
    
    self.levelNode.text = [NSString stringWithFormat:@"Level %ld", (long)self.levelInfo.currentLevel];

    if( self.levelInfo.currentScore < 10 ){
        self.scoreNode.text = [NSString stringWithFormat:@"0%ld", (long)self.levelInfo.currentScore];
    }else{
        self.scoreNode.text = [NSString stringWithFormat:@"%ld", (long)self.levelInfo.currentScore];
    }

    
    
    [self setCurrentLevel];
}

-(void)setCurrentLevel{
    
    [self removeAllChildren];
    
    SKEmitterNode *particles = [self emitterNodeWithResourceName:@"starts" ofType:@"sks"];
    particles.alpha =0.1;
    particles.zPosition = -1;
    if( particles ) {
        [self addChild:particles];
    }
    
    SKEmitterNode *particles2 = [self emitterNodeWithResourceName:@"FireParticle" ofType:@"sks"];
    particles.alpha =0.1;
    particles.zPosition = -0.5;
    if( particles2 ){
        [self addChild:particles2];
    }
    
    self.scene.backgroundColor = [SKColor blackColor];
    self.anchorPoint = CGPointMake(0.5,0.5);
    
    self.centerNode =[[SpinnigNode alloc] initWithRadius:self.levelInfo.centerNodeRadius
                                                   color:[SKColor yellowColor]];
    self.centerNode.glowWidth = self.levelInfo.centerNodeGlowWidth;
    
    [self addChild:self.centerNode];
    
    self.spinnigPlanets = [[NSMutableArray alloc] init];
    [self generateSpinnigObjectWithAmount:self.levelInfo.spinningNodesInitialAmount
                                   Offset:self.levelInfo.spinningNodesInitialOffset];
    if( self.spinnigPlanets.count > 0 ){
        Planet *p = nil;
        p = self.spinnigPlanets[0];
        self.levelInfo.currentOrbit = 0;
        /*if(self.levelInfo.currentOrbit >= self.spinnigPlanets.count){
            p = self.spinnigPlanets[self.levelInfo.currentOrbit % self.spinnigPlanets.count];
            p = self.spinnigPlanets[0];
            self.levelInfo.currentOrbit = 0;
        }
        else{
            p = self.spinnigPlanets[self.levelInfo.currentOrbit];
        }*/
        [p highlightOrbitWithGlowWidth:self.levelInfo.spinningNodesGlowWidth*3];
    }

    self.levelNode = [self generateLabelNodeWithString:[NSString stringWithFormat:@"Level %ld",(long)self.levelInfo.currentLevel]];
    self.levelNode.position = CGPointMake(0, -self.frame.size.height/2.2 + self.levelNode.frame.size.height*1.1);
    [self addChild:self.levelNode];
    
    
    if( self.levelInfo.currentScore < 10 ){
        self.scoreNode = [self generateRoundedBackgroundLabelNodeWithString:[NSString stringWithFormat:@"0%ld",(long)self.levelInfo.currentScore]];
    }else{
        self.scoreNode = [self generateRoundedBackgroundLabelNodeWithString:[NSString stringWithFormat:@"%ld",(long)self.levelInfo.currentScore]];
    }
    self.scoreNode.position = CGPointMake(0, self.frame.size.height/2 - self.scoreNode.frame.size.height*0.6);
    [self addChild:self.scoreNode];
}

-(SKEmitterNode *)emitterNodeWithResourceName:(NSString *)name ofType:(NSString *)type{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:name ofType:type];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}

-(SKColor *)randomColor{
    CGFloat red=0.0;
    CGFloat green=0.0;
    CGFloat blue=0.0;
    
    BOOL corOk=YES;
    
    while(corOk){
        
        red = ((arc4random() % 255));
        green = ((arc4random() % 255));
        blue = ((arc4random() % 255));
    
        if(((green>red-15)&&(green<red+15))||((green>blue-15)&&(green<blue+15))){
            corOk=YES;
        }else if((50>red-25&&50<red+25)&&(50>green-25&&50<green+25)&&(50>blue-25&&50<blue+25)){
            corOk=YES;
        }else if(red+green+blue<200){
            corOk=YES;
        }else{
            corOk=NO;
        }
    }

    red=red/255.0;
    green=green/255.0;
    blue=blue/255.0;
    
    return [SKColor colorWithRed:red green:green blue:blue alpha:1];
}

-(CGFloat)generateRandomRadiusWithMaximumRadius:(CGFloat)maximum Minimum:(CGFloat)minimum range:(NSUInteger)range{
    NSUInteger random = arc4random() % range;
    NSUInteger increment = (maximum - minimum)/range;
    CGFloat radius = minimum + increment*random;
    
    return radius;
}

-(void)generateSpinnigObjectWithAmount:(NSUInteger)amount Offset:(double)offset{
    
    CGFloat realOffset = self.centerNode.radius/2;
    
    while( realOffset < self.frame.size.width/2 ){
        CGFloat radius = [self generateRandomRadiusWithMaximumRadius:self.levelInfo.spinningNodesRadius*2 Minimum:self.levelInfo.spinningNodesRadius range:2];
        realOffset += radius*offset;
        
        OrbitNode *orbit = [[OrbitNode alloc] initWithRadius:realOffset color:[self randomColor] lineWidth:1];
        
        OrbitNode *safeSpot = [[OrbitNode alloc] initWithRadius:radius*1.5 color:[SKColor greenColor] lineWidth:1];
        SpinnigNode *node = [[SpinnigNode alloc] initWithRadius:radius color:[self randomColor]];
        node.fillColor = [self randomColor];
        node.strokeColor = node.fillColor;
        
        NSInteger random = arc4random() % 2;
        NSInteger random2 = arc4random() % 2;
        NSInteger random3 = arc4random() % 2;
        NSInteger rate = arc4random() % 5;
        
        BOOL orientation = (random+1) % 2 == 0 ? YES : NO;
        BOOL orientation2 = (random2+1) % 2 == 0 ? YES : NO;
        BOOL safeSpotShouldSpin = (random3) % 2 == 0 ? YES : NO;
        
        if( orientation == orientation2 && safeSpotShouldSpin && rate == 0 ){
            rate = 2;
        }
        Planet *planet = [[Planet alloc] initWithPlanet:node Orbit:orbit SafeSpot:safeSpot ShouldSpin:YES SpinnigDuration:self.levelInfo.spinningPeriod clockWiseSpin:orientation safeSpotShouldSpin:safeSpotShouldSpin safeSpotClockWiseSpin:orientation2 safeSpotSpinningDuration:self.levelInfo.spinningPeriod*(rate+1)];

        [self addChild:planet];
        [self.spinnigPlanets addObject:planet];
        
    }
    self.levelInfo.spinningNodesInitialAmount = self.spinnigPlanets.count;
}


-(SKLabelNode *)generateLabelNodeWithString:(NSString *)string{
    SKLabelNode *node = [SKLabelNode labelNodeWithText:string];
    node.fontColor = [SKColor whiteColor];
    node.fontName = [Colors font];
    node.fontSize = 40;
    return node;
}

-(RoundedBackgroundLabelNode *)generateRoundedBackgroundLabelNodeWithString:(NSString*)string{
    return [[RoundedBackgroundLabelNode alloc] initWithText:string textColor:[SKColor whiteColor] backgroundColor:[Colors orangeColor] textOffsetToMargin:1.5 font:[Colors font] fontSize:32];
}

-(void)saveScore{
    
    GameViewController *rootViewController =(GameViewController*) self.view.window.rootViewController;
    if( rootViewController.playerIsAuthenticated ){
        // Name for ranking created at iTunes Connect
        NSString *leaderboardIdentifier = @"grp.GeneralRanking";
        
        GKScore *score = [[GKScore alloc] initWithLeaderboardIdentifier:leaderboardIdentifier];
        GKLeaderboard *leaderboardRequest = [[GKLeaderboard alloc]init];
        leaderboardRequest.identifier = leaderboardIdentifier;
        

        
        if( score ){
            NSLog(@"Score");
            score.value = self.levelInfo.currentScore;
            score.context = 0;
            NSInteger thisScore = self.levelInfo.currentScore;
            
            [GKScore reportScores:@[score] withCompletionHandler:^(NSError *error) {
                if( error ){
                    NSLog(@"ERROR REPORTING SCORE\n%@",error);
                }else{
                    NSLog(@"SUCESS REPORTING SCORE");
                    [leaderboardRequest loadScoresWithCompletionHandler:^(NSArray *scores, NSError *error) {
                        if (error) {
                            NSLog(@"%@", error);
                        } else if (scores) {
                            NSLog(@"SAVED");
                            GKScore *bestScore = leaderboardRequest.localPlayerScore;
                            if (thisScore > bestScore.value) {
                                bestScore.value = thisScore;
                            }
                            NSUserDefaults *data = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.supernova.OrbitAll"];
                            [data setObject:[NSNumber numberWithInteger:bestScore.value] forKey:[NSString stringWithFormat:@"local"]];
                            [data synchronize];
                        }
                    }];
                    
                }
            }];
        }else{
            NSLog(@"Error Loading Score");
        }
    }
}

-(void)showIncentivizedAd{
    [[UnityAds sharedInstance] setZone:@"rewardedVideoZone"];
    
    if ([[UnityAds sharedInstance] canShow] && [[UnityAds sharedInstance] canShowAds])
    {
        [[UnityAds sharedInstance] show];
    }
}

-(void)showAd{
    GameViewController *rootViewController =(GameViewController*) self.view.window.rootViewController;
    if ([rootViewController.interstitial isReady]) {
        [rootViewController.interstitial presentFromRootViewController:rootViewController];
        [rootViewController setupAd];
    }
}

-(void)showPopUpMenu{
    
    CGFloat ratio = 0.8;
    CGFloat width = self.frame.size.width*ratio;
    CGFloat height = self.frame.size.height*ratio;
    
    PopUpMenu *menu = [[PopUpMenu alloc] initWithRect:CGRectMake(-width/2, -height/2, width, height)];
    menu.position = CGPointMake(0, CGRectGetMaxY(self.frame)*2);
    [self addChild:menu];
    menu.zPosition = 1000;
    menu.alpha = 0;
    [menu updateScoreLabelWithScore:self.levelInfo.currentScore];
    [menu updateLevelLabelWithLevel:self.levelInfo.currentLevel];
    
    SKAction *slideDown = [SKAction moveToY:0 duration:0.3];
    SKAction *fade = [SKAction fadeAlphaTo:1 duration:0.3];
    SKAction *group = [SKAction group:@[slideDown,fade]];
    [menu runAction:group];
}

-(CGSize)sizeForImage:(NSString*)imageName ratio:(CGFloat)ratio{
    SKSpriteNode *image = [SKSpriteNode spriteNodeWithImageNamed:imageName];
    
    CGFloat aspectRatio = image.frame.size.height/image.frame.size.width;
    CGFloat widthToFit = image.frame.size.height*ratio;
    CGFloat heightToFit = widthToFit*aspectRatio;
    
    return CGSizeMake(widthToFit, heightToFit);
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    for( UITouch *touch in touches ){
        
        CGPoint position = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:position];
        if( [node.name isEqualToString:@"goButton"] ){
            //self.level++;
            //[self setSceneForCurrentLevel];
            //[self setLevel1];
        }else if( [node.name isEqualToString:@"levelButton"] ){
            paused = NO;
            [self removeAllChildren];
            StartMenuScene *scene = [StartMenuScene unarchiveFromFile:@"StartScene"];
            scene.isMusicPlaying = _playingMusic;
            scene.firstTime = YES;
            scene.scaleMode = SKSceneScaleModeAspectFill;
            SKTransition *transition = [SKTransition fadeWithDuration:1.0];
            
            [self.view presentScene:scene transition:transition];
            
        }else if( [node.name isEqualToString:@"restartButton"] ){
            paused = NO;
            [self setLevel1];
        }else if( [node.name isEqualToString:@"resetWithVideoIcon"] && hasWatchedAd == NO) {
            NSLog(@"resetwithvideo");
            paused = NO;
            hasWatchedAd = YES;
            [self showIncentivizedAd];
            [self setLevel1];
        }else if( paused ){
            NSLog(@"continue");
            continue;
        }else if( self.levelInfo.currentOrbit == self.spinnigPlanets.count-1 ){
            NSLog(@"lastorbit");
            Planet *p = self.spinnigPlanets[self.levelInfo.currentOrbit];
            if( [p planetIsInsideSafeSpot] ){
                if( _playingMusic ){
                    [self runAction:[SKAction playSoundFileNamed:@"001.mp3" waitForCompletion:NO]];
                }
                self.levelInfo.currentScore++;
                [self setLevel1];
            }else if( !paused ){
                [self endCurrentLevel];
                paused = YES;
            }
        }else{
            NSLog(@"checkcurrentorbit");
            [self checkCurrentOrbit];
        }
    }
    
}

-(void)checkCurrentOrbit{
    NSUInteger countLines = [self.spinnigPlanets count];
    if( self.levelInfo.currentOrbit < countLines ){
        [self stopRotationForCurrentNode];
        [self unhighlightCurrentPlanet];
        
        Planet *p = self.spinnigPlanets[self.levelInfo.currentOrbit];
        if( [p planetIsInsideSafeSpot] && !paused){
            if (_playingMusic){
                [self runAction:[SKAction playSoundFileNamed:@"001.mp3" waitForCompletion:NO]];
            }
            self.levelInfo.currentScore = [self.scoreNode.label.text floatValue];
            self.levelInfo.currentScore++;
            self.levelInfo.currentOrbit++;
            if( self.levelInfo.currentScore < 10 ){
                self.scoreNode.label.text = [NSString stringWithFormat:@"0%ld", (long)self.levelInfo.currentScore];
            }else{
                self.scoreNode.label.text = [NSString stringWithFormat:@"%ld", (long)self.levelInfo.currentScore];
            }
        }
        else {
            [self endCurrentLevel];
            paused = YES;
        }
        
        [self highlightCurrentPlanet];
    }
}

-(void)unhighlightCurrentPlanet{
    if( self.levelInfo.currentOrbit < self.spinnigPlanets.count ){
        Planet *p = self.spinnigPlanets[self.levelInfo.currentOrbit];
        [p unhighlight];
    }
}

-(void)highlightCurrentPlanet{
    
    if( self.levelInfo.currentOrbit < self.spinnigPlanets.count ){
        Planet *p = self.spinnigPlanets[self.levelInfo.currentOrbit];
        [p highlightOrbitWithGlowWidth:self.levelInfo.spinningNodesGlowWidth*3];
    }
}

-(void)endCurrentLevel{
    
    if( !paused ){
        [self.backgroundMusicPlayer stop];
        [self stopRotationForAllNodes];
        [self removeGlowForAllNodes];
        if (_playingMusic) {
            [self runAction:[SKAction playSoundFileNamed:@"wrong.mp3" waitForCompletion:NO]];
        }
        if( !hasWatchedAd ) {
            NSLog(@"HAS WATCHED AD IN \"END CURRENT LEVEL\"");
            [self showPopUpMenu];
            [self saveScore];
            adCount++;
            if (adCount == 5){
            adCount = 0;
                [self showAd];
            }
            self.oldLevelInfo = self.levelInfo;
            self.levelInfo = nil;
        }
        
    }
}

-(void)stopRotationForCurrentNode{
    
    if( self.levelInfo.currentOrbit < self.spinnigPlanets.count ){
        Planet *p = self.spinnigPlanets[self.levelInfo.currentOrbit];
        if( p ){
            [p stopPlanetSpinning];
            [p fitToSafeSpot];
        }
    }
}

-(void)stopRotationForAllNodes{
    for( Planet *node in self.spinnigPlanets ){
        [node stopPlanetSpinning];
    }
}
-(void)removeGlowForAllNodes{
    for( Planet* node in self.spinnigPlanets ){
        [node unhighlight];
    }
}


-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    
}

@end
