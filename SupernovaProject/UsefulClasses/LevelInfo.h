//
//  LevelInfo.h
//  spinnigNodesWithOrbitTest
//
//  Created by Nicolas Nascimento on 27/03/15.
//  Copyright (c) 2015 NotACompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface LevelInfo : NSObject

@property (nonatomic) CGFloat centerNodeRadius;
@property (nonatomic) CGFloat centerNodeGlowWidth;
@property (nonatomic) CGFloat spinningNodesRadius;
@property (nonatomic) CGFloat spinningNodesGlowWidth;
@property (nonatomic) CGFloat spinningNodesInitialAmount;
@property (nonatomic) CGFloat spinningNodesInitialOffset;
@property (nonatomic) NSInteger currentOrbit;
@property (nonatomic) NSInteger currentLevel;
@property (nonatomic) NSInteger currentScore;
@property (nonatomic) CGFloat spinningPeriod;

+(LevelInfo *)defaultLevelInfo;
+(LevelInfo *)defaultLevelInfoWithLevel:(NSInteger)level
                                  score:(NSInteger)score
                         spinningPeriod:(CGFloat)spinnigPeriod;

-(instancetype)initWithCenterNodeRadius:(CGFloat)centerNodeRadius
                    centerNodeGlowWidth:(CGFloat)centerNodeGlowWidth
                    spinningNodesRadius:(CGFloat)spinningNodesRadius
                 spinningNodesGlowWidth:(CGFloat)spinningNodesGlowWidth
             spinningNodesInitialAmount:(CGFloat)spinningNodesInitialAmount
             spinningNodesInitialOffset:(CGFloat)spinningNodesInitialOffset
                           currentOrbit:(NSInteger)currentOrbit
                           currentLevel:(NSInteger)currentLevel
                           currentScore:(NSInteger)currentScore
                         spinningPeriod:(CGFloat)spinningPeriod;

@end
