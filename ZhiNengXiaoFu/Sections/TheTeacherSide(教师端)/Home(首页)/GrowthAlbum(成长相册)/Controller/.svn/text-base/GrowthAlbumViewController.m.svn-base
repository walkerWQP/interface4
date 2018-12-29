//
//  GrowthAlbumViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/26.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "GrowthAlbumViewController.h"
#import "WebViewJavascriptBridge.h"
#import "PublishJobModel.h"
#import "ReleasedAlbumsViewController.h"


@interface GrowthAlbumViewController ()<UIWebViewDelegate,WPopupMenuDelegate>

@property (nonatomic, strong) WebViewJavascriptBridge *bridge;
@property (nonatomic, strong) UIWebView               *webView;
@property (nonatomic, strong) NSMutableArray          *publishJobArr;
@property (nonatomic, strong) UIView                  *bgView;
@property (nonatomic, strong) UIButton                *rightBtn;

@end

@implementation GrowthAlbumViewController

- (NSMutableArray *)publishJobArr {
    if (!_publishJobArr) {
        _publishJobArr = [NSMutableArray array];
    }
    return _publishJobArr;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.webView.backgroundColor = backColor;
    self.view.backgroundColor = backColor;
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, -APP_NAVH, APP_WIDTH, APP_HEIGHT - APP_NAVH)];
    self.bgView.backgroundColor = backColor;
    [self.view addSubview:self.bgView];
    [self prepareViews];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.webTitle;
    if ([self.typeID isEqualToString:@"1"]) {
        
    } else {
        self.rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 90, 30)];
        [self.rightBtn setTitle:@"切换班级" forState:UIControlStateNormal];
        self.rightBtn.titleLabel.font = titFont;
        [self.rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
        self.view.backgroundColor = [UIColor greenColor];
    }
}

- (void)rightBtn:(UIButton *)sender {
    NSLog(@"点击发布");
    [self getClassURLData];
}

- (void)getClassURLData {
    
    NSDictionary *dic = @{@"key":[UserManager key]};
    [[HttpRequestManager sharedSingleton] POST:getClassURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            
            self.publishJobArr = [PublishJobModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            NSMutableArray * ary = [@[]mutableCopy];
            for (PublishJobModel * model in self.publishJobArr) {
                [ary addObject:[NSString stringWithFormat:@"%@", model.name]];
            }
            
            if (ary.count == 0) {
                [WProgressHUD showErrorAnimatedText:@"数据不正确,请重试"];
            } else {
                [WPopupMenu showRelyOnView:self.rightBtn titles:ary icons:nil menuWidth:140 delegate:self];
            }
            
            if (self.publishJobArr.count == 0) {
                [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
            } else {
                
            }
    
        } else {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
            } else {
                
            }
            [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}


#pragma mark - YBPopupMenuDelegate
- (void)WPopupMenuDidSelectedAtIndex:(NSInteger)index WPopupMenu:(WPopupMenu *)WPopupMenu {
    if (self.publishJobArr.count != 0) {
        PublishJobModel *model = [self.publishJobArr objectAtIndex:index];
        NSLog(@"%@",model.ID);
        if (model.ID == nil) {
            [WProgressHUD showSuccessfulAnimatedText:@"数据不正确,请重试"];
        } else {
            [self postDataForGetURL:model.ID];
        }
    }
}


- (void)postDataForGetURL:(NSString *)classID {
    NSDictionary *dic = @{@"key":[UserManager key],@"class_id":classID};
    [[HttpRequestManager sharedSingleton] POST:getURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            self.bgView.hidden = YES;
            self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, - APP_NAVH, APP_WIDTH, APP_HEIGHT + APP_NAVH)];
            self.bgView.backgroundColor = backColor;
            [self.view addSubview:self.bgView];
            [self cleanCacheAndCookie];
            NSString *url = [[responseObject objectForKey:@"data"] objectForKey:@"url"];
            if (url == nil) {
                [WProgressHUD showSuccessfulAnimatedText:@"数据不正确,请重试"];
            } else {
                self.urlStr = url;
                [self prepareViews];
            }
            
        } else {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
            } else {
                
            }
            [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

-(void)cleanCacheAndCookie{
    
    //清除cookies
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]){
        [storage deleteCookie:cookie];
    }
    
    //清除UIWebView的缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
    
}


- (void)prepareViews {
    self.webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    self.webView.delegate = self;
    [self.bgView addSubview:self.webView];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@", self.urlStr];
    NSURL *url = [NSURL URLWithString:urlStr];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    // 3.开启日志
    [WebViewJavascriptBridge enableLogging];
    
    // 4.给webView建立JS和OC的沟通桥梁
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    [self.bridge setWebViewDelegate:self];
    
    [self.bridge registerHandler:@"uploadphoto" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"点击上传");
        ReleasedAlbumsViewController *releasedAlbumsVC = [[ReleasedAlbumsViewController alloc] init];
        [self.navigationController pushViewController:releasedAlbumsVC animated:YES];
    }];
}


-(void)webViewDidStartLoad:(UIWebView *)webView {
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //    [SVProgressHUD dismiss];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    //    [SVProgressHUD dismiss];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@""]]];
    [self.webView removeFromSuperview];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    self.hidesBottomBarWhenPushed = YES;
    NSString *urlString = request.URL.absoluteString;
    if ([urlString containsString:@"weixin://"]) {
        [[UIApplication sharedApplication]openURL:request.URL options:@{} completionHandler:^(BOOL success) {
            
        }];
    }
    return YES;
}

@end
