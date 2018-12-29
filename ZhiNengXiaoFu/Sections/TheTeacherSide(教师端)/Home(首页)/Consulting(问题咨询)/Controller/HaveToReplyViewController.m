//
//  HaveToReplyViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/28.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "HaveToReplyViewController.h"
#import "ConsultListModel.h"
#import "YiHuiFuCell.h"

@interface HaveToReplyViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray         *haveToReplyArr;
@property (nonatomic, strong) UITableView            *haveToReplyTableView;
@property (nonatomic, assign) NSInteger              page;
@property (nonatomic, strong) UIImageView            *zanwushuju;
@property (nonatomic, strong) PersonInformationModel *personInfo;

@end

@implementation HaveToReplyViewController

- (NSMutableArray *)haveToReplyArr {
    if (!_haveToReplyArr) {
        _haveToReplyArr = [NSMutableArray array];
    }
    return _haveToReplyArr;
}

- (void)viewWillAppear:(BOOL)animated {   //已回复
    [super viewWillAppear:animated];
    self.page = 1;
    //下拉刷新
    self.haveToReplyTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    //自动更改透明度
    self.haveToReplyTableView.mj_header.automaticallyChangeAlpha = YES;
    //进入刷新状态
    [self.haveToReplyTableView.mj_header beginRefreshing];
    //上拉刷新
    self.haveToReplyTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.zanwushuju = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 105 / 2, 200, 105, 111)];
    self.zanwushuju.image = [UIImage imageNamed:@"暂无数据家长端"];
    self.zanwushuju.alpha = 0;
    [self.haveToReplyTableView addSubview:self.zanwushuju];
    
    self.haveToReplyTableView.delegate = self;
    self.haveToReplyTableView.dataSource = self;
    
    [self.view addSubview:self.haveToReplyTableView];
    self.haveToReplyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.haveToReplyTableView registerNib:[UINib nibWithNibName:@"YiHuiFuCell" bundle:nil] forCellReuseIdentifier:@"YiHuiFuCellID"];
}

- (void)loadNewTopic {
    self.page = 1;
    [self.haveToReplyArr removeAllObjects];
    [self getConsultListURLData:self.page];
}

- (void)loadMoreTopic {
    self.page += 1;
    [self getConsultListURLData:self.page];
}

- (void)getConsultListURLData:(NSInteger)page {
    NSDictionary *dic = @{@"key":[UserManager key], @"status":@1,@"page":[NSString stringWithFormat:@"%ld",page]};
    [[HttpRequestManager sharedSingleton] POST:ConsultConsultList parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        //结束头部刷新
        [self.haveToReplyTableView.mj_header endRefreshing];
        //结束尾部刷新
        [self.haveToReplyTableView.mj_footer endRefreshing];
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            NSMutableArray *arr = [ConsultListModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            for (ConsultListModel *model in arr) {
                [self.haveToReplyArr addObject:model];
            }
            
            if (self.haveToReplyArr.count == 0) {
                self.zanwushuju.alpha = 1;
            } else {
                self.zanwushuju.alpha = 0;
                [self.haveToReplyTableView reloadData];
            }
            
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

- (UITableView *)haveToReplyTableView {
    if (!_haveToReplyTableView) {
        self.haveToReplyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_NAVH - 40) style:UITableViewStylePlain];
        self.haveToReplyTableView.backgroundColor = backColor;
        self.haveToReplyTableView.delegate = self;
        self.haveToReplyTableView.dataSource = self;
        _haveToReplyTableView.estimatedRowHeight = 0;
        _haveToReplyTableView.estimatedSectionHeaderHeight = 0;
        _haveToReplyTableView.estimatedSectionFooterHeight = 0;
    }
    return _haveToReplyTableView;
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
    return self.haveToReplyArr.count;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YiHuiFuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YiHuiFuCellID" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.haveToReplyArr.count != 0) {
        ConsultListModel *model = [self.haveToReplyArr objectAtIndex:indexPath.row];
        [cell.userIcon sd_setImageWithURL:[NSURL URLWithString:model.s_headimg] placeholderImage:[UIImage imageNamed:@"user"]];
        cell.userName.text = [NSString stringWithFormat:@"%@%@问:", model.class_name ,model.student_name];
        cell.questionLabel.text = model.question;
        [cell.userIconT sd_setImageWithURL:[NSURL URLWithString:model.t_headimg] placeholderImage:[UIImage imageNamed:@"user"]];
        cell.userNameT.text = [NSString stringWithFormat:@"%@%@老师%@回复:", model.class_name, model.course_name, model.teacher_name];
        cell.questionLabelT.text = model.answer;
    }
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger width = APP_WIDTH - 30;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    if (self.haveToReplyArr.count != 0) {
        ConsultListModel *model = [self.haveToReplyArr objectAtIndex:indexPath.row];
        CGSize size = [model.question boundingRectWithSize:CGSizeMake(width, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        CGSize size1 = [model.answer boundingRectWithSize:CGSizeMake(width, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        return 142 + size.height + size1.height + 10;
    } else {
        return 0;
    }
    
}


@end
