//
//  LeaveDetailsViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/28.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "LeaveDetailsViewController.h"
#import "LeaveDetailsHeaderCell.h"
#import "LeaveDetailsDownCell.h"
#import "LeaveListModel.h"
#import "PersonInformationModel.h"

@interface LeaveDetailsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView            *leaveDetailsTableView;
@property (nonatomic, strong) LeaveListModel         *leaveListModel;
@property (nonatomic, strong) PersonInformationModel *model;

@end

@implementation LeaveDetailsViewController

-(void)viewWillAippear:(BOOL)animated {
    [super viewWillAppear:animated];
    //去除导航栏下方的横线
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"请假详情";
    self.leaveDetailsTableView.dataSource = self;
    self.leaveDetailsTableView.delegate = self;
    self.leaveDetailsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.leaveDetailsTableView];
    [self.leaveDetailsTableView registerClass:[LeaveDetailsHeaderCell class] forCellReuseIdentifier:@"LeaveDetailsHeaderCellId"];
    [self.leaveDetailsTableView registerNib:[UINib nibWithNibName:@"LeaveDetailsDownCell" bundle:nil] forCellReuseIdentifier:@"LeaveDetailsDownCellId"];
    NSUserDefaults *pushJudge = [NSUserDefaults standardUserDefaults];
    if([[pushJudge objectForKey:@"notify"]isEqualToString:@"push"]) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回拷贝"] style:UIBarButtonItemStylePlain target:self action:@selector(rebackToRootViewAction)];
        self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
        NSUserDefaults *pushJudge = [NSUserDefaults standardUserDefaults];
        [pushJudge setObject: @"" forKey:@"notify"];
        [pushJudge synchronize];//记得立即同步
        
    } else {
        
    }
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:tabBarColor] forBarMetrics:UIBarMetricsDefault];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回白"] style:UIBarButtonItemStyleDone target:self action:@selector(backButnClicked:)];
    self.navigationItem.leftBarButtonItem = back;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self setNetWork];
    [self setUser];
}

- (void)backButnClicked:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)rebackToRootViewAction {
    NSUserDefaults *pushJudge = [NSUserDefaults standardUserDefaults];
    [pushJudge setObject:@""forKey:@"notify"];
    [pushJudge synchronize];//记得立即同步
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setUser {
    NSDictionary *dic = @{@"key":[UserManager key]};
    [[HttpRequestManager sharedSingleton] POST:getUserInfoURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        self.model = [PersonInformationModel mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
        [self.leaveDetailsTableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)setNetWork {
    NSDictionary *dic = @{@"key":[UserManager key], @"id":self.leaveDetailsId};
    [[HttpRequestManager sharedSingleton] POST:leaveLeaveDetail parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            self.leaveListModel = [LeaveListModel mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
            [self.leaveDetailsTableView reloadData];
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

- (UITableView *)leaveDetailsTableView {
    if (!_leaveDetailsTableView) {
        self.leaveDetailsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_NAVH)];
        self.leaveDetailsTableView.backgroundColor = backColor;
        self.leaveDetailsTableView.dataSource = self;
        self.leaveDetailsTableView.delegate = self;
    }
    return _leaveDetailsTableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        LeaveDetailsHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeaveDetailsHeaderCellId" forIndexPath:indexPath];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        cell.StartLabel.text = self.leaveListModel.start;
        cell.EndLabel.text = self.leaveListModel.end;
        [cell.userIconImg sd_setImageWithURL:[NSURL URLWithString:self.model.head_img] placeholderImage:[UIImage imageNamed:@"user"]];
        cell.userNameLabel.text = self.model.name;
        return cell;
    } else {
        LeaveDetailsDownCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeaveDetailsDownCellId" forIndexPath:indexPath];
        if (self.leaveListModel.status == 1) {
            cell.LeaveDetailsDownShenHeState.text = @"已批准";
            cell.LeaveDetailsDownShenHeState.textColor = tabBarColor;
        } else {
            cell.LeaveDetailsDownShenHeState.text = @"审核中";
            cell.LeaveDetailsDownShenHeState.textColor = RGB(218, 23, 55);
        }
        cell.LeaveDetailsDownLeaveSeason.text = self.leaveListModel.reason;
        cell.LeaveDetailsDownBeiZhu.text = self.leaveListModel.remark;
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
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
        return 210;
    } else {
        return 410;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
