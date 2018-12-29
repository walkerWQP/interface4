//
//  TGWebViewController.m
//  TGWebViewController
//
//  Created by 赵群涛 on 2017/9/15.
//  Copyright © 2017年 QR. All rights reserved.
//

#import "TGWebViewController.h"
#import "TGWebProgressLayer.h"
#import <WebKit/WebKit.h>
@interface TGWebViewController ()<WKNavigationDelegate>

@property (nonatomic, strong)WKWebView *tgWebView;

@property (nonatomic, strong)TGWebProgressLayer *webProgressLayer;


@end

@implementation TGWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = self.webTitle;
    [self setUpUI];
}

- (void)setUpUI {
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];

    backBtn.frame = CGRectMake(0, 0, 28, 28);
    [backBtn setImage:[UIImage imageNamed:@"返回拷贝"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
   
    self.tgWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_NAVH)];
    self.tgWebView.navigationDelegate =self;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [self.tgWebView loadRequest:request];
    [self.view addSubview:self.tgWebView];
    
    
    self.webProgressLayer = [[TGWebProgressLayer alloc] init];
    self.webProgressLayer.frame = CGRectMake(0, APP_NAVH, APP_WIDTH, 2);
    self.webProgressLayer.strokeColor = self.progressColor.CGColor;
    [self.navigationController.navigationBar.layer addSublayer:self.webProgressLayer];
    
    
}

- (void)backButton:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
    [self.webProgressLayer removeFromSuperlayer];
}

#pragma mark - UIWebViewDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [self.webProgressLayer tg_startLoad];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self.webProgressLayer tg_finishedLoadWithError:nil];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [self.webProgressLayer tg_finishedLoadWithError:error];
    
}

- (void)dealloc {
    [self.webProgressLayer tg_closeTimer];
    [_webProgressLayer removeFromSuperlayer];
    _webProgressLayer = nil;
}




@end
