//
//  QianDaoViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/20.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "QianDaoViewController.h"
#import "QianDaoPsersonCell.h"
#import "QianDaoItemCell.h"
#import "QianDaoModel.h"
#import "QianDaoInModel.h"
#import "PersonInformationModel.h"

@interface QianDaoViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak)   CLPlayerView   *playerView;
@property (nonatomic, strong) UITableView    *QianDaoTableView;
@property (nonatomic, strong) NSMutableArray *QianDaoAry;
@property (nonatomic, strong) UIView         *backView;
@property (nonatomic, strong) QianDaoModel   *qianDaoModel;
@property (nonatomic, strong) UIImageView    *close;
@property (nonatomic, strong) UIImageView    *zanwushuju;
@property (nonatomic, strong) PersonInformationModel *personModel;

@end

@implementation QianDaoViewController

- (NSMutableArray *)QianDaoAry {
    if (!_QianDaoAry) {
        self.QianDaoAry = [@[]mutableCopy];
    }
    return _QianDaoAry;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"进出安全";
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"location_openStr"]);
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"location_urlStr"]);
    //游客登陆判断
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"youkeState"] isEqualToString:@"1"]) {
        
    } else {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"chooseLoginState"] isEqualToString:@"2"] && [[[NSUserDefaults standardUserDefaults] objectForKey:@"location_openStr"] isEqualToString:@"0"]) {
            
        } else {
            
            if ([self.typeID isEqualToString:@"1"]) {
            
            } else {
                self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"dingwei"] style:UIBarButtonItemStyleDone target:self action:@selector(dingweiClick:)];
                self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
            }
 
        }
    }
    
    [self.view addSubview:self.QianDaoTableView];
        
    [self.QianDaoTableView registerClass:[QianDaoPsersonCell class] forCellReuseIdentifier:@"QianDaoPsersonCellId"];
    [self.QianDaoTableView registerClass:[QianDaoItemCell class] forCellReuseIdentifier:@"QianDaoItemCellId"];
    self.QianDaoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.zanwushuju = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 105 / 2, 200, 105, 111)];
    self.zanwushuju.image = [UIImage imageNamed:@"暂无数据家长端"];
    self.zanwushuju.alpha = 0;
    [self.QianDaoTableView addSubview:self.zanwushuju];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //下拉刷新
    self.QianDaoTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(setNetWork)];
    //自动更改透明度
    self.QianDaoTableView.mj_header.automaticallyChangeAlpha = YES;
    [self.QianDaoTableView.mj_header beginRefreshing];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.QianDaoTableView.mj_header endRefreshing];
}

- (void)setNetWork {
    [self.QianDaoAry removeAllObjects];
    NSDictionary *dic  = [NSDictionary dictionary];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"chooseLoginState"] isEqualToString:@"2"]) {
        dic = @{@"key":[UserManager key], @"student_id":self.studentId};
    } else {
        dic = @{@"key":[UserManager key]};
    }
    
    [[HttpRequestManager sharedSingleton] POST:recordURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        self.qianDaoModel = [QianDaoModel mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            self.QianDaoAry = [QianDaoInModel mj_objectArrayWithKeyValuesArray:self.qianDaoModel.record];
            if (self.QianDaoAry.count == 0) {
                self.zanwushuju.alpha = 1;
            } else {
                self.zanwushuju.alpha = 0;
            }
            [self.QianDaoTableView reloadData];
        } else {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
            } else {
                
            }
            [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
        }
        [self.QianDaoTableView.mj_header endRefreshing];

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
        [self.QianDaoTableView.mj_header endRefreshing];
    }];
}




