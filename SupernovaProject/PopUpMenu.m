//
//  PopUpMenu.m
//  SupernovaProject
//
//  Created by Nicolas Nascimento on 27/03/15.
//  Copyright (c) 2015 NotACompany. All rights reserved.
//

#import "PopUpMenu.h"
#import "Colors.h"

@implementation PopUpMenu


-(instancetype)initWithRect:(CGRect)rect{
    self = [super init];
    
    if( self ){
        _bounds = rect;
        [self drawSelf];
        
    }
    return self;
}

-(void)drawSelf{
    
    [self createBackground];
    
    
    CGFloat fontSize = self.background.frame.size.width*0.2;
    
    [self createButtonWithImageName:@"levelButton" ratio:0.1 yRatio:-4];
    [self createButtonWithImageName:@"restartButton" ratio:0.19 yRatio:-1.25];
    self.score = [[RoundedBackgroundLabelNode alloc] initWithText:@"0" textColor:[SKColor whiteColor] backgroundColor:[Colors orangeColor] textOffsetToMargin:2.3 font:[Colors font] fontSize:fontSize];
    [self addChild:self.score];
    self.level = [SKLabelNode labelNodeWithText:@"Level Reached: 0"];
    self.level.fontName = [Colors font];
    self.level.fontSize = fontSize/4;
    self.level.fontColor = [SKColor whiteColor];
    self.level.position = CGPointMake(0, self.level.frame.size.height + self.score.frame.size.height/2);
    [self createButtonWithImageName:@"scoreButton" ratio:0.12 yRatio:3.2];
    [self createButtonWithImageName:@"gameOverLabel" ratio:0.55 yRatio:1.1];
    [self addChild:self.level];
}

-(void)createButtonWithImageName:(NSString *)name ratio:(CGFloat)ratio yRatio:(CGFloat)yRatio{
    SKSpriteNode *teste = [SKSpriteNode spriteNodeWithImageNamed:name];
    CGFloat aspectRatio = teste.frame.size.height/teste.frame.size.width;
    CGFloat widthToFit = self.background.frame.size.height*ratio;
    CGFloat heightToFit = widthToFit*aspectRatio;
    SKSpriteNode *button = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:name] size:CGSizeMake(widthToFit, heightToFit)];
    button.position = CGPointMake(0, yRatio*button.frame.size.height);
    button.name = name;
    
    [self.background addChild:button];
}

-(void)createBackground{
    self.background = [[SKShapeNode alloc] init];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:10];
    self.background.path = [path CGPath];
    
    CGFloat red = 34.0/255.0;
    CGFloat green = 59.0/255.0;
    CGFloat blue = 77.0/255.0;
    SKColor *color = [SKColor colorWithRed:red green:green blue:blue alpha:1];
    self.background.fillColor = color;
    self.background.strokeColor = [SKColor whiteColor];
    self.position = CGPointMake(-CGRectGetMidX(self.background.frame), -CGRectGetMidY(self.background.frame));
    
    [self addChild:self.background];
}

-(void)updateScoreLabelWithScore:(NSInteger)score{
    self.score.label.text = [NSString stringWithFormat:@"%ld",(long)score];
}
-(void)updateLevelLabelWithLevel:(NSInteger)level{
    self.level.text = [NSString stringWithFormat:@"Level Reached: %ld",(long)level];
}

@end
