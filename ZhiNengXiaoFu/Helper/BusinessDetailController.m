//
//  BusinessDetailController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/8/1.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "BusinessDetailController.h"

@interface BusinessDetailController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIActivityIndicatorView *activityView;
@property (nonatomic, strong) UILabel                 *titleLable;
@property (nonatomic, strong) UIView                  *titleView;
@property (nonatomic, strong) UIWebView               *myWebView;

@end

@implementation BusinessDetailController

- (UILabel *)titleLable {
    if (_titleLable == nil) {
        UILabel *titleLbl = [[UILabel alloc] init];
        titleLbl.textColor = [UIColor whiteColor];
        titleLbl.font = [UIFont boldSystemFontOfSize:17];
        _titleLable = titleLbl;
    }
    return _titleLable;
}

- (UIView *)titleView {
    if (_titleView == nil) {
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        _titleView = titleView;
    }
    return _titleView;
}

- (UIActivityIndicatorView *)activityView {
    if (_activityView == nil) {
        _activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [_activityView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];//设置进度轮显示类型
        _activityView.center = CGPointMake(self.titleView.frame.size.width * 0.5, self.titleView.frame.size.height * 0.5);
        [_activityView startAnimating];
    }
    return _activityView;
}

- (UIWebView *)myWebView {
    if (_myWebView == nil) {
        _myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_NAVH - APP_BottomH)];
        _myWebView.delegate = self;
        [self.view addSubview:_myWebView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _myWebView.frame.size.width, 30)];
        label.textColor = RGB(111, 116, 117);
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        [_myWebView insertSubview:label atIndex:0];
    }
    return _myWebView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    NSURL *url = [NSURL URLWithString:self.urlStr];
    [self.myWebView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)setNav {
    self.navigationItem.titleView = self.titleView;
    [self.titleView addSubview:self.titleLable];
    [self.titleView addSubview:self.activityView];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    //[self.activityView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.activityView stopAnimating];
}

- (void)setWebTitle:(NSString *)webTitle {
    _webTitle = webTitle;
    self.titleLable.text = webTitle;
    [self.titleLable sizeToFit];
    self.titleLable.center = CGPointMake(self.titleView.frame.size.width * 0.5, self.titleView.frame.size.height * 0.5);
    self.activityView.center = CGPointMake(self.titleLable.frame.origin.x - self.activityView.frame.size.width * 0.5-5, self.titleView.frame.size.height * 0.5);
}

@end
