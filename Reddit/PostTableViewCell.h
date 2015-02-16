//
//  PostTableViewCell.h
//  Reddit
//
//  Created by Andrew Carter on 2/15/15.
//  Copyright (c) 2015 WillowTree Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *captionLabel;

@end
