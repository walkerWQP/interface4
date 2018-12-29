//
//  WorkDetailsViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/8/2.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "WorkDetailsViewController.h"
#import "TongZhiDetailsCell.h"
#import "TongZhiDetailsModel.h"
#import <WebKit/WebKit.h>
#import "UIView+XXYViewFrame.h"
#import "ChangeViewController.h"

@interface WorkDetailsViewController ()<UITableViewDelegate, UITableViewDataSource,WKUIDelegate,WKNavigationDelegate>

@property (nonatomic, strong) UITableView         *WorkDetailsTableView;
@property (nonatomic, strong) TongZhiDetailsModel *workDetailsModel;
@property (nonatomic, strong) TongZhiDetailsCell  *tongZhiDetailsCell;
@property (nonatomic, strong) NSMutableArray      *imgAry;
@property (nonatomic, assign) CGFloat             Hnew;

@end

@implementation WorkDetailsViewController

- (NSMutableArray *)imgAry {
    if (!_imgAry) {
        self.imgAry = [@[]mutableCopy];
    }
    return _imgAry;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNetWork];
    [self.view addSubview:self.WorkDetailsTableView];
    [self.WorkDetailsTableView registerNib:[UINib nibWithNibName:@"TongZhiDetailsCell" bundle:nil] forCellReuseIdentifier:@"TongZhiDetailsCellId"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"作业详情";
    self.view.backgroundColor = backColor;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    NSUserDefaults *pushJudge = [NSUserDefaults standardUserDefaults];
    if([[pushJudge objectForKey:@"notify"]isEqualToString:@"push"]) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回拷贝"] style:UIBarButtonItemStylePlain target:self action:@selector(rebackToRootViewAction)];
        self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
        NSUserDefaults * pushJudge = [NSUserDefaults standardUserDefaults];
        [pushJudge setObject:@""forKey:@"notify"];
        [pushJudge synchronize];//记得立即同步
    } else {
        
    }

    if ([self.typeID isEqualToString:@"1"]) {
        NSLog(@"1");
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [button setTitle:@"修改" forState:UIControlStateNormal];
        button.titleLabel.font = titFont;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    } else {
        NSLog(@"2");
    }
}

- (void)rebackToRootViewAction {
    NSUserDefaults *pushJudge = [NSUserDefaults standardUserDefaults];
    [pushJudge setObject:@""forKey:@"notify"];
    [pushJudge synchronize];//记得立即同步
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (UITableView *)WorkDetailsTableView {
    if (!_WorkDetailsTableView) {
        self.WorkDetailsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT) style:UITableViewStyleGrouped];
        self.WorkDetailsTableView.backgroundColor = backColor;
        self.WorkDetailsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.WorkDetailsTableView.delegate = self;
        self.WorkDetailsTableView.dataSource = self;
    }
    return _WorkDetailsTableView;
}

- (void)rightBtn:(UIButton *)sender {
    NSLog(@"点击修改");
    ChangeViewController *changeVC = [ChangeViewController new];
    if (self.workId != nil) {
        changeVC.ID = self.workId;
        changeVC.titleStr = self.workDetailsModel.title;
        changeVC.content = self.workDetailsModel.content;
        [self.navigationController pushViewController:changeVC animated:YES];
    } else {
        [WProgressHUD showErrorAnimatedText:@"数据不正确,请重新加载"];
    }
}

