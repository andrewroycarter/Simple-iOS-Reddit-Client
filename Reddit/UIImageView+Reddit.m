//
//  UIImageView+Reddit.m
//  Reddit
//
//  Created by Andrew Carter on 2/15/15.
//  Copyright (c) 2015 WillowTree Apps. All rights reserved.
//

#import "UIImageView+Reddit.h"

#import <objc/runtime.h>

@interface UIImageView ()

@property (nonatomic, copy) NSString *imageTag;

@end

@implementation UIImageView (Reddit)

#pragma mark - Class Methods

+ (NSCache *)sharedImageCache
{
    __block NSCache *cache = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        cache = [NSCache new];
        
    });
    
    return cache;
}

#pragma mark - Instance Methods

- (NSString *)imageTag
{
    return objc_getAssociatedObject(self, @selector(imageTag));
}

- (void)setImageTag:(NSString *)tag
{
    objc_setAssociatedObject(self, @selector(imageTag), tag, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setImageWithURL:(NSURL *)url
{
    UIImage *image = [[[self class] sharedImageCache] objectForKey:url];
    [self setImageTag:[url absoluteString]];
    if (image)
    {
        [self setImage:image];
    }
    else if (url)
    {
        NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            if ([[self imageTag] isEqualToString:[url absoluteString]])
            {
                UIImage *image = [[UIImage alloc] initWithData:data];
                if (image)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [[[self class] sharedImageCache] setObject:image forKey:url];
                        [self setImage:image];
                        
                    });
                }
            }
        }];
        [task resume];
    }
}

@end
