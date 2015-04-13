//
//  GameViewController.m
//  SupernovaProject
//
//  Created by Nicolas Nascimento on 20/03/15.
//  Copyright (c) 2015 NotACompany. All rights reserved.
//

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
}

-(void)setUpScene{
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    //skView.showsFPS = YES;
    //skView.showsNodeCount = YES;
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    skView.ignoresSiblingOrder = YES;
    
    // Create and configure the scene.
    StartMenuScene *scene = /*[[StartMenuScene alloc] initWithSize:self.view.frame.size];*/[StartMenuScene unarchiveFromFile:@"StartScene"];
    
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
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

-(void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController{
    [self setUpScene];
}

- (BOOL)shouldAutorotate
{
    return YES;
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
