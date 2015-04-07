//
//  IndexShapeNode.m
//  SupernovaProject
//
//  Created by Paulo Ricardo Ramos da Rosa on 3/26/15.
//  Copyright (c) 2015 NotACompany. All rights reserved.
//

#import "IndexShapeNode.h"

@implementation IndexShapeNode

-(instancetype)initWithIndex:(NSInteger)index
{
    self = [super init];
    
    if( self ){
        _index = index;
    }
    return self;
}

@end
