//
//  LeaveListViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/24.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "LeaveListViewController.h"
#import "LeaveListItemCell.h"
#import "LeaveRequestViewController.h"
#import "LeaveDetailsViewController.h"
#import "LeaveListModel.h"

@interface LeaveListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView    *leaveListTableView;
@property (nonatomic, strong) NSMutableArray *leaveListAry;
@property (nonatomic, assign) NSInteger      page;
@property (nonatomic, strong) NSMutableArray *bannerArr;
@property (nonatomic, strong) UIImageView    *zanwushuju;

@end

@implementation LeaveListViewController

- (NSMutableArray *)leaveListAry {
    if (!_leaveListAry) {
        self.leaveListAry = [@[]mutableCopy];
    }
    return _leaveListAry;
}


- (NSMutableArray *)bannerArr {
    if (!_bannerArr) {
        _bannerArr = [NSMutableArray array];
    }
    return _bannerArr;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getBannersURLData];
    //下拉刷新
    self.leaveListTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    //自动更改透明度
    self.leaveListTableView.mj_header.automaticallyChangeAlpha = YES;
    //进入刷新状态
    [self.leaveListTableView.mj_header beginRefreshing];
    //上拉刷新
    self.leaveListTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
    
    self.zanwushuju = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 105 / 2, 200, 105, 111)];
    self.zanwushuju.image = [UIImage imageNamed:@"暂无数据家长端"];
    self.zanwushuju.alpha = 0;
    [self.leaveListTableView addSubview:self.zanwushuju];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
}

- (void)loadNewTopic {
    self.page = 1;
    [self.leaveListAry removeAllObjects];
    [self setNetWork:self.page];
}

- (void)loadMoreTopic {
    self.page += 1;
    [self setNetWork:self.page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"请假列表";
    self.page = 1;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"请假" style:UIBarButtonItemStyleDone target:self action:@selector(rightButton:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15], NSFontAttributeName, nil] forState:UIControlStateNormal];
    [self.view addSubview:self.leaveListTableView];
    self.leaveListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.leaveListTableView registerClass:[LeaveListItemCell class] forCellReuseIdentifier:@"LeaveListItemCellId"];
}



- (void)getBannersURLData {
    NSDictionary *dic = @{@"key":[UserManager key],@"t_id":@"9"};
    [[HttpRequestManager sharedSingleton] POST:bannersURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            self.bannerArr = [BannerModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            [self.leaveListTableView reloadData];
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


- (void)setNetWork:(NSInteger)page {
    NSDictionary * dic = @{@"key":[UserManager key],@"page":[NSString stringWithFormat:@"%ld",page]};
    [[HttpRequestManager sharedSingleton] POST:leaveLeaveList parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        //结束头部刷新
        [self.leaveListTableView.mj_header endRefreshing];
        //结束尾部刷新
        [self.leaveListTableView.mj_footer endRefreshing];
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            NSMutableArray *arr = [LeaveListModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            for (LeaveListModel *model in arr) {
                [self.leaveListAry addObject:model];
            }
            if (self.leaveListAry.count == 0) {
                self.zanwushuju.alpha = 1;
            } else {
                self.zanwushuju.alpha = 0;
            }
            [self.leaveListTableView reloadData];
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

- (UITableView *)leaveListTableView {
    if (!_leaveListTableView) {
        self.leaveListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_NAVH) style:UITableViewStylePlain];
        self.leaveListTableView.backgroundColor = backColor;
        self.leaveListTableView.dataSource = self;
        self.leaveListTableView.delegate = self;
    }
    return _leaveListTableView;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return self.leaveListAry.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"TableViewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        } else {
            //删除cell中的子对象,刷新覆盖问题。
            while ([cell.contentView.subviews lastObject] != nil) {
                [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *imgs = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 170)];
        if (self.bannerArr.count == 0) {
            //            imgs.image = [UIImage imageNamed:@"教师端活动管理banner"];
        } else {
            BannerModel *model = [self.bannerArr objectAtIndex:0];
            [imgs sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"banner"]];
        }
        [cell addSubview:imgs];
        return cell;
    } else {
        LeaveListItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeaveListItemCellId" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        LeaveListModel *model = [self.leaveListAry objectAtIndex:indexPath.row];
        cell.LeaveTimeLabel.text = [NSString stringWithFormat:@"请假时间: %@ 至 %@", model.start, model.end];
        cell.LeaveReasonLabel.text = model.reason;
        if (model.status == 1) {
            cell.stateLabel.text = @"已批准";
            cell.stateLabel.textColor = tabBarColor;
        } else {
            cell.stateLabel.text = @"审核中";
            cell.stateLabel.textColor = RGB(218, 23, 55);
        }
        return cell;
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


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 170;
    } else {
        return 100;
    }
}

- (void)rightButton:(UIBarButtonItem *)sender {
    LeaveRequestViewController *leaveRequestVC = [[LeaveRequestViewController alloc] init];
    [self.navigationController pushViewController:leaveRequestVC animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LeaveDetailsViewController *leaveDetailsVC = [[LeaveDetailsViewController alloc] init];
    LeaveListModel * model = [self.leaveListAry objectAtIndex:indexPath.row];
    leaveDetailsVC.leaveDetailsId = model.ID;
    [self.navigationController pushViewController:leaveDetailsVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
