//
//  FrontPageViewController.m
//  Reddit
//
//  Created by Andrew Carter on 2/15/15.
//  Copyright (c) 2015 WillowTree Apps. All rights reserved.
//

#import "FrontPageViewController.h"

#import "RedditAPI.h"
#import "Post.h"
#import "PostTableViewCell.h"
#import "UIImageView+Reddit.h"
#import "UITableViewCell+Reddit.h"
#import "WebViewController.h"

@interface FrontPageViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *posts;
@property (nonatomic, strong) NSString *after;
@property (nonatomic, strong) RedditAPI *API;
@property (nonatomic, weak) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation FrontPageViewController

#pragma mark - UIViewController Overrides

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setPosts:[NSMutableArray new]];
        [self setAPI:[RedditAPI new]];
        [self setupNavigationItem];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self getPosts];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[self tableView] flashScrollIndicators];
    [[self tableView] deselectRowAtIndexPath:[[self tableView] indexPathForSelectedRow] animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    WebViewController *webViewController = [segue destinationViewController];
    NSIndexPath *indexPath = [[self tableView] indexPathForSelectedRow];
    [webViewController setPost:[self posts][[indexPath row]]];
}

#pragma mark - Instance Methods

- (void)setupNavigationItem
{
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [activityIndicatorView setHidesWhenStopped:YES];
    [self setActivityIndicatorView:activityIndicatorView];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:activityIndicatorView];
    [[self navigationItem] setRightBarButtonItem:rightBarButtonItem];
}

- (void)getPosts
{
    [[self activityIndicatorView] startAnimating];
    __weak FrontPageViewController *weakSelf = self;
    [[self API] getPostsAfter:[self after] completion:^(NSArray *posts, NSString *after) {
        
        [[weakSelf activityIndicatorView] stopAnimating];
        [weakSelf didLoadPosts:posts after:after];
        
    }];
}

- (void)didLoadPosts:(NSArray *)posts after:(NSString *)after
{
    [self setAfter:after];
    [[self posts] addObjectsFromArray:posts];
    [[self tableView] reloadData];
}

- (void)configureCell:(PostTableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    Post *post = [self posts][[indexPath row]];
    [[cell titleLabel] setText:[post title]];
    [[cell captionLabel] setText:[post captionString]];
    [[cell thumbnailImageView] setImageWithURL:[post thumbnail]];
}

#pragma mark - UITableViewDataSource Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[PostTableViewCell reuseIdentifier] forIndexPath:indexPath];
    [self configureCell:cell forIndexPath:indexPath];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self posts] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self posts] count] ? 1 : 0;
}

#pragma mark - UITableViewDelegate Methods

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

@end
