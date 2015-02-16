//
//  Post.m
//  Reddit
//
//  Created by Andrew Carter on 2/15/15.
//  Copyright (c) 2015 WillowTree Apps. All rights reserved.
//

#import "Post.h"

@implementation Post

#pragma mark - Class Methods

+ (instancetype)postWithDictionary:(NSDictionary *)dictionary
{
    Post *post = [Post new];
    NSDictionary *data = dictionary[@"data"];
    
    [post setTitle:data[@"title"]];
    [post setSubreddit:data[@"subreddit"]];
    [post setSelfTextHTML:data[@"selftext_html"]];
    [post setScore:data[@"score"]];
    [post setUps:data[@"ups"]];
    [post setDowns:data[@"downs"]];
    [post setSelfPost:[data[@"is_self"] boolValue]];
    [post setUrl:[NSURL URLWithString:data[@"url"]]];
    [post setThumbnail:[NSURL URLWithString:data[@"thumbnail"]]];
    [post setAuthor:data[@"author"]];
    [post setDomain:data[@"domain"]];
    [post setCreated:[NSDate dateWithTimeIntervalSince1970:[data[@"created_utc"] doubleValue]]];
    
    return post;
}

#pragma mark - Accessors

- (NSString *)captionString
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitHour fromDate:[self created] toDate:[NSDate date] options:0];
    NSString *captionString = [[NSString alloc] initWithFormat:@"submitted %ld hours ago by %@ to r/%@",
                               components.hour,
                               [self author],
                               [self subreddit]];
    return captionString;
}

@end
