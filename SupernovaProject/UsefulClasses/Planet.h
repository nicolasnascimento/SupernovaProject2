//
//  Planet.h
//  spinnigNodesWithOrbitTest
//
//  Created by Nicolas Nascimento on 26/03/15.
//  Copyright (c) 2015 NotACompany. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SpinnigNode.h"
#import "OrbitNode.h"

@interface Planet : SKNode <SelfDrawableSKNode>

@property (nonatomic) SpinnigNode *planet;
@property (nonatomic) OrbitNode *orbit;
@property (nonatomic) OrbitNode *safeSpot;
@property (nonatomic) CGFloat spinningDuration;
@property BOOL clockWiseSpin;
@property BOOL shouldSpin;
@property (getter=isSpinning) BOOL spinning;
@property BOOL safeSpotShouldSpin;
@property BOOL safeSpotClockWiseSpin;
@property (nonatomic) CGFloat safeSpotSpinningDuration;


-(instancetype)initWithPlanet:(SpinnigNode *)planet Orbit:(OrbitNode *)orbit SafeSpot:(OrbitNode *)safeSpot ShouldSpin:(BOOL)shouldSpin SpinnigDuration:(CGFloat)duration clockWiseSpin:(BOOL)clockWiseSpin safeSpotShouldSpin:(BOOL)safeSpotShouldSpin safeSpotClockWiseSpin:(BOOL)safeSpotClockWiseSpin safeSpotSpinningDuration:(CGFloat)safeSpotSpinningDuration;
-(BOOL)planetIsInsideSafeSpot;
-(void)stopPlanetSpinning;
-(void)highlightOrbitWithGlowWidth:(CGFloat)glowWidth;
-(void)unhighlight;

@end
