//
//  SpinnigNode.m
//  spinnigNodesWithOrbitTest
//
//  Created by Nicolas Nascimento on 26/03/15.
//  Copyright (c) 2015 NotACompany. All rights reserved.
//

#import "SpinnigNode.h"

@implementation SpinnigNode

-(instancetype)initWithRadius:(CGFloat)radius color:(UIColor *)color{
    self = [super init];
    
    if( self ){
        _radius = radius;
        _color = color;
        [self drawSelf];
    }
    return self;
}

-(void)drawSelf{
    // get this from pythagorean theorem
    CGFloat side = self.radius*M_SQRT2;
    CGRect squareForCircle = CGRectMake(-side/2, -side/2, side, side);
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:squareForCircle];
    self.path = [circlePath CGPath];
    self.fillColor = self.color;
    self.strokeColor = self.color;
}

@end
