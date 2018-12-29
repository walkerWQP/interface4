//
//  OngoingTableViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/8/14.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "OngoingTableViewController.h"
#import "OngoingTableViewCell.h"
#import "OngoingModel.h"
#import "JingJiActivityDetailsViewController.h"

@interface OngoingTableViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray  *ongoingArr;
@property (nonatomic, strong) UITableView     *ongoingTableView;
@property (nonatomic, assign) NSInteger       page;
@property (nonatomic, strong) UIImageView     *zanwushuju;

@end

@implementation OngoingTableViewController

- (NSMutableArray *)ongoingArr {
    if (!_ongoingArr) {
        _ongoingArr = [NSMutableArray array];
    }
    return _ongoingArr;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    self.page = 1;
    //下拉刷新
    self.ongoingTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    //自动更改透明度
    self.ongoingTableView.mj_header.automaticallyChangeAlpha = YES;
    //进入刷新状态
    [self.ongoingTableView.mj_header beginRefreshing];
    //上拉刷新
    self.ongoingTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的活动列表";
    self.zanwushuju = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 105 / 2, 200, 105, 111)];
    self.zanwushuju.image = [UIImage imageNamed:@"暂无数据家长端"];
    self.zanwushuju.alpha = 0;
    [self.ongoingTableView addSubview:self.zanwushuju];
    [self.view addSubview:self.ongoingTableView];
    [self.ongoingTableView registerClass:[OngoingTableViewCell class] forCellReuseIdentifier:@"OngoingTableViewCellID"];
    self.ongoingTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)loadNewTopic {
    self.page = 1;
    [self.ongoingArr removeAllObjects];
    [self getActivityActivityListData:self.page];
}

- (void)loadMoreTopic {
    self.page += 1;
    [self getActivityActivityListData:self.page];
}

-  (void)getActivityActivityListData:(NSInteger)page  {
    NSDictionary *dic = @{@"key":[UserManager key],@"page":[NSString stringWithFormat:@"%ld",page]};
    [[HttpRequestManager sharedSingleton] POST:myPublishURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        //结束头部刷新
        [self.ongoingTableView.mj_header endRefreshing];
        //结束尾部刷新
        [self.ongoingTableView.mj_footer endRefreshing];
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            NSMutableArray *arr = [OngoingModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            for (OngoingModel *model in arr) {
                [self.ongoingArr addObject:model];
            }
            if (self.ongoingArr.count == 0) {
                self.zanwushuju.alpha = 1;
            } else {
                self.zanwushuju.alpha = 0;
                [self.ongoingTableView reloadData];
            }
            
        } else {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
            } else {
                
            }
            [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
        }
        [self.ongoingTableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}

- (UITableView *)ongoingTableView {
    if (!_ongoingTableView) {
        self.ongoingTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_NAVH) style:UITableViewStylePlain];
        self.ongoingTableView.backgroundColor = backColor;
        self.ongoingTableView.delegate = self;
        self.ongoingTableView.dataSource = self;
        self.ongoingTableView.estimatedRowHeight = 0;
        self.ongoingTableView.estimatedSectionHeaderHeight = 0;
        self.ongoingTableView.estimatedSectionFooterHeight = 0;
    }
    return _ongoingTableView;
}

//侧滑允许编辑cell
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    //添加一个删除按钮
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"点击删除");
        //先删数据 再删UI
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"youkeState"] isEqualToString:@"1"]) {
            [WProgressHUD showErrorAnimatedText:@"游客不能进行此操作"];
        } else {
            OngoingModel * model = [self.ongoingArr objectAtIndex:indexPath.row];
            [self.ongoingArr removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self DeleteActivityURL:model.ID];
        }
    }];
    return @[deleteAction];
}

//删除
- (void)DeleteActivityURL:(NSString *)ID {
    NSDictionary *dic = @{@"key":[UserManager key],@"id":ID};
    [[HttpRequestManager sharedSingleton] POST:deleteActivityURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            [WProgressHUD showSuccessfulAnimatedText:[responseObject objectForKey:@"msg"]];
            [self.ongoingArr removeAllObjects];
            [self.ongoingTableView reloadData];
            [self getActivityActivityListData:1];
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
    return self.ongoingArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OngoingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OngoingTableViewCellID" forIndexPath:indexPath];
    if (self.ongoingArr.count > 0) {
        OngoingModel * model = [self.ongoingArr objectAtIndex:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if ([model.img isEqualToString:@""]) {
            cell.imgView.image = [UIImage imageNamed:@"教师端活动管理banner"];
        } else {
            [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"教师端活动管理banner"]];
        }
        cell.titleLabel.text = model.title;
        cell.timeLabel.text = [NSString stringWithFormat:@"活动日期:%@-%@", model.start, model.end];;
        cell.detailsLabel.text = model.title;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 210;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.ongoingArr.count > 0) {
        OngoingModel *model = [self.ongoingArr objectAtIndex:indexPath.row];
        JingJiActivityDetailsViewController *jingJiActivityDetailsVC = [JingJiActivityDetailsViewController new];
        if (model.ID == nil) {
            [WProgressHUD showErrorAnimatedText:@"数据不正确,请重试"];
        } else {
            //是否已结束0否1是
            if (model.is_over == 0) { //未结束
                jingJiActivityDetailsVC.typeStr = @"3";
                jingJiActivityDetailsVC.JingJiActivityDetailsId = model.ID;
                [self.navigationController pushViewController:jingJiActivityDetailsVC animated:YES];
            } else {  //已结束
                jingJiActivityDetailsVC.JingJiActivityDetailsId = model.ID;
                [self.navigationController pushViewController:jingJiActivityDetailsVC animated:YES];
            }
        }
    }
}



@end
