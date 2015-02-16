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
    [self updatePreferredMaxLayoutWidthForScreen];
}

/**
 Because of a bug in setting the automatically set preferred max layout width method,
 Set preferred max layout width, based on the title label's left and right margins
 and the screen size.
 */
- (void)updatePreferredMaxLayoutWidthForScreen
{
    CGFloat leftMargin = CGRectGetMinX([[self titleLabel] frame]);
    CGFloat rightMargin = CGRectGetWidth([self bounds]) - CGRectGetMaxX([[self titleLabel] frame]);
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]) - leftMargin - rightMargin;
    
    [[self titleLabel] setPreferredMaxLayoutWidth:width];
    [[self captionLabel] setPreferredMaxLayoutWidth:width];
}

#pragma mark - Instance Methods

- (void)clearOutlets
{
    [[self titleLabel] setText:nil];
    [[self captionLabel] setText:nil];
    [[self thumbnailImageView] setImage:nil];
}

@end
