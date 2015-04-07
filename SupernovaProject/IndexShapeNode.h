//
//  IndexShapeNode.h
//  SupernovaProject
//
//  Created by Paulo Ricardo Ramos da Rosa on 3/26/15.
//  Copyright (c) 2015 NotACompany. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface IndexShapeNode : SKShapeNode

@property (nonatomic) NSInteger index;

-(instancetype)initWithIndex:(NSInteger)index;

@end
