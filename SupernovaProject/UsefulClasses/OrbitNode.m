//
//  OrbitNode.m
//  spinnigNodesWithOrbitTest
//
//  Created by Nicolas Nascimento on 26/03/15.
//  Copyright (c) 2015 NotACompany. All rights reserved.
//

#import "OrbitNode.h"

@implementation OrbitNode

-(instancetype)initWithRadius:(CGFloat)radius color:(UIColor *)color lineWidth:(CGFloat)lineWidth{
    self = [super init];
    if( self ){
        _radius = radius;
        _color = color;
        [self drawSelf];
        self.lineWidth = lineWidth;
    }
    
    return self;
}

-(void)drawSelf{
    CGFloat side = self.radius*M_SQRT2;
    CGRect squareForCircle = CGRectMake(-side/2, -side/2, side, side);
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:squareForCircle];
    self.path = [circlePath CGPath];
    self.strokeColor = self.color;
}

@end
