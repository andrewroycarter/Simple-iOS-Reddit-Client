//
//  RedditAPI.m
//  Reddit
//
//  Created by Andrew Carter on 2/15/15.
//  Copyright (c) 2015 WillowTree Apps. All rights reserved.
//

#import "RedditAPI.h"

#import "NSArray+Reddit.h"
#import "Post.h"

@interface RedditAPI ()

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation RedditAPI

#pragma mark - NSObject Overrides

- (id)init
{
    self = [super init];
    if (self)
    {
        [self setSession:[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]]];
    }
    return self;
}

#pragma mark - Class Methods

- (NSURLComponents *)baseURLComponents
{
    NSURLComponents *components = [NSURLComponents new];
    [components setScheme:@"http"];
    [components setHost:@"www.reddit.com"];
    return components;
}

#pragma mark - Instance Methods

- (void)getPostsAfter:(NSString *)after completion:(void (^)(NSArray *posts, NSString *after))completion
{
    NSParameterAssert(completion);
    
    NSURLComponents *components = [self baseURLComponents];
    [components setPath:@"/.json"];
    NSURLQueryItem *item = [NSURLQueryItem queryItemWithName:@"after" value:after];
    [components setQueryItems:@[item]];
    
    NSURLSessionDataTask *task = [[self session] dataTaskWithURL:[components URL] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
       
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSDictionary *postData = json[@"data"];
        NSArray *posts = [postData[@"children"] map:^Post * (NSDictionary *obj) {
           
            return [Post postWithDictionary:obj];
            
        }];
        NSString *after = postData[@"after"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            completion(posts, after);
            
        });
        
    }];
    [task resume];
}

@end
