//
//  LevelInfo.m
//  spinnigNodesWithOrbitTest
//
//  Created by Nicolas Nascimento on 27/03/15.
//  Copyright (c) 2015 NotACompany. All rights reserved.
//

#import "LevelInfo.h"

@implementation LevelInfo

-(void)setCurrentLevel:(NSInteger)currentLevel{
    NSLog(@"setting Current Level");
    _currentLevel = currentLevel;
}

+(LevelInfo *)defaultLevelInfo{
    return [LevelInfo defaultLevelInfoWithLevel:1 score:0 spinningPeriod:2.5];
}

+(LevelInfo *)defaultLevelInfoWithLevel:(NSInteger)level
                                  score:(NSInteger)score
                         spinningPeriod:(CGFloat)spinnigPeriod{
    return [[LevelInfo alloc] initWithCenterNodeRadius:30 centerNodeGlowWidth:3.0 spinningNodesRadius:10 spinningNodesGlowWidth:3.0 spinningNodesInitialAmount:5 spinningNodesInitialOffset:4 currentOrbit:0 currentLevel:level currentScore:score spinningPeriod:spinnigPeriod];
}

-(instancetype)initWithCenterNodeRadius:(CGFloat)centerNodeRadius
                    centerNodeGlowWidth:(CGFloat)centerNodeGlowWidth
                    spinningNodesRadius:(CGFloat)spinningNodesRadius
                 spinningNodesGlowWidth:(CGFloat)spinningNodesGlowWidth
             spinningNodesInitialAmount:(CGFloat)spinningNodesInitialAmount
             spinningNodesInitialOffset:(CGFloat)spinningNodesInitialOffset
                           currentOrbit:(NSInteger)currentOrbit
                           currentLevel:(NSInteger)currentLevel
                           currentScore:(NSInteger)currentScore
                         spinningPeriod:(CGFloat)spinningPeriod{
    self = [super init];
    if( self ){
        
        _centerNodeRadius = centerNodeRadius;
        _centerNodeGlowWidth = centerNodeGlowWidth;
        _spinningNodesRadius = spinningNodesRadius;
        _spinningNodesGlowWidth = spinningNodesGlowWidth;
        _spinningNodesInitialAmount = spinningNodesInitialAmount;
        _spinningNodesInitialOffset = spinningNodesInitialOffset;
        _currentOrbit = currentOrbit;
        _currentLevel = currentLevel;
        _currentScore = currentScore;
        _spinningPeriod = spinningPeriod;
    }
    
    return self;
}

@end
