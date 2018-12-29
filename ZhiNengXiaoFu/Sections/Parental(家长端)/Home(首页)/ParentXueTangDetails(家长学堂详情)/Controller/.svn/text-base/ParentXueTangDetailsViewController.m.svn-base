//
//  ParentXueTangDetailsViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/8/10.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "ParentXueTangDetailsViewController.h"
#import "ParentXueTangDetailsModel.h"
@interface ParentXueTangDetailsViewController ()<UIWebViewDelegate>

@property (nonatomic,weak) CLPlayerView                 *playerView;
@property (nonatomic, strong) ParentXueTangDetailsModel *parentXueTangDetailsModel;
@property (strong, nonatomic) UIWebView                 *webView;

@end

@implementation ParentXueTangDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNetWork];
}

//网络请求 家长获取视频详情
- (void)setNetWork {
    NSDictionary *dic = @{@"key":[UserManager key], @"id":self.ParentXueTangDetailsId};
    [[HttpRequestManager sharedSingleton] POST:pschoolGetDetail parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200 || [[responseObject objectForKey:@"status"] integerValue] == 405) {
            
            self.parentXueTangDetailsModel = [ParentXueTangDetailsModel mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
            [self LoadWebView];

            self.title = self.parentXueTangDetailsModel.title;
            if ([self.parentXueTangDetailsModel.url isEqualToString:@""]) {
                UIImageView *back = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 200)];
                [back sd_setImageWithURL:[NSURL URLWithString:self.parentXueTangDetailsModel.img] placeholderImage:nil];
                [self.view addSubview:back];
            } else {
                [self setBoFang];
            }
            
        } else {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
            } else {
                
            }
            [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)LoadWebView {
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 200, APP_WIDTH, APP_HEIGHT - 64-20 - 200)];
    self.webView.backgroundColor = [UIColor whiteColor];
    [self.webView setOpaque:NO];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    [self.webView loadHTMLString:self.parentXueTangDetailsModel.content baseURL:nil];
}

- (void)webViewDidFinishLoad:(UIWebView*)webView {
    //重写contentSize,防止左右滑动
    CGSize size = webView.scrollView.contentSize;
    size.width= webView.scrollView.frame.size.width;
    webView.scrollView.contentSize= size;
}



- (void)setBoFang {
    CLPlayerView *playerView = [[CLPlayerView alloc] initWithFrame:CGRectMake(0, 0, self.view.CLwidth, 200)];
    _playerView = playerView;
    [self.view addSubview:_playerView];
    //    //重复播放，默认不播放
    _playerView.repeatPlay = YES;
    //    //当前控制器是否支持旋转，当前页面支持旋转的时候需要设置，告知播放器
    _playerView.isLandscape = YES;
    //视频地址
    _playerView.url = [NSURL URLWithString:self.parentXueTangDetailsModel.url];
    //播放
    [_playerView playVideo];
    //返回按钮点击事件回调
    [_playerView backButton:^(UIButton *button) {
        NSLog(@"返回按钮被点击");
        //查询是否是全屏状态
        NSLog(@"%d",_playerView.isFullScreen);
    }];
    //播放完成回调
    [_playerView endPlay:^{
        //销毁播放器
        //        [_playerView destroyPlayer];
        //        _playerView = nil;
        NSLog(@"播放完成");
    }];
}

-(void)viewDidDisappear:(BOOL)animated{
    [_playerView destroyPlayer];
    _playerView = nil;
}

#pragma mark -- 需要设置全局支持旋转方向，然后重写下面三个方法可以让当前页面支持多个方向
// 是否支持自动转屏
- (BOOL)shouldAutorotate {
    return YES;
}

// 支持哪些屏幕方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

// 默认的屏幕方向（当前ViewController必须是通过模态出来的UIViewController（模态带导航的无效）方式展现出来的，才会调用这个方法）
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
