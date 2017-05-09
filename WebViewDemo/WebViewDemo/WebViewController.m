//
//  WebViewController.m
//  WebViewDemo
//
//  Created by vance on 2017/3/6.
//  Copyright © 2017年 InfoMacro. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation WebViewController

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height)];
        _webView.scrollView.bounces = NO;
        _webView.delegate = self;
        [self.view addSubview:_webView];
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.url;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.frame = [UIScreen mainScreen].bounds;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"start:%@",webView.request.URL);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if (!webView.isLoading)  {
         NSLog(@"finish:%@",webView.request.URL);
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [[[UIAlertView alloc] initWithTitle:@"" message:@"FailLoad" delegate:nil cancelButtonTitle:@"YES" otherButtonTitles:nil] show];
    NSLog(@"failure:%@",error.userInfo);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
