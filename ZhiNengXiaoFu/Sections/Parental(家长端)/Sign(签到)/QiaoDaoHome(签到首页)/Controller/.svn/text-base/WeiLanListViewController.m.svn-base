//
//  WeiLanListViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/8/23.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "WeiLanListViewController.h"
#import "WeiLanListModel.h"
#import "WeiLanListCell.h"
#import "WeiLanViewController.h"
@interface WeiLanListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView    *WeiLanListTableView;
@property (nonatomic, strong) NSMutableArray *WeiLanListAry;
@property (nonatomic, strong) UIImageView    *zanwushuju;
@property (nonatomic, assign) NSInteger      page;
@end

@implementation WeiLanListViewController

- (NSMutableArray *)WeiLanListAry {
    if (!_WeiLanListAry) {
        self.WeiLanListAry = [@[]mutableCopy];
    }
    return _WeiLanListAry;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"电子围栏";
    self.WeiLanListTableView.delegate = self;
    self.WeiLanListTableView.dataSource = self;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加围栏" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButton:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    
    [self.view addSubview:self.WeiLanListTableView];
    self.WeiLanListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.WeiLanListTableView registerNib:[UINib nibWithNibName:@"WeiLanListCell" bundle:nil] forCellReuseIdentifier:@"WeiLanListCellId"];

    self.zanwushuju = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 105 / 2, 200, 105, 111)];
    self.zanwushuju.image = [UIImage imageNamed:@"暂无数据家长端"];
    self.zanwushuju.alpha = 0;
    [self.view addSubview:self.zanwushuju];
    
}

- (void)viewWillAppear:(BOOL)animated {
    //下拉刷新
    self.WeiLanListTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    //自动更改透明度
    self.WeiLanListTableView.mj_header.automaticallyChangeAlpha = YES;
    //进入刷新状态
    [self.WeiLanListTableView.mj_header beginRefreshing];
    //上拉刷新
    self.WeiLanListTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
}

- (void)loadNewTopic {
    self.page = 1;
    [self.WeiLanListAry removeAllObjects];
    [self setNetWork:self.page];
}

- (void)loadMoreTopic {
    self.page += 1;
    [self setNetWork:self.page];
}

- (void)setNetWork:(NSInteger)page {
    NSDictionary * dic = @{@"key":[UserManager key],@"page":[NSString stringWithFormat:@"%ld",page]};
    [[HttpRequestManager sharedSingleton] POST:indexFenceGetFence parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        //结束头部刷新
        [self.WeiLanListTableView.mj_header endRefreshing];
        //结束尾部刷新
        [self.WeiLanListTableView.mj_footer endRefreshing];
        
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            NSMutableArray *arr = [WeiLanListModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            for (WeiLanListModel *model in arr) {
                [self.WeiLanListAry addObject:model];
            }
            if (self.WeiLanListAry.count == 0) {
                self.zanwushuju.alpha = 1;
            } else {
                self.zanwushuju.alpha = 0;
                [self.WeiLanListTableView reloadData];
            }
            [self.WeiLanListTableView reloadData];
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



- (UITableView *)WeiLanListTableView {
    if (!_WeiLanListTableView) {
        self.WeiLanListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_NAVH) style:UITableViewStylePlain];
        self.WeiLanListTableView.backgroundColor = backColor;
        _WeiLanListTableView.estimatedRowHeight = 0;
        _WeiLanListTableView.estimatedSectionHeaderHeight = 0;
        _WeiLanListTableView.estimatedSectionFooterHeight = 0;
    }
    return _WeiLanListTableView;
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
    return self.WeiLanListAry.count;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeiLanListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WeiLanListCellId" forIndexPath:indexPath];
    if (self.WeiLanListAry.count != 0) {
        WeiLanListModel * model = [self.WeiLanListAry objectAtIndex:indexPath.row];
        cell.WeiLanListTitleLabel.text = model.name;
        cell.WeiLanListConnectLabel.text = [NSString stringWithFormat:@"经度:%f 纬度:%f 半径:%ld", model.longitude, model.latitude, model.radius];
        cell.WeiLanListTimeLabel.text = model.create_time;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 95;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.WeiLanListAry.count != 0) {
        WeiLanViewController * weiLanVC = [[WeiLanViewController alloc] init];
        WeiLanListModel * model = [self.WeiLanListAry objectAtIndex:indexPath.row];
        weiLanVC.latitude = model.latitude;
        weiLanVC.longitude = model.longitude;
        weiLanVC.radis = model.radius;
        [self.navigationController pushViewController:weiLanVC animated:YES];
    }
}

//侧滑允许编辑cell
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


//#pragma Mark 左滑按钮 iOS8以上
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //添加一个删除按钮
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"点击删除");
        //先删数据 再删UI
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"youkeState"] isEqualToString:@"1"]) {
            [WProgressHUD showErrorAnimatedText:@"游客不能进行此操作"];
        } else {
            WeiLanListModel * model = [self.WeiLanListAry objectAtIndex:indexPath.row];
            [self.WeiLanListAry removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self WorkDeleteData:model.ID];
        }
    }];
    return @[deleteAction];
}

//删除
- (void)WorkDeleteData:(NSString *)workID {
    NSDictionary *dic = @{@"key":[UserManager key],@"id":workID};
    [[HttpRequestManager sharedSingleton] POST:indexFenceDeleteFence parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            [WProgressHUD showSuccessfulAnimatedText:[responseObject objectForKey:@"msg"]];
            [self.WeiLanListAry removeAllObjects];
            [self.WeiLanListTableView reloadData];
            [self setNetWork:1];
        
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


- (void)rightBarButton:(UIBarButtonItem *)sender {
    WeiLanViewController * weiLanVC = [[WeiLanViewController alloc] init];
    weiLanVC.latitude = 34.797254;
    weiLanVC.longitude = 113.59985;
    weiLanVC.radis = 200;
    [self.navigationController pushViewController:weiLanVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
