//
//  Post.h
//  Reddit
//
//  Created by Andrew Carter on 2/15/15.
//  Copyright (c) 2015 WillowTree Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Post : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subreddit;
@property (nonatomic, strong) NSString *selfTextHTML;
@property (nonatomic, strong) NSNumber *score;
@property (nonatomic, strong) NSNumber *ups;
@property (nonatomic, strong) NSNumber *downs;
@property (nonatomic, assign, getter=isSelfPost) BOOL selfPost;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSURL *thumbnail;
@property (nonatomic, strong) NSDate *created;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *domain;
@property (nonatomic, readonly) NSString *captionString;

+ (instancetype)postWithDictionary:(NSDictionary *)dictionary;

@end
