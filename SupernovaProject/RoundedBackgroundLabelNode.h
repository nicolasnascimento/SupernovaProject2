//
//  RoundedBackgroundLabelNode.h
//  SupernovaProject
//
//  Created by Nicolas Nascimento on 29/03/15.
//  Copyright (c) 2015 NotACompany. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SpinnigNode.h"

@interface RoundedBackgroundLabelNode : SKShapeNode <SelfDrawableSKNode>

@property (nonatomic) NSString *text;
@property (nonatomic) CGFloat offset;
@property (nonatomic) SKColor *textColor;
@property (nonatomic) SKColor *backgroundColor;
@property (nonatomic) NSString* font;
@property (nonatomic) CGFloat fontSize;
@property (nonatomic) SKLabelNode *label;

-(instancetype)initWithText:(NSString*)text textColor:(SKColor*)color backgroundColor:(SKColor*)backgroundColor textOffsetToMargin:(CGFloat)offset font:(NSString *)font fontSize:(CGFloat)size;

@end
