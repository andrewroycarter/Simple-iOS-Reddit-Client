//
//  UITableViewCell+Reddit.m
//  Reddit
//
//  Created by Andrew Carter on 2/15/15.
//  Copyright (c) 2015 WillowTree Apps. All rights reserved.
//

#import "UITableViewCell+Reddit.h"

@implementation UITableViewCell (Reddit)

+ (NSString *)reuseIdentifier
{
    return NSStringFromClass([self class]);
}

@end
