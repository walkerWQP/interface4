//
//  DidNotReturnViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/28.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "DidNotReturnViewController.h"
#import "ConsultListModel.h"
#import "ReplyViewController.h"
#import "WeiHuiFuCell.h"


@interface DidNotReturnViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray         *didNotReturnArr;
@property (nonatomic, strong) UITableView            *didNotReturnTableView;
@property (nonatomic, assign) NSInteger              page;
@property (nonatomic, strong) UIImageView            *zanwushuju;
@property (nonatomic, strong) PersonInformationModel *personInfo;
@property (nonatomic, assign) NSInteger              typeID;


@end

@implementation DidNotReturnViewController

- (NSMutableArray *)didNotReturnArr {
    if (!_didNotReturnArr) {
        _didNotReturnArr = [NSMutableArray array];
    }
    return _didNotReturnArr;
}

- (void)viewWillAppear:(BOOL)animated {   //未回复
    [super viewWillAppear:animated];
    self.page = 1;
    //下拉刷新
    self.didNotReturnTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    //自动更改透明度
    self.didNotReturnTableView.mj_header.automaticallyChangeAlpha = YES;
    //进入刷新状态
    [self.didNotReturnTableView.mj_header beginRefreshing];
    //上拉刷新
    self.didNotReturnTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.zanwushuju = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 105 / 2, 200, 105, 111)];
    self.zanwushuju.image = [UIImage imageNamed:@"暂无数据家长端"];
    self.zanwushuju.alpha = 0;
    [self.didNotReturnTableView addSubview:self.zanwushuju];
    
    self.didNotReturnTableView.delegate = self;
    self.didNotReturnTableView.dataSource = self;
    
    [self.view addSubview:self.didNotReturnTableView];
    self.didNotReturnTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.didNotReturnTableView registerNib:[UINib nibWithNibName:@"WeiHuiFuCell" bundle:nil] forCellReuseIdentifier:@"WeiHuiFuCellID"];
}

- (void)loadNewTopic {
    self.page = 1;
    [self.didNotReturnArr removeAllObjects];
    [self getConsultConsultListURLData:self.page];
}

- (void)loadMoreTopic {
    self.page += 1;
    [self getConsultConsultListURLData:self.page];
}

- (void)getConsultConsultListURLData :(NSInteger )page {
    NSDictionary *dic = @{@"key":[UserManager key], @"status":@0,@"page":[NSString stringWithFormat:@"%ld",page]};
    [[HttpRequestManager sharedSingleton] POST:ConsultConsultList parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        //结束头部刷新
        [self.didNotReturnTableView.mj_header endRefreshing];
        //结束尾部刷新
        [self.didNotReturnTableView.mj_footer endRefreshing];
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            NSMutableArray *arr = [ConsultListModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            for (ConsultListModel *model in arr) {
                [self.didNotReturnArr addObject:model];
            }
            if (self.didNotReturnArr.count == 0) {
                [self.didNotReturnArr removeAllObjects];
                self.zanwushuju.alpha = 1;
                [self.didNotReturnTableView reloadData];
            } else {
                self.zanwushuju.alpha = 0;
                [self.didNotReturnTableView reloadData];
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



- (UITableView *)didNotReturnTableView {
    if (!_didNotReturnTableView) {
        self.didNotReturnTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_NAVH - 40) style:UITableViewStylePlain];
        self.didNotReturnTableView.backgroundColor = backColor;
        self.didNotReturnTableView.delegate = self;
        self.didNotReturnTableView.dataSource = self;
        _didNotReturnTableView.estimatedRowHeight = 0;
        _didNotReturnTableView.estimatedSectionHeaderHeight = 0;
        _didNotReturnTableView.estimatedSectionFooterHeight = 0;
    }
    return _didNotReturnTableView;
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
    return self.didNotReturnArr.count;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WeiHuiFuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeiHuiFuCellID" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.didNotReturnArr.count != 0) {
        ConsultListModel *model = [self.didNotReturnArr objectAtIndex:indexPath.row];
        [cell.WeiHuiFuUserIconImg sd_setImageWithURL:[NSURL URLWithString:model.s_headimg] placeholderImage:[UIImage imageNamed:@"user"]];
        cell.WeiHuiFuNameLabel.text = [NSString stringWithFormat:@"%@%@问%@(%@):", model.class_name ,model.student_name, model.teacher_name, model.course_name];
        cell.WeiHuiFuQuestionLabel.text = model.question;
        //
        cell.WeiHuiFuBtn.backgroundColor = RGB(0, 186, 255);
        cell.WeiHuiFuBtn.layer.masksToBounds = YES;
        cell.WeiHuiFuBtn.layer.cornerRadius  = 5;
        UIButton *deviceImageButton = cell.WeiHuiFuBtn;
        [deviceImageButton setTitle:@"回答咨询" forState:UIControlStateNormal];
        deviceImageButton.backgroundColor = RGB(0, 186, 255);
        [deviceImageButton addTarget:self action:@selector(answerBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger width = APP_WIDTH - 30;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    if (self.didNotReturnArr.count != 0) {
        ConsultListModel *model = [self.didNotReturnArr objectAtIndex:indexPath.row];
        CGSize size = [model.question boundingRectWithSize:CGSizeMake(width, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        return 130 + size.height - 5;
    } else {
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.didNotReturnArr.count != 0) {
        ConsultListModel *model = [self.didNotReturnArr objectAtIndex:indexPath.row];
        ReplyViewController *replyVC = [[ReplyViewController alloc] init];
        if (model.ID == nil) {
            [WProgressHUD showErrorAnimatedText:@"数据不正确,请重试"];
        } else {
            replyVC.ID = model.ID;
            replyVC.headImg = model.s_headimg;
            replyVC.nameStr = [NSString stringWithFormat:@"%@%@问:",model.class_name,model.student_name];
            replyVC.problemStr =  model.question;
            [self.navigationController pushViewController:replyVC animated:YES];
        }
    }
    
}











- (void)answerBtn : (UIButton *)sender {
    NSLog(@"点击回答咨询");
    UIView *v = [sender superview];//获取父类view
    WeiHuiFuCell *cell = (WeiHuiFuCell *)[v superview];//获取cell
    NSIndexPath *indexpath = [self.didNotReturnTableView indexPathForCell:cell];//获取cell对应的indexpath;
    if (self.didNotReturnArr.count != 0) {
        ConsultListModel *model = [self.didNotReturnArr objectAtIndex:indexpath.row];
        ReplyViewController *replyVC = [[ReplyViewController alloc] init];
        if (model.ID == nil) {
            [WProgressHUD showErrorAnimatedText:@"数据不正确,请重试"];
        } else {
            replyVC.ID = model.ID;
            replyVC.headImg = model.s_headimg;
            replyVC.nameStr = [NSString stringWithFormat:@"%@%@问:",model.class_name,model.student_name];
            replyVC.problemStr =  model.question;
            [self.navigationController pushViewController:replyVC animated:YES];
        }
    }
}




@end
