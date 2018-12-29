//
//  HeartHealtyViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/30.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "HeartHealtyViewController.h"
#import "ParentXueTangCell.h"
#import "ParentXueTangModel.h"
#import "ParentXueTangDetailsViewController.h"

@interface HeartHealtyViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView    *HeartHealtyTableView;
@property (nonatomic, strong) NSMutableArray *ChildJiaoYuAry;
@property (nonatomic, strong) UIImageView    *zanwushuju;
@property (nonatomic, assign) NSInteger      page;

@end

@implementation HeartHealtyViewController

- (NSMutableArray *)ChildJiaoYuAry {
    if (!_ChildJiaoYuAry) {
        self.ChildJiaoYuAry = [@[]mutableCopy];
    }
    return _ChildJiaoYuAry;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.HeartHealtyTableView.delegate = self;
    self.HeartHealtyTableView.dataSource = self;
    
    [self.view addSubview:self.HeartHealtyTableView];
    self.HeartHealtyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.HeartHealtyTableView registerClass:[ParentXueTangCell class] forCellReuseIdentifier:@"ParentXueTangCellId"];
    
    self.zanwushuju = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 105 / 2, 200, 105, 111)];
    self.zanwushuju.image = [UIImage imageNamed:@"暂无数据家长端"];
    self.zanwushuju.alpha = 0;
    [self.view addSubview:self.zanwushuju];
    
    //下拉刷新
    self.HeartHealtyTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    //自动更改透明度
    self.HeartHealtyTableView.mj_header.automaticallyChangeAlpha = YES;
    //进入刷新状态
    [self.HeartHealtyTableView.mj_header beginRefreshing];
    //上拉刷新
    self.HeartHealtyTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
}

- (void)loadNewTopic {
    self.page = 1;
    [self.ChildJiaoYuAry removeAllObjects];
    [self setNetWork:self.page];
}

- (void)loadMoreTopic {
    self.page += 1;
    [self setNetWork:self.page];
}

- (void)setNetWork:(NSInteger)page {
    NSDictionary *dic = @{@"key":[UserManager key], @"type":@2, @"page":[NSString stringWithFormat:@"%ld",page]};
    [[HttpRequestManager sharedSingleton] POST:pschoolGetList parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        //结束头部刷新
        [self.HeartHealtyTableView.mj_header endRefreshing];
        //结束尾部刷新
        [self.HeartHealtyTableView.mj_footer endRefreshing];
        
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            NSMutableArray *arr = [ParentXueTangModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            for (ParentXueTangModel *model in arr) {
                [self.ChildJiaoYuAry addObject:model];
            }
            if (self.ChildJiaoYuAry.count == 0) {
                self.zanwushuju.alpha = 1;
            } else {
                self.zanwushuju.alpha = 0;
                [self.HeartHealtyTableView reloadData];
            }
            [self.HeartHealtyTableView reloadData];
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



- (UITableView *)HeartHealtyTableView {
    if (!_HeartHealtyTableView) {
        self.HeartHealtyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT  - 40 - APP_NAVH) style:UITableViewStylePlain];
        self.HeartHealtyTableView.backgroundColor = backColor;
        self.HeartHealtyTableView.delegate = self;
        self.HeartHealtyTableView.dataSource = self;
        self.HeartHealtyTableView.backgroundColor = backColor;
        _HeartHealtyTableView.estimatedRowHeight = 0;
        _HeartHealtyTableView.estimatedSectionHeaderHeight = 0;
        _HeartHealtyTableView.estimatedSectionFooterHeight = 0;
    }
    return _HeartHealtyTableView;
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
    return self.ChildJiaoYuAry.count;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ParentXueTangCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ParentXueTangCellId" forIndexPath:indexPath];
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    
    if (self.ChildJiaoYuAry) {
        ParentXueTangModel *model = [self.ChildJiaoYuAry objectAtIndex:indexPath.row];
        cell.titleLabel.text = model.title;
        [cell.ShiPinListImg sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
        if (model.view > 9999) {
            CGFloat num = model.view / 10000;
            cell.liulanLabel.text = [NSString stringWithFormat:@"%.1f万人已看", num];
        } else {
            cell.liulanLabel.text = [NSString stringWithFormat:@"%ld人已看", model.view];
        }
//        cell.liulanLabel.text = [NSString stringWithFormat:@"%ld人已看", model.view];
        cell.jiShuLabel.text = [NSString stringWithFormat:@"%ld次", model.view];
        if (model.label.count == 0) {
            cell.biaoQianOneImg.alpha = 0;
            cell.biaoQianTwoImg.alpha = 0;
            cell.biaoQianThreeImg.alpha = 0;
            
            cell.biaoQianOneLabel.alpha = 0;
            cell.biaoQianTwoLabel.alpha = 0;
            cell.biaoQianThreeLabel.alpha = 0;
        } else if (model.label.count == 1) {
            cell.biaoQianOneImg.alpha = 1;
            cell.biaoQianTwoImg.alpha = 0;
            cell.biaoQianThreeImg.alpha = 0;
            
            cell.biaoQianOneLabel.alpha = 1;
            cell.biaoQianTwoLabel.alpha = 0;
            cell.biaoQianThreeLabel.alpha = 0;
            cell.biaoQianOneImg.image = [UIImage imageNamed:@"长的"];
            cell.biaoQianOneLabel.text = [model.label objectAtIndex:0];
            
        } else if (model.label.count == 2) {
            cell.biaoQianOneImg.alpha = 1;
            cell.biaoQianTwoImg.alpha = 1;
            cell.biaoQianThreeImg.alpha = 0;
            
            cell.biaoQianOneLabel.alpha = 1;
            cell.biaoQianTwoLabel.alpha = 1;
            cell.biaoQianThreeLabel.alpha = 0;
            cell.biaoQianOneImg.image = [UIImage imageNamed:@"长的"];
            cell.biaoQianOneLabel.text = [model.label objectAtIndex:0];
            cell.biaoQianTwoImg.image = [UIImage imageNamed:@"长的"];
            cell.biaoQianTwoLabel.text = [model.label objectAtIndex:1];
        } else if (model.label.count == 3) {
            cell.biaoQianOneImg.alpha = 1;
            cell.biaoQianTwoImg.alpha = 1;
            cell.biaoQianThreeImg.alpha = 1;
            
            cell.biaoQianOneLabel.alpha = 1;
            cell.biaoQianTwoLabel.alpha = 1;
            cell.biaoQianThreeLabel.alpha = 1;
            cell.biaoQianOneImg.image = [UIImage imageNamed:@"长的"];
            cell.biaoQianOneLabel.text = [model.label objectAtIndex:0];
            cell.biaoQianTwoImg.image = [UIImage imageNamed:@"长的"];
            cell.biaoQianTwoLabel.text = [model.label objectAtIndex:1];
            cell.biaoQianThreeImg.image = [UIImage imageNamed:@"长的"];
            cell.biaoQianThreeLabel.text = [model.label objectAtIndex:2];
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 112 + 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ParentXueTangDetailsViewController *parentXueTangDetailsVC = [[ParentXueTangDetailsViewController alloc] init];
    if (self.ChildJiaoYuAry.count != 0) {
        ParentXueTangModel *model = [self.ChildJiaoYuAry objectAtIndex:indexPath.row];
        parentXueTangDetailsVC.ParentXueTangDetailsId = model.ID;
    }
    [self.navigationController pushViewController:parentXueTangDetailsVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
