//
//  JingJiActivityDetailsViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/28.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "JingJiActivityDetailsViewController.h"
#import "TongZhiDetailsCell.h"
#import "JingJiHuoDongListModel.h"
#import "ChangeActivitiesViewController.h"
#import <WebKit/WebKit.h>
#import "UIView+XXYViewFrame.h"

@interface JingJiActivityDetailsViewController ()<UITableViewDelegate, UITableViewDataSource,WKUIDelegate,WKNavigationDelegate>

@property (nonatomic, strong) UITableView            *JingJiActivityDetailsTableView;
@property (nonatomic, strong) JingJiHuoDongListModel *jingJiHuoDongListModol;
@property (nonatomic, strong) TongZhiDetailsCell     *tongZhiDetailsCell;
@property (nonatomic, assign) CGFloat                Hnew;

@end

@implementation JingJiActivityDetailsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNetWork];
    [self.view addSubview:self.JingJiActivityDetailsTableView];
    [self.JingJiActivityDetailsTableView registerNib:[UINib nibWithNibName:@"TongZhiDetailsCell" bundle:nil] forCellReuseIdentifier:@"TongZhiDetailsCellId"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"竞技活动详情";
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self.typeStr isEqualToString:@"1"] || [self.typeStr isEqualToString:@"3"]) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [button setTitle:@"修改" forState:UIControlStateNormal];
        button.titleLabel.font = titFont;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]  initWithCustomView:button];
        
    } else {
        
    }

}


- (void)rightBtn:(UIButton *)sender {
    NSLog(@"点击修改");
    
    ChangeActivitiesViewController *ChangeActivitiesVC = [ChangeActivitiesViewController new];
    ChangeActivitiesVC.ID = self.jingJiHuoDongListModol.ID;
    ChangeActivitiesVC.titleStr = self.jingJiHuoDongListModol.title;
    ChangeActivitiesVC.introduction = self.jingJiHuoDongListModol.introduction;
    ChangeActivitiesVC.start = self.jingJiHuoDongListModol.start;
    ChangeActivitiesVC.end = self.jingJiHuoDongListModol.end;
    [self.navigationController pushViewController:ChangeActivitiesVC animated:YES];
    
}

- (UITableView *)JingJiActivityDetailsTableView {
    if (!_JingJiActivityDetailsTableView) {
        self.JingJiActivityDetailsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT) style:UITableViewStyleGrouped];
        self.JingJiActivityDetailsTableView.backgroundColor = [UIColor whiteColor];
        self.JingJiActivityDetailsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.JingJiActivityDetailsTableView.delegate = self;
        self.JingJiActivityDetailsTableView.dataSource = self;
    }
    return _JingJiActivityDetailsTableView;
}

