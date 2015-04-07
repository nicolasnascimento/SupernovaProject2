//
//  SpinnigNode.h
//  spinnigNodesWithOrbitTest
//
//  Created by Nicolas Nascimento on 26/03/15.
//  Copyright (c) 2015 NotACompany. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@protocol SelfDrawableSKNode <NSObject>

-(void)drawSelf;

@end

@interface SpinnigNode : SKShapeNode <SelfDrawableSKNode>

@property (nonatomic) CGFloat radius;
@property (nonatomic) SKColor *color;

-(instancetype)initWithRadius:(CGFloat)radius color:(SKColor *)color;

@end
