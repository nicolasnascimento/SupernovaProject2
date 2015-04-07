//
//  PopUpMenu.h
//  SupernovaProject
//
//  Created by Nicolas Nascimento on 27/03/15.
//  Copyright (c) 2015 NotACompany. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SpinnigNode.h"
#import "RoundedBackgroundLabelNode.h"

@interface PopUpMenu : SKNode <SelfDrawableSKNode>


@property (nonatomic) CGRect bounds;
@property (nonatomic) SKShapeNode *background;
@property (nonatomic) SKSpriteNode *ranking;
@property (nonatomic) SKSpriteNode *restart;
@property (nonatomic) RoundedBackgroundLabelNode *score;
@property (nonatomic) SKLabelNode *level;
@property (nonatomic) SKSpriteNode *scoreImage;
@property (nonatomic) SKSpriteNode *gameOver;

-(instancetype)initWithRect:(CGRect)rect;
-(void)updateScoreLabelWithScore:(NSInteger)score;
-(void)updateLevelLabelWithLevel:(NSInteger)level;

@end
