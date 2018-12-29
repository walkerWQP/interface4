//
//  ManagementViewController.m
//  ZhiNengXiaoFu
//
//  Created by 独秀科技 on 2018/12/5.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "ManagementViewController.h"
#import "ReleasedVideoViewController.h"
#import "ManagementModel.h"
#import "ManagementCell.h"
#import "TeacherZaiXianDetailsViewController.h"

@interface ManagementViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIButton        *rightBtn;
@property (nonatomic, strong) NSMutableArray  *managementArr;
@property (nonatomic, strong) UITableView     *managementTableView;
@property (nonatomic, strong) UIImageView     *zanwushuju;
@property (nonatomic, assign) NSInteger       page;

@end

@implementation ManagementViewController

- (NSMutableArray *)managementArr {
    if (!_managementArr) {
        _managementArr = [NSMutableArray array];
    }
    return _managementArr;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.page = 1;
    //下拉刷新
    self.managementTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    //自动更改透明度
    self.managementTableView.mj_header.automaticallyChangeAlpha = YES;
    //进入刷新状态
    [self.managementTableView.mj_header beginRefreshing];
    //上拉刷新
    self.managementTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
}

- (void)loadNewTopic {
    self.page = 1;
    [self.managementArr removeAllObjects];
    [self getMyUploadURLData:self.page];
}

- (void)loadMoreTopic {
    self.page += 1;
    [self getMyUploadURLData:self.page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"视频管理";
    self.rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [self.rightBtn setTitle:@"上传" forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = titFont;
    [self.rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
    
    [self.view addSubview:self.managementTableView];
    [self.managementTableView registerClass:[ManagementCell class] forCellReuseIdentifier:@"ManagementCellId"];
    self.managementTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.zanwushuju = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 105 / 2, 200, 105, 111)];
    self.zanwushuju.image = [UIImage imageNamed:@"暂无数据家长端"];
    self.zanwushuju.alpha = 0;
    [self.managementTableView addSubview:self.zanwushuju];
    
}



//删除视频
- (void)DeleteVideoData:(NSString *)videoID {
    NSDictionary *dic = @{@"key":[UserManager key],@"id":videoID};
    [[HttpRequestManager sharedSingleton] POST:DeleteUploadURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            
            [WProgressHUD showSuccessfulAnimatedText:[responseObject objectForKey:@"msg"]];
            [self.managementArr removeAllObjects];
            [self.managementTableView reloadData];
            [self getMyUploadURLData:1];
            
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

- (void)getMyUploadURLData:(NSInteger)page {
    NSDictionary *dic = @{@"key":[UserManager key],@"page":[NSString stringWithFormat:@"%ld",page]};
    [[HttpRequestManager sharedSingleton] POST:MyUploadURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        //结束头部刷新
        [self.managementTableView.mj_header endRefreshing];
        //结束尾部刷新
        [self.managementTableView.mj_footer endRefreshing];
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            
            NSMutableArray *arr = [ManagementModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            for (ManagementModel *model in arr) {
                [self.managementArr addObject:model];
            }
            if (self.managementArr.count == 0) {
                self.zanwushuju.alpha = 1;
            } else {
                self.zanwushuju.alpha = 0;
                [self.managementTableView reloadData];
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


- (UITableView *)managementTableView {
    if (!_managementTableView) {
        self.managementTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_NAVH) style:UITableViewStylePlain];
        self.managementTableView.backgroundColor = backColor;
        self.managementTableView.delegate = self;
        self.managementTableView.dataSource = self;
    }
    return _managementTableView;
}

//侧滑允许编辑cell
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


#pragma Mark 左滑按钮 iOS8以上
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    //添加一个删除按钮
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"youkeState"] isEqualToString:@"1"]) {
            [WProgressHUD showErrorAnimatedText:@"游客不能进行此操作"];
        } else {
            //先删数据 再删UI
            ManagementModel *model = [self.managementArr objectAtIndex:indexPath.row];
            [self DeleteVideoData:model.ID];
            [self.managementArr removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }];
    return @[deleteAction];
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
    return self.managementArr.count;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ManagementCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ManagementCellId" forIndexPath:indexPath];
    if (self.managementArr.count != 0) {
        ManagementModel *model = [self.managementArr objectAtIndex:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.videoNameLabel.text = model.title;
        if (model.check == 1) {
            if (model.view > 9999) {
                CGFloat num = model.view / 10000;
                cell.numLabel.text = [NSString stringWithFormat:@"播放次数:%.1f万", num];
            } else {
                cell.numLabel.text = [NSString stringWithFormat:@"播放次数:%ld", model.view];
            }
        }
        cell.classLabel.text = [NSString stringWithFormat:@"%@·%@·%@",model.stage_name,model.grade_name,model.t_name];
        switch (model.check) {
            case 0:
                cell.auditLabel.text = @"审核状态:";
                cell.typeLabel.text = @"待审核";
                cell.typeLabel.textColor = RGB(215, 58, 85);
                break;
            case 1:
                cell.auditLabel.text = @"播放状态:";
                cell.typeLabel.text = @"已审核";
                cell.typeLabel.textColor = RGB(78, 190, 247);
                break;
            case 2:
                cell.auditLabel.text = @"审核状态:";
                cell.typeLabel.text = @"未通过";
                cell.typeLabel.textColor = RGB(215, 58, 85);
                break;
                
            default:
                break;
        }
        
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TeacherZaiXianDetailsViewController *teacherZaiXianDetailsVC = [TeacherZaiXianDetailsViewController new];
    if (self.managementArr.count != 0) {
        ManagementModel *model = [self.managementArr objectAtIndex:indexPath.row];
        teacherZaiXianDetailsVC.teacherZaiXianDetailsId = model.ID;
        [self.navigationController pushViewController:teacherZaiXianDetailsVC animated:YES];
    }
    
    
}

- (void)rightBtn:(UIButton *)sender {
    ReleasedVideoViewController *releasedVideoVC = [ReleasedVideoViewController new];
    [self.navigationController pushViewController:releasedVideoVC animated:YES];
}

@end
