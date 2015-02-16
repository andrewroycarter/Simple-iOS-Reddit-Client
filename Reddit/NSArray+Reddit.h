//
//  NSArray+Reddit.h
//  Reddit
//
//  Created by Andrew Carter on 2/15/15.
//  Copyright (c) 2015 WillowTree Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Reddit)

- (NSArray *)map:(id (^)(id obj))block;

@end
