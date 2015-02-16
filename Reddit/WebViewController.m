//
//  WebViewController.m
//  Reddit
//
//  Created by Andrew Carter on 2/15/15.
//  Copyright (c) 2015 WillowTree Apps. All rights reserved.
//

#import "WebViewController.h"

#import "Post.h"

@interface WebViewController () <UIWebViewDelegate>

@property (nonatomic, weak) IBOutlet UIWebView *webView;

@end

@implementation WebViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[self webView] loadRequest:[NSURLRequest requestWithURL:[[self post] url]]];
}

@end
