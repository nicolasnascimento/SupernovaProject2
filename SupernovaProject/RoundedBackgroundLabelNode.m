//
//  RoundedBackgroundLabelNode.m
//  SupernovaProject
//
//  Created by Nicolas Nascimento on 29/03/15.
//  Copyright (c) 2015 NotACompany. All rights reserved.
//

#import "RoundedBackgroundLabelNode.h"

@implementation RoundedBackgroundLabelNode

-(instancetype)initWithText:(NSString *)text textColor:(UIColor *)color backgroundColor:(UIColor *)backgroundColor textOffsetToMargin:(CGFloat)offset font:(NSString *)font fontSize:(CGFloat)size{
    self = [super init];
    
    if( self ){
        _text = text;
        _textColor = color;
        _backgroundColor = backgroundColor;
        _offset = offset;
        _font = font;
        _fontSize = size;
        [self drawSelf];
    }
    
    return self;
}

-(void)drawSelf{
    self.label = [SKLabelNode labelNodeWithText:self.text];
    self.label.fontColor = self.textColor;
    self.label.fontSize = self.fontSize;
    self.label.fontName = self.font;
    //self.label.position = CGPointMake(-self.label.frame.size.width/2, -self.label.frame.size.height/2);
    
    CGFloat radius = MAX(self.label.frame.size.width, self.frame.size.height);
    radius *= M_SQRT2*self.offset;
    CGFloat x = -radius/2;
    CGFloat y = -radius/2;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(x, y, radius, radius)];
    self.path = [path CGPath];
    self.fillColor = self.backgroundColor;
    self.strokeColor = self.backgroundColor;
    
    [self addChild:self.label];
    self.label.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    self.label.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
}


@end
