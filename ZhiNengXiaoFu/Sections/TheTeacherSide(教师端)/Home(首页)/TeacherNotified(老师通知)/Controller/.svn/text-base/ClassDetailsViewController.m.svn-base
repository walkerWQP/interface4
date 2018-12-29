//
//  ClassDetailsViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/26.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "ClassDetailsViewController.h"
#import "ClassDetailsTableViewCell.h"
#import "ClassDetailsModel.h"
#import "ClassNoticeViewController.h"
#import "TongZhiDetailsViewController.h"

@interface ClassDetailsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) NSInteger       page;
@property (nonatomic, strong) UIImageView     *zanwushuju;
@property (nonatomic, strong) NSMutableArray  *bannerArr;
@property (nonatomic, strong) NSMutableArray  *classDetailsArr;
@property (nonatomic, strong) UITableView     *classDetailsTableView;
@property (nonatomic, strong) UIImageView     *headImgView;

@end

@implementation ClassDetailsViewController

- (NSMutableArray *)bannerArr {
    if (!_bannerArr) {
        _bannerArr = [NSMutableArray array];
    }
    return _bannerArr;
}

- (NSMutableArray *)classDetailsArr {
    if (!_classDetailsArr) {
        _classDetailsArr = [NSMutableArray array];
    }
    return _classDetailsArr;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getBannersURLData];
    self.page  = 1;
    //下拉刷新
    self.classDetailsTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    //自动更改透明度
    self.classDetailsTableView.mj_header.automaticallyChangeAlpha = YES;
    //进入刷新状态
    [self.classDetailsTableView.mj_header beginRefreshing];
    //上拉刷新
    self.classDetailsTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleStr;
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [button setTitle:@"发布" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = titFont;
    [button addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self.view addSubview:self.classDetailsTableView];
    [self.classDetailsTableView registerClass:[ClassDetailsTableViewCell class] forCellReuseIdentifier:@"ClassDetailsTableViewCellID"];
    self.classDetailsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.zanwushuju = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 105 / 2, 200, 105, 111)];
    self.zanwushuju.image = [UIImage imageNamed:@"暂无数据家长端"];
    self.zanwushuju.alpha = 0;
    [self.classDetailsTableView addSubview:self.zanwushuju];
}

- (void)loadNewTopic {
    self.page = 1;
    [self.classDetailsArr removeAllObjects];
    [self getNoticeListData:self.page];
}

- (void)loadMoreTopic {
    self.page += 1;
    [self getNoticeListData:self.page];
}

- (void)getBannersURLData {
    NSDictionary *dic = @{@"key":[UserManager key],@"t_id":@"3"};
    [[HttpRequestManager sharedSingleton] POST:bannersURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            self.bannerArr = [BannerModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            if (self.bannerArr.count == 0) {
                self.headImgView.image = [UIImage imageNamed:@"教师端活动管理banner"];
            } else {
                BannerModel * model = [self.bannerArr objectAtIndex:0];
                [self.headImgView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"教师端活动管理banner"]];
                [self.classDetailsTableView reloadData];
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

- (void)getNoticeListData:(NSInteger)page {
    
    NSDictionary *dic = @{@"key":[UserManager key], @"page":[NSString stringWithFormat:@"%ld",page], @"is_school":@"0",@"class_id":self.ID};
    [[HttpRequestManager sharedSingleton] POST:noticeListURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        //结束头部刷新
        [self.classDetailsTableView.mj_header endRefreshing];
        //结束尾部刷新
        [self.classDetailsTableView.mj_footer endRefreshing];
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            NSMutableArray *arr = [ClassDetailsModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            for (ClassDetailsModel *model in arr) {
                [self.classDetailsArr addObject:model];
            }
            if (self.classDetailsArr.count == 0) {
                self.zanwushuju.alpha = 1;
            } else {
                self.zanwushuju.alpha = 0;
                [self.classDetailsTableView reloadData];
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

- (UITableView *)classDetailsTableView {
    if (!_classDetailsTableView) {
        self.classDetailsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_NAVH) style:UITableViewStylePlain];
        self.classDetailsTableView.backgroundColor = backColor;
        self.classDetailsTableView.delegate = self;
        self.classDetailsTableView.dataSource = self;
        self.classDetailsTableView.estimatedRowHeight = 0;
        self.classDetailsTableView.estimatedSectionHeaderHeight = 0;
        self.classDetailsTableView.estimatedSectionFooterHeight = 0;
    }
    return _classDetailsTableView;
}

//侧滑允许编辑cell
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return NO;
    }
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
                ClassDetailsModel * model = [self.classDetailsArr objectAtIndex:indexPath.row];
                [self.classDetailsArr removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                [self deleteNoticeURLForData:model.ID];
            }
            
        }];
        return @[deleteAction];
}

- (void)deleteNoticeURLForData:(NSString *)ID {
     NSDictionary *dic = @{@"key":[UserManager key],@"id":ID};
    [[HttpRequestManager sharedSingleton] POST:deleteNoticeURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            
            [WProgressHUD showSuccessfulAnimatedText:[responseObject objectForKey:@"msg"]];
            [self.classDetailsArr removeAllObjects];
            [self.classDetailsTableView reloadData];
            [self getNoticeListData:1];
            
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
    if (section == 0) {
        return 1;
    } else {
        return self.classDetailsArr.count;
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
        UIImageView * imgs = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 170)];
        
        if (self.bannerArr.count == 0) {
            
        } else {
            BannerModel *model = [self.bannerArr objectAtIndex:indexPath.row];
            if (model.img == nil) {
                imgs.image = [UIImage imageNamed:@"banner"];
            } else {
                [imgs sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"banner"]];
            }
        }
        [cell addSubview:imgs];
        return cell;
    } else {
        ClassDetailsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ClassDetailsTableViewCellID" forIndexPath:indexPath];
        if (self.classDetailsArr.count != 0) {
            ClassDetailsModel * model = [self.classDetailsArr objectAtIndex:indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if ([model.img isEqualToString:@""] || model.img == nil) {
                cell.headImgView.image = [UIImage imageNamed:@"老师通知占位符"];
            } else {
                [cell.headImgView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"老师通知占位符"]];
            }
            cell.titleLabel.text = model.title;
            cell.subjectsLabel.text = model.content;
            cell.timeLabel.text = model.create_time;
        }
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 170;
    } else {
        return 80;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NSLog(@"点击banner");
    } else {
        if (self.classDetailsArr.count != 0) {
            ClassDetailsModel *model = [self.classDetailsArr objectAtIndex:indexPath.row];
            TongZhiDetailsViewController *tongZhiDetailsVC = [[TongZhiDetailsViewController alloc] init];
            if (model.ID == nil) {
                [WProgressHUD showErrorAnimatedText:@"数据不正确,请重试"];
            } else {
                tongZhiDetailsVC.tongZhiId = model.ID;
                tongZhiDetailsVC.typeStr = @"1";
                [self.navigationController pushViewController:tongZhiDetailsVC animated:YES];
            }
        }
    }
}


- (void)rightBtn : (UIButton *)sender {
    ClassNoticeViewController *classNoticeVC = [[ClassNoticeViewController alloc] init];
    classNoticeVC.classID = self.ID;
    [self.navigationController pushViewController:classNoticeVC animated:YES];
}

@end
