//
//  Planet.m
//  spinnigNodesWithOrbitTest
//
//  Created by Nicolas Nascimento on 26/03/15.
//  Copyright (c) 2015 NotACompany. All rights reserved.
//

#import "Planet.h"

@interface Planet()

@property (nonatomic) SKNode *spinningObjectsAnchor;
@property (nonatomic) SKNode *staticObjectsAnchor;

@end

@implementation Planet

-(void)unhighlight{
    if( self.spinningObjectsAnchor.children.count > 0 ){
        OrbitNode *orbit = self.spinningObjectsAnchor.children[0];
        OrbitNode *safeSpot = self.staticObjectsAnchor.children[0];
        orbit.glowWidth = 0;
        safeSpot.glowWidth = 0;
    }
}

-(void)highlightOrbitWithGlowWidth:(CGFloat)glowWidth{
    if( self.spinningObjectsAnchor.children.count > 0 ){
        OrbitNode *orbit = self.spinningObjectsAnchor.children[0];
        OrbitNode *safeSpot = self.staticObjectsAnchor.children[0];
        orbit.glowWidth = glowWidth;
        safeSpot.glowWidth = glowWidth;
    }
}

-(instancetype)initWithPlanet:(SpinnigNode *)planet Orbit:(OrbitNode *)orbit SafeSpot:(OrbitNode *)safeSpot ShouldSpin:(BOOL)shouldSpin SpinnigDuration:(CGFloat)duration clockWiseSpin:(BOOL)clockWiseSpin safeSpotShouldSpin:(BOOL)safeSpotShouldSpin safeSpotClockWiseSpin:(BOOL)safeSpotClockWiseSpin safeSpotSpinningDuration:(CGFloat)safeSpotSpinningDuration{
    self = [super init];
    
    if( self ){
        _planet = planet;
        _orbit = orbit;
        _shouldSpin = shouldSpin;
        _spinning = _shouldSpin ? YES : NO;
        _safeSpot = safeSpot;
        _spinningDuration = duration;
        _clockWiseSpin = clockWiseSpin;
        _safeSpotShouldSpin = safeSpotShouldSpin;
        _safeSpotClockWiseSpin = safeSpotClockWiseSpin;
        _safeSpotSpinningDuration = safeSpotSpinningDuration;
        [self drawSelf];
        [self generateRotation];
    }
    return self;
}

-(void)drawSelf{
    self.spinningObjectsAnchor = [[SKNode alloc] init];
    self.staticObjectsAnchor = [[SKNode alloc] init];
    [self addChild:self.spinningObjectsAnchor];
    [self addChild:self.staticObjectsAnchor];
    
    self.planet.position = CGPointMake(self.planet.position.x + self.orbit.radius/2, self.planet.position.y + self.orbit.radius/2);
    self.safeSpot.position = CGPointMake(self.safeSpot.position.x + self.orbit.radius/2, self.safeSpot.position.y + self.orbit.radius/2);
    
    [self.spinningObjectsAnchor addChild:self.orbit];
    [self.spinningObjectsAnchor addChild:self.planet];
    
    [self.staticObjectsAnchor addChild:self.safeSpot];
    CGFloat angle = (arc4random() % 360)*2*M_PI/360.0;
    SKAction *rotate = [SKAction rotateByAngle:angle duration:0];
    [self runAction:rotate];
    
}

-(void)generateRotation{
    if( self.shouldSpin ){
        
        CGFloat angle = M_PI;
        angle = self.clockWiseSpin ? -angle : +angle;
        
        SKAction *rotate = [SKAction rotateByAngle:angle duration:self.spinningDuration];
        [self.spinningObjectsAnchor runAction:[SKAction repeatActionForever:rotate]];
    }
    if( self.safeSpotShouldSpin ){
        CGFloat angle = M_PI;
        angle = self.safeSpotClockWiseSpin ? -angle : angle;
        
        SKAction *rotate = [SKAction rotateByAngle:angle duration:self.safeSpotSpinningDuration];
        [self.staticObjectsAnchor runAction:[SKAction repeatActionForever:rotate]];
    }
}

-(BOOL)planetIsInsideSafeSpot{
    CGPoint planetPositionInSceneWithParentCoordinateSystem = [self.planet.scene convertPoint:self.planet.position fromNode:self.planet.parent];
    CGPoint safeSpotPositionInSceneWithParentCoordinateSystem = [self.safeSpot.scene convertPoint:self.safeSpot.position fromNode:self.safeSpot.parent];
    
    CGFloat centerDistanceInXAxis = planetPositionInSceneWithParentCoordinateSystem.x - safeSpotPositionInSceneWithParentCoordinateSystem.x;
    CGFloat centerDistanceInYAxis = planetPositionInSceneWithParentCoordinateSystem.y - safeSpotPositionInSceneWithParentCoordinateSystem.y;
    CGFloat planetRadius = self.planet.radius/M_SQRT2;
    CGFloat safeSpotRadius = self.safeSpot.radius/M_SQRT2;
    
    CGFloat minimumDistance = planetRadius + safeSpotRadius;
    CGFloat actualDistance = sqrt(centerDistanceInXAxis*centerDistanceInXAxis + centerDistanceInYAxis*centerDistanceInYAxis);
    
    if( actualDistance < minimumDistance )
        return YES;
    else
        return NO;
}

-(void)stopPlanetSpinning{
    [self.spinningObjectsAnchor removeAllActions];
    [self.staticObjectsAnchor removeAllActions];
    self.spinning = NO;
}

@end
