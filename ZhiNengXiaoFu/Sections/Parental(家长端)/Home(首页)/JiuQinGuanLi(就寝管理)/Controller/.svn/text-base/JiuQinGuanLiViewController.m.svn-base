//
//  JiuQinGuanLiViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/8/29.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "JiuQinGuanLiViewController.h"
#import "JiuQinPersonCell.h"
#import "JiuQinItemCell.h"
#import "QianDaoInModel.h"
#import "QianDaoModel.h"

@interface JiuQinGuanLiViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView    *JiuQinGuanLiTableView;
@property (nonatomic, strong) NSMutableArray *JiuQinGuanLiAry;
@property (nonatomic, assign) NSInteger      page;
@property (nonatomic, strong) UIImageView    *zanwushuju;
//封装就寝model
@property (nonatomic, strong) QianDaoModel   *qianDaoModel;

@end

@implementation JiuQinGuanLiViewController

- (NSMutableArray *)JiuQinGuanLiAry {
    if (!_JiuQinGuanLiAry) {
        self.JiuQinGuanLiAry = [@[]mutableCopy];
    }
    return _JiuQinGuanLiAry;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"就寝管理";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.JiuQinGuanLiTableView];
    
    self.JiuQinGuanLiTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.JiuQinGuanLiTableView registerClass:[JiuQinPersonCell class] forCellReuseIdentifier:@"JiuQinPersonCellId"];
    
    [self.JiuQinGuanLiTableView registerNib:[UINib nibWithNibName:@"JiuQinItemCell" bundle:nil] forCellReuseIdentifier:@"JiuQinItemCellId"];
    
    self.zanwushuju = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 105 / 2, 200, 105, 111)];
    self.zanwushuju.image = [UIImage imageNamed:@"暂无数据家长端"];
    self.zanwushuju.alpha = 0;
    [self.view addSubview:self.zanwushuju];
    
    //下拉刷新
    self.JiuQinGuanLiTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    //自动更改透明度
    self.JiuQinGuanLiTableView.mj_header.automaticallyChangeAlpha = YES;
    //进入刷新状态
    [self.JiuQinGuanLiTableView.mj_header beginRefreshing];
    //上拉刷新
    self.JiuQinGuanLiTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
}

//下拉刷新
- (void)loadNewTopic {
    self.page = 1;
    [self.JiuQinGuanLiAry removeAllObjects];
    [self getNetWork:self.page];
}

//上拉刷新
- (void)loadMoreTopic {
    self.page += 1;
    [self getNetWork:self.page];
}

- (void)getNetWork:(NSInteger)page {
    NSDictionary * dic = @{@"key":[UserManager key],@"page":[NSString stringWithFormat:@"%ld",page]};
    [[HttpRequestManager sharedSingleton] POST:indexDormGetDormRecord parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        //结束头部刷新
        [self.JiuQinGuanLiTableView.mj_header endRefreshing];
        //结束尾部刷新
        [self.JiuQinGuanLiTableView.mj_footer endRefreshing];
        self.qianDaoModel = [QianDaoModel mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
        
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            NSMutableArray *arr = [QianDaoInModel mj_objectArrayWithKeyValuesArray:[[responseObject objectForKey:@"data"] objectForKey:@"record"]];
            for (QianDaoInModel *model in arr) {
                [self.JiuQinGuanLiAry addObject:model];
            }
            if (self.JiuQinGuanLiAry.count == 0) {
                self.zanwushuju.alpha = 1;
            } else {
                self.zanwushuju.alpha = 0;
            }
            [self.JiuQinGuanLiTableView reloadData];
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

//tableview的加载
- (UITableView *)JiuQinGuanLiTableView {
    if (!_JiuQinGuanLiTableView) {
        self.JiuQinGuanLiTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_NAVH) style:UITableViewStylePlain];
        self.JiuQinGuanLiTableView.delegate = self;
        self.JiuQinGuanLiTableView.dataSource = self;
        self.JiuQinGuanLiTableView.backgroundColor = [UIColor whiteColor];
    }
    return _JiuQinGuanLiTableView;
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
        return self.JiuQinGuanLiAry.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   if (indexPath.section == 0) {
        JiuQinPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JiuQinPersonCellId" forIndexPath:indexPath];
       cell.nameLabel.text = self.qianDaoModel.name;
       [cell.headImg sd_setImageWithURL:[NSURL URLWithString:self.qianDaoModel.head_img] placeholderImage:[UIImage imageNamed:@"user"]];
       if (self.qianDaoModel.nature == 1) {
           cell.typeLabel.text = @"类型:走读生";
       } else {
           cell.typeLabel.text = @"类型:住校生";
       }
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        JiuQinItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JiuQinItemCellId" forIndexPath:indexPath];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        if (self.JiuQinGuanLiAry.count != 0) {
            QianDaoInModel *model = [self.JiuQinGuanLiAry objectAtIndex:indexPath.row];
            if (model.type == 1) {
                cell.JiuQinItemNameLabel.text = @"入寝";
                cell.JiuQinItemStateImg.image = [UIImage imageNamed:@"就寝矩形"];
                cell.JiuQinItemStateTwoImg.image = [UIImage imageNamed:@"寝室图标"];
            } else if (model.type == 2) {
                cell.JiuQinItemNameLabel.text = @"出寝";
                cell.JiuQinItemStateImg.image = [UIImage imageNamed:@"出寝矩形"];
                cell.JiuQinItemStateTwoImg.image = [UIImage imageNamed:@"宿舍拷贝"];
            }
            cell.JiuQinItemXingQiLabel.text = model.week;
            cell.JiuQinItemTimeLabel.text = model.create_time;
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 108;
    } else {
        return 73;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
