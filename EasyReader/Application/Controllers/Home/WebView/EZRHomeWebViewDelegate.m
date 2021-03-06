//
//  EZRHomeWebViewDelegate.m
//  EasyReader
//
//  Created by Joseph Lorich on 4/7/14.
//  Copyright (c) 2014 Cloudspace. All rights reserved.
//

#import "EZRHomeWebViewDelegate.h"
#import "EZRHomeViewController.h"

@interface EZRHomeWebViewDelegate ()

/// The home view controller
@property (nonatomic, weak) IBOutlet EZRHomeViewController *controller;

/// The home view controller
@property (nonatomic, weak) IBOutlet EZRNestableWebView *webView_feedItem;


@end

@implementation EZRHomeWebViewDelegate
{
    /// The bar progress view
    NJKWebViewProgressView *progressView;
    
    /// Is the page currently being dragged
    BOOL dragging;
    
    /// The staring point of the current drag
    CGPoint dragStart;
}

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.progressDelegate = self;
    }
    
    return self;
}


#pragma mark - NJKWebViewProgressDelegate methods

/**
 * Adds the progress view object if it doesn't exist, update the progress
 */
- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    if (!progressView) {
        progressView = [[NJKWebViewProgressView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.webView_feedItem.frame), 5)];
        [self.webView_feedItem addSubview:progressView];
    }
    
    [progressView setProgress:progress animated:NO];
}


#pragma mark - UIScrollViewDelegate methods

/**
 * Only allows the scroll-up indicator to be visible on the top 5% of the page or when the user is scrolling up
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y > dragStart.y && scrollView.contentOffset.y > scrollView.contentSize.height*.05) {
        [self.controller hideUpInidicator];
    } else {
        [self.controller showUpInidicator];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    dragging = YES;
    dragStart = scrollView.contentOffset;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    dragging = NO;
}

@end