- (void)setNetWork {
    
    NSDictionary * dic = @{@"key":[UserManager key], @"id":self.JingJiActivityDetailsId};
    [[HttpRequestManager sharedSingleton] POST:activityDetail parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
             self.Hnew = 0;
            self.tongZhiDetailsCell.CommunityDetailsImageViewHegit.constant = 0;
             [self.tongZhiDetailsCell.PicView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            self.jingJiHuoDongListModol = [JingJiHuoDongListModel mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
            if (self.jingJiHuoDongListModol.is_school == 1) {
                
            } else {
                [self configureImage];

            }
            
            [self.JingJiActivityDetailsTableView reloadData];
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

- (void)configureImage {
    
        UIImageView * imageViewNew = [[UIImageView alloc] initWithFrame:CGRectMake(0, 210, self.tongZhiDetailsCell.PicView.bounds.size.width ,0)];
        
        [imageViewNew sd_setImageWithURL:[NSURL URLWithString:self.jingJiHuoDongListModol.img] placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            CGSize size = image.size;
            CGFloat w = size.width;
            CGFloat H = size.height;
            if (w != 0) {
                CGFloat newH = H * self.tongZhiDetailsCell.PicView.bounds.size.width / w;
                self.tongZhiDetailsCell.CommunityDetailsImageViewHegit.constant += (newH + 10);
                imageViewNew.frame =CGRectMake(0, self.tongZhiDetailsCell.CommunityDetailsImageViewHegit.constant - newH,self.tongZhiDetailsCell.PicView.bounds.size.width, H * self.tongZhiDetailsCell.PicView.bounds.size.width / w);
            }
            [self.JingJiActivityDetailsTableView reloadData];
        }];
        [self.tongZhiDetailsCell.PicView addSubview:imageViewNew];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

//有时候tableview的底部视图也会出现此现象对应的修改就好了
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.tongZhiDetailsCell  = [tableView dequeueReusableCellWithIdentifier:@"TongZhiDetailsCellId" forIndexPath:indexPath];
    self.tongZhiDetailsCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.tongZhiDetailsCell.TongZhiDetailsTitleLabel.text = self.jingJiHuoDongListModol.title;
    self.tongZhiDetailsCell.TongZhiDetailsConnectLabel.text = self.jingJiHuoDongListModol.introduction;
    self.tongZhiDetailsCell.TongZhiDetailsTimeLabel.text = [NSString stringWithFormat:@"活动时间:%@-%@", self.jingJiHuoDongListModol.start, self.jingJiHuoDongListModol.end];
    if (self.jingJiHuoDongListModol.is_school == 1) {
        self.tongZhiDetailsCell.TongZhiDetailsConnectLabel.alpha = 0;
    } else {
        self.tongZhiDetailsCell.TongZhiDetailsConnectLabel.alpha = 1;
    }
    
    if (self.Hnew ==0) {
        self.tongZhiDetailsCell.webView.hidden = NO;
        self.tongZhiDetailsCell.webView.userInteractionEnabled = YES;
        self.tongZhiDetailsCell.webView.UIDelegate = self;
        self.tongZhiDetailsCell.webView.navigationDelegate = self;
        self.tongZhiDetailsCell.TongZhiDetailsConnectLabel.alpha = 0;
        if (self.jingJiHuoDongListModol.introduction.length>0) {
            [self.tongZhiDetailsCell.webView loadHTMLString:[NSString stringWithFormat:@"<meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'><meta name='apple-mobile-web-app-capable' content='yes'><meta name='apple-mobile-web-app-status-bar-style' content='black'><meta name='format-detection' content='telephone=no'><style type='text/css'>img{width:%fpx}</style>%@", APP_WIDTH -20 , self.jingJiHuoDongListModol.introduction] baseURL:nil];
        }
    }
    return self.tongZhiDetailsCell;
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    NSString *heightString4 = @"document.body.scrollHeight";
    [webView evaluateJavaScript:heightString4 completionHandler:^(id _Nullable item, NSError * _Nullable error) {
        CGFloat currentHeight = [item doubleValue];
        NSInteger width = APP_WIDTH - 30;
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:30]};
        CGSize size = [self.jingJiHuoDongListModol.title boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        self.tongZhiDetailsCell.webView.frame = CGRectMake(10, 30 + size.height , APP_WIDTH - 20, currentHeight);
        self.Hnew = currentHeight;
        NSLog(@"html 高度2：%f", currentHeight);
        self.tongZhiDetailsCell.webView.hidden =NO;
        self.tongZhiDetailsCell.TongZhiDetailsTWebopCon.constant = self.Hnew + 26;
        self.tongZhiDetailsCell.webView.height = currentHeight;
        [self.JingJiActivityDetailsTableView reloadData];
        
    }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger width = APP_WIDTH - 30;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:30]};
    CGSize size = [self.jingJiHuoDongListModol.title boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    if (self.Hnew == 0) {
        if ([self.jingJiHuoDongListModol.img isEqualToString:@""]) {
            self.tongZhiDetailsCell.CommunityDetailsImageViewHegit.constant = 0;
            return 200 + size.height;
        } else {
            return  self.tongZhiDetailsCell.CommunityDetailsImageViewHegit.constant + 200 + size.height;
        }
    } else {
        if ([self.jingJiHuoDongListModol.img isEqualToString:@""]) {
            self.tongZhiDetailsCell.CommunityDetailsImageViewHegit.constant = 0;
            return 200 + self.Hnew + size.height;
        } else {
            return  self.tongZhiDetailsCell.CommunityDetailsImageViewHegit.constant + 200+ self.Hnew + size.height;
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
