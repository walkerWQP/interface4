//
//  TeacherTongZhiViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/24.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "TeacherTongZhiViewController.h"
#import "TeacherTongZhiCell.h"
#import "TongZhiCell.h"
#import "TongZhiDetailsViewController.h"
#import "TongZhiModel.h"
#import "CommonStatus.h"
#import "TongZhiNewCell.h"

@interface TeacherTongZhiViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView    *teacherTongZhiTableView;
@property (nonatomic, strong) NSMutableArray *teacherTongZhiAry;
@property (nonatomic, strong) UIImageView    *zanwushuju;
@property (nonatomic, assign) NSInteger      page;

@end

@implementation TeacherTongZhiViewController

- (NSMutableArray *)teacherTongZhiAry {
    if (!_teacherTongZhiAry) {
        self.teacherTongZhiAry = [@[]mutableCopy];
    }
    return _teacherTongZhiAry;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.teacherTongZhiTableView];
    [self.teacherTongZhiTableView registerClass:[TongZhiNewCell class] forCellReuseIdentifier:@"TongZhiNewCellId"];
    self.teacherTongZhiTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.zanwushuju = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 105 / 2, 200, 105, 111)];
    self.zanwushuju.image = [UIImage imageNamed:@"暂无数据家长端"];
    self.zanwushuju.alpha = 0;
    [self.view addSubview:self.zanwushuju];
    //下拉刷新
    self.teacherTongZhiTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    //自动更改透明度
    self.teacherTongZhiTableView.mj_header.automaticallyChangeAlpha = YES;
    //进入刷新状态
    [self.teacherTongZhiTableView.mj_header beginRefreshing];
    //上拉刷新
    self.teacherTongZhiTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
}

- (void)loadNewTopic {
    self.page = 1;
    [self.teacherTongZhiAry removeAllObjects];
    [self getNetWork:self.page];
}

- (void)loadMoreTopic {
    self.page += 1;
    [self getNetWork:self.page];
}

- (void)getNetWork:(NSInteger)page {
    NSDictionary *dic = @{@"key":[UserManager key], @"is_school":@0,@"page":[NSString stringWithFormat:@"%ld",page]};
    [[HttpRequestManager sharedSingleton] POST:JIAZHANGCHAKANTONGZHILIEBIAO parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        //结束头部刷新
        [self.teacherTongZhiTableView.mj_header endRefreshing];
        //结束尾部刷新
        [self.teacherTongZhiTableView.mj_footer endRefreshing];
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            NSMutableArray *arr = [TongZhiModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            for (TongZhiModel *model in arr) {
                [self.teacherTongZhiAry addObject:model];
            }
            if (self.teacherTongZhiAry.count == 0) {
                self.zanwushuju.alpha = 1;
            } else {
                self.zanwushuju.alpha = 0;
                [self.teacherTongZhiTableView reloadData];
            }
            [self.teacherTongZhiTableView reloadData];
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

- (UITableView *)teacherTongZhiTableView {
    if (!_teacherTongZhiTableView) {
        self.teacherTongZhiTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_NAVH - 40) style:UITableViewStylePlain];
        self.teacherTongZhiTableView.backgroundColor = [UIColor whiteColor];
        self.teacherTongZhiTableView.delegate = self;
        self.teacherTongZhiTableView.dataSource = self;
        _teacherTongZhiTableView.estimatedRowHeight = 0;
        _teacherTongZhiTableView.estimatedSectionHeaderHeight = 0;
        _teacherTongZhiTableView.estimatedSectionFooterHeight = 0;
    }
    return _teacherTongZhiTableView;
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
    return self.teacherTongZhiAry.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TongZhiNewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TongZhiNewCellId" forIndexPath:indexPath];
    if (self.teacherTongZhiAry.count != 0) {
        TongZhiModel * model = [self.teacherTongZhiAry objectAtIndex:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.headerImg sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"通知图标"]];
        cell.titleLabel.text = model.title;
        cell.contentLabel.text = model.content;
        cell.timeLabel.text = model.create_time;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (kScreenWidth - 30) * 129 / 364;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TongZhiDetailsViewController * tongZhiDetails  = [[TongZhiDetailsViewController alloc] init];
    if (self.teacherTongZhiAry.count != 0) {
        TongZhiModel * model = [self.teacherTongZhiAry objectAtIndex:indexPath.row];
        tongZhiDetails.tongZhiId = model.ID;
    }
    [self.navigationController pushViewController:tongZhiDetails animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
