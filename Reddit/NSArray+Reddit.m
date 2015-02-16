//
//  NSArray+Reddit.m
//  Reddit
//
//  Created by Andrew Carter on 2/15/15.
//  Copyright (c) 2015 WillowTree Apps. All rights reserved.
//

#import "NSArray+Reddit.h"

@implementation NSArray (Reddit)

- (NSArray *)map:(id (^)(id))block
{
    NSParameterAssert(block);
    
    NSMutableArray *result = [NSMutableArray new];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
       
        id transformedObj = block(obj);
        NSAssert(transformedObj != nil, @"Map block must return an object");
        [result addObject:transformedObj];
        
    }];
    return [NSArray arrayWithArray:result];
}

@end
