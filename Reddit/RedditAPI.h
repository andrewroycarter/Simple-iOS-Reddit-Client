//
//  RedditAPI.h
//  Reddit
//
//  Created by Andrew Carter on 2/15/15.
//  Copyright (c) 2015 WillowTree Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RedditAPI : NSObject

- (void)getPostsAfter:(NSString *)after completion:(void (^)(NSArray *posts, NSString *after))completion;

@end
