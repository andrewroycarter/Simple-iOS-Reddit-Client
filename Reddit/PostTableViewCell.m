//
//  PostTableViewCell.m
//  Reddit
//
//  Created by Andrew Carter on 2/15/15.
//  Copyright (c) 2015 WillowTree Apps. All rights reserved.
//

#import "PostTableViewCell.h"

@implementation PostTableViewCell

#pragma mark - UITableViewCell Overrides

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    [self clearOutlets];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self clearOutlets];
}

#pragma mark - Instance Methods

- (void)clearOutlets
{
    [[self titleLabel] setText:nil];
    [[self captionLabel] setText:nil];
    [[self thumbnailImageView] setImage:nil];
}

@end