- (void)setNetWork {
    NSDictionary *dic = @{@"key":[UserManager key], @"id":self.workId};
    [[HttpRequestManager sharedSingleton] POST:workHomeWorkDetails parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            self.Hnew = 0;
            self.tongZhiDetailsCell.CommunityDetailsImageViewHegit.constant = 0;
            [self.tongZhiDetailsCell.PicView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            self.workDetailsModel = [TongZhiDetailsModel mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
//            [self.imgAry addObject:self.workDetailsModel.img];
            [self configureImage];
            [self.WorkDetailsTableView reloadData];
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
    for (int i = 0; i < self.workDetailsModel.img.count; i++) {
        UIImageView *imageViewNew = [[UIImageView alloc] initWithFrame:CGRectMake(0, i * 210, self.tongZhiDetailsCell.PicView.bounds.size.width ,0)];
        [imageViewNew sd_setImageWithURL:[NSURL URLWithString:[self.workDetailsModel.img objectAtIndex:i]] placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            CGSize size = image.size;
            CGFloat w = size.width;
            CGFloat H = size.height;
            if (w != 0) {
                CGFloat newH = H * self.tongZhiDetailsCell.PicView.bounds.size.width / w;
                self.tongZhiDetailsCell.CommunityDetailsImageViewHegit.constant += (newH + 10);
                imageViewNew.frame =CGRectMake(0, self.tongZhiDetailsCell.CommunityDetailsImageViewHegit.constant - newH,self.tongZhiDetailsCell.PicView.bounds.size.width, H * self.tongZhiDetailsCell.PicView.bounds.size.width / w);
            }
            [self.WorkDetailsTableView reloadData];
        }];
        [self.tongZhiDetailsCell.PicView addSubview:imageViewNew];
    }
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
    self.tongZhiDetailsCell.TongZhiDetailsTitleLabel.text = self.workDetailsModel.title;
    self.tongZhiDetailsCell.TongZhiDetailsConnectLabel.text = self.workDetailsModel.content;
    self.tongZhiDetailsCell.TongZhiDetailsTimeLabel.alpha = 1;
    self.tongZhiDetailsCell.TongZhiDetailsTimeLabel.text  = self.workDetailsModel.create_time;
    
    if (self.Hnew ==0) {
        self.tongZhiDetailsCell.webView.hidden = NO;
        //            self.newsDetailsTopCell.webView.backgroundColor = BAKit_Color_Yellow_pod;
        self.tongZhiDetailsCell.webView.userInteractionEnabled = YES;
        self.tongZhiDetailsCell.webView.UIDelegate = self;
        self.tongZhiDetailsCell.webView.navigationDelegate = self;
        
        if (self.workDetailsModel.content.length>0) {
            [self.tongZhiDetailsCell.webView loadHTMLString:[NSString stringWithFormat:@"<meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'><meta name='apple-mobile-web-app-capable' content='yes'><meta name='apple-mobile-web-app-status-bar-style' content='black'><meta name='format-detection' content='telephone=no'><style type='text/css'>img{width:%fpx}</style>%@", APP_WIDTH - 20, self.workDetailsModel.content] baseURL:nil];
        }
        
    }
    return self.tongZhiDetailsCell;
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    NSString *heightString4 = @"document.body.scrollHeight";
    [webView evaluateJavaScript:heightString4 completionHandler:^(id _Nullable item, NSError * _Nullable error) {
        CGFloat currentHeight = [item doubleValue];
        NSInteger width = APP_WIDTH - 30;
        //        self.titleText = self.tongZhiDetailsModel.title;
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:30]};
        CGSize size = [self.workDetailsModel.title boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        self.tongZhiDetailsCell.webView.frame = CGRectMake(10, 30 + size.height , APP_WIDTH - 20, currentHeight);
        //                weak_self.communityDetailsCell.communityDetailsHegiht.constant = currentHeight;
        self.Hnew = currentHeight;
        NSLog(@"html 高度2：%f", currentHeight);
        self.tongZhiDetailsCell.webView.hidden =NO;
        self.tongZhiDetailsCell.TongZhiDetailsTWebopCon.constant = self.Hnew + 26;
        self.tongZhiDetailsCell.webView.height = currentHeight;
        [self.WorkDetailsTableView reloadData];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger width = APP_WIDTH - 30;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:30]};
    CGSize size = [self.workDetailsModel.title boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    if (self.Hnew ==0) {
        if (self.workDetailsModel.img.count == 0) {
            self.tongZhiDetailsCell.CommunityDetailsImageViewHegit.constant = 0;
            return 150 + size.height;
        } else {
            return  self.tongZhiDetailsCell.CommunityDetailsImageViewHegit.constant + 150 + size.height;
        }
    } else {
        if (self.workDetailsModel.img.count == 0) {
            self.tongZhiDetailsCell.CommunityDetailsImageViewHegit.constant = 0;
            return 150 + size.height + self.Hnew;
        } else {
            return  self.tongZhiDetailsCell.CommunityDetailsImageViewHegit.constant + 150  + size.height + self.Hnew;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
