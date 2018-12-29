//
//  NewGuidelinesViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/8/21.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "NewGuidelinesViewController.h"
#import "TongZhiDetailsCell.h"
#import "WorkDetailsModel.h"
#import <WebKit/WebKit.h>
#import "BannerModel.h"

@interface NewGuidelinesViewController ()<UITableViewDelegate, UITableViewDataSource,WKUIDelegate,WKNavigationDelegate>

@property (nonatomic, strong) UITableView        *newGuidelinesTableView;
@property (nonatomic, strong) WorkDetailsModel   *workDetailsModel;
@property (nonatomic, strong) TongZhiDetailsCell *tongZhiDetailsCell;
@property (nonatomic, strong) NSMutableArray     *imgAry;
@property (nonatomic, assign) CGFloat            Hnew;
@property (nonatomic, strong) UIImageView        *headImgView;
@property (nonatomic, strong) NSMutableArray     *bannerArr;

@end

@implementation NewGuidelinesViewController

- (NSMutableArray *)bannerArr {
    if (!_bannerArr) {
        _bannerArr = [NSMutableArray array];
    }
    return _bannerArr;
}

- (NSMutableArray *)imgAry {
    if (!_imgAry) {
        self.imgAry = [@[]mutableCopy];
    }
    return _imgAry;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getBannersURLData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backColor;
    self.title = @"新生指南";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    [self setNetWork];
    [self.view addSubview:self.newGuidelinesTableView];
    self.navigationItem.hidesBackButton = YES;
    self.headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 170)];
    self.headImgView.backgroundColor = [UIColor clearColor];
    self.newGuidelinesTableView.tableHeaderView = self.headImgView;
    self.headImgView.image = [UIImage imageNamed:@"教师端活动管理banner"];
    [self.newGuidelinesTableView registerNib:[UINib nibWithNibName:@"TongZhiDetailsCell" bundle:nil] forCellReuseIdentifier:@"TongZhiDetailsCellId"];
}

- (void)getBannersURLData {
    NSDictionary *dic = @{@"key":[UserManager key],@"t_id":@"10"};
    [[HttpRequestManager sharedSingleton] POST:bannersURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            self.bannerArr = [BannerModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            if (self.bannerArr.count == 0) {
                self.headImgView.image = [UIImage imageNamed:@"教师端活动管理banner"];
            } else {
                BannerModel * model = [self.bannerArr objectAtIndex:0];
                [self.headImgView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"教师端活动管理banner"]];
                [self.newGuidelinesTableView reloadData];
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


- (void)setNetWork {
    NSDictionary * dic = @{@"key":[UserManager key]};
    [[HttpRequestManager sharedSingleton] POST:getGuideURL parameters:dic success:^(NSURLSessionDataTask *task, id  responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            self.workDetailsModel = [WorkDetailsModel mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
            [self.newGuidelinesTableView reloadData];
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

- (UITableView *)newGuidelinesTableView {
    if (!_newGuidelinesTableView) {
        self.newGuidelinesTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT)];
        self.newGuidelinesTableView.backgroundColor = [UIColor whiteColor];
        self.newGuidelinesTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.newGuidelinesTableView.delegate = self;
        self.newGuidelinesTableView.dataSource = self;
    }
    return _newGuidelinesTableView;
}


- (void)configureImage {
    for (int i = 0; i < self.imgAry.count; i++) {
        UIImageView *imageViewNew = [[UIImageView alloc] initWithFrame:CGRectMake(0, i * 210, self.tongZhiDetailsCell.PicView.bounds.size.width ,0)];
        [imageViewNew sd_setImageWithURL:[NSURL URLWithString:[self.imgAry objectAtIndex:i]] placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            CGSize size = image.size;
            CGFloat w = size.width;
            CGFloat H = size.height;
            if (w != 0) {
                CGFloat newH = H * self.tongZhiDetailsCell.PicView.bounds.size.width / w;
                self.tongZhiDetailsCell.CommunityDetailsImageViewHegit.constant += (newH + 10);
                imageViewNew.frame =CGRectMake(0, self.tongZhiDetailsCell.CommunityDetailsImageViewHegit.constant - newH,self.tongZhiDetailsCell.PicView.bounds.size.width, H * self.tongZhiDetailsCell.PicView.bounds.size.width / w);
            }
            [self.newGuidelinesTableView reloadData];
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
    self.tongZhiDetailsCell.TongZhiDetailsTimeLabel.text = self.workDetailsModel.create_time;
    if (self.Hnew ==0) {
        self.tongZhiDetailsCell.webView.hidden = NO;
        self.tongZhiDetailsCell.webView.userInteractionEnabled = YES;
        self.tongZhiDetailsCell.webView.UIDelegate = self;
        self.tongZhiDetailsCell.webView.navigationDelegate = self;
        self.tongZhiDetailsCell.TongZhiDetailsConnectLabel.alpha = 0;
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
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:30]};
        CGSize size = [self.workDetailsModel.title boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        self.tongZhiDetailsCell.webView.frame = CGRectMake(10, 30 + size.height , APP_WIDTH - 20, currentHeight);
        self.Hnew = currentHeight;
        self.tongZhiDetailsCell.webView.hidden =NO;
        self.tongZhiDetailsCell.TongZhiDetailsTWebopCon.constant = self.Hnew + 26;
        self.tongZhiDetailsCell.webView.height = currentHeight;
        [self.newGuidelinesTableView reloadData];
        
    }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger width = APP_WIDTH - 30;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:30]};
    CGSize size = [self.workDetailsModel.title boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    if (self.Hnew ==0) {
        if (self.imgAry.count == 0) {
        self.tongZhiDetailsCell.CommunityDetailsImageViewHegit.constant = 0;
            return 150 + size.height;
        } else {
            return  self.tongZhiDetailsCell.CommunityDetailsImageViewHegit.constant + 150 + size.height;
        }
    } else {
        if (self.imgAry.count == 0) {
            self.tongZhiDetailsCell.CommunityDetailsImageViewHegit.constant = 0;
            return 150 + self.Hnew + size.height;
        } else {
            return  self.tongZhiDetailsCell.CommunityDetailsImageViewHegit.constant + 150+ self.Hnew + size.height;
        }
    }
}


@end