- (UITableView *)QianDaoTableView {
    if (!_QianDaoTableView) {
        if ([self.typeID isEqualToString:@"1"]) {
             self.QianDaoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_NAVH) style:UITableViewStylePlain];
        } else {
             self.QianDaoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_TABH - APP_NAVH) style:UITableViewStylePlain];
        }
        
        self.QianDaoTableView.delegate = self;
        self.QianDaoTableView.dataSource = self;
        self.QianDaoTableView.backgroundColor = backColor;
    }
    return _QianDaoTableView;
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
    if (section == 0) {
        return 1;
    } else {
        return self.QianDaoAry.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        QianDaoPsersonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QianDaoPsersonCellId" forIndexPath:indexPath];
        cell.itemLabel.text = self.qianDaoModel.name;
        [cell.itemImg sd_setImageWithURL:[NSURL URLWithString:self.qianDaoModel.head_img] placeholderImage:[UIImage imageNamed:@"user"]];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        QianDaoItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QianDaoItemCellId" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.QianDaoAry.count != 0) {
            QianDaoInModel * model = [self.QianDaoAry objectAtIndex:indexPath.row];
            if (model.type == 1) {
                cell.stateLabel.text = @"进校";
                cell.stateImg.image = [UIImage imageNamed:@"进校"];
            } else {
                cell.stateLabel.text = @"出校";
                cell.stateImg.image = [UIImage imageNamed:@"出校"];
            }
            cell.timeLabel.text = model.week;
            cell.detailsTimeLabel.text = model.create_time;
            if (indexPath.row == 0) {
                cell.yuanImg.image = [UIImage imageNamed:@"椭圆5"];
            } else {
                cell.yuanImg.image = [UIImage imageNamed:@"椭圆5"];
            }
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 108;
    } else {
        return 70;
    }
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {

    } else {
        QianDaoInModel *model = [self.QianDaoAry objectAtIndex:indexPath.row];
        self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT)];
        self.backView.backgroundColor = COLOR(0, 0, 0, 0.2);
        UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backTap:)];
        self.backView.userInteractionEnabled = YES;
        [self.backView addGestureRecognizer:backTap];
        [[[UIApplication sharedApplication] keyWindow] addSubview:self.backView];
        
        CLPlayerView *playerView = [[CLPlayerView alloc] initWithFrame:CGRectMake(15, APP_HEIGHT / 2 - 100, self.view.CLwidth - 30 , 200)];
        playerView.maskView.fullButton.alpha = 0;
        _playerView = playerView;
        
        [[[UIApplication sharedApplication] keyWindow] addSubview:_playerView];
        
        //    //重复播放，默认不播放
        _playerView.repeatPlay = YES;
        //    //当前控制器是否支持旋转，当前页面支持旋转的时候需要设置，告知播放器
        _playerView.isLandscape = NO;
       
        _playerView.url = [NSURL URLWithString:model.video];
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
            NSLog(@"播放完成");
        }];

        
       self.close = [[UIImageView alloc] initWithFrame:CGRectMake(_playerView.frame.size.width + _playerView.frame.origin.x - 10, _playerView.frame.origin.y - 10, 20 , 20)];
        self.close.image = [UIImage imageNamed:@"guanbi"];
        UITapGestureRecognizer *closeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeTap:)];
        self.close.userInteractionEnabled = YES;
        [self.close addGestureRecognizer:closeTap];
        [[[UIApplication sharedApplication] keyWindow] addSubview:self.close];
    }
}

-(void)viewDidDisappear:(BOOL)animated {
    [_playerView destroyPlayer];
    _playerView = nil;
    [self.close removeFromSuperview];
    [_playerView removeFromSuperview];
    [self.backView removeFromSuperview];
}

- (void)dingweiClick:(UIBarButtonItem *)sender {

    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"location_urlStr"] != nil) {
        TGWebViewController *web = [[TGWebViewController alloc] init];
        web.url = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"location_urlStr"]];
        web.webTitle = @"一山智慧";
        [self.navigationController pushViewController:web animated:YES];
    }
}

- (void)imgTap:(UITapGestureRecognizer *)sender {
    
}

- (void)closeTap:(UITapGestureRecognizer *)sender {
    [self.backView removeFromSuperview];
    [_playerView destroyPlayer];
    _playerView = nil;
    [_playerView removeFromSuperview];
    [self.close removeFromSuperview];
}

- (void)backTap:(UITapGestureRecognizer *)sender {
    [self.backView removeFromSuperview];
    [self.close removeFromSuperview];
    [_playerView removeFromSuperview];
    [_playerView destroyPlayer];
    _playerView = nil;
}

#pragma mark -- 需要设置全局支持旋转方向，然后重写下面三个方法可以让当前页面支持多个方向

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate {
    return NO;
}



- (NSUInteger)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
