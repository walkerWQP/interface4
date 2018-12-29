//
//  PersonInfomationViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/23.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "PersonInfomationViewController.h"
#import "PersonInfomationCell.h"
#import "PersonIconCell.h"
#import "PersonInformationModel.h"
#import "BindMobilePhoneViewController.h"
#import "ExitCell.h"


@interface PersonInfomationViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView            *personInfomationTableView;
@property (nonatomic, strong) NSMutableArray         *nameAry;
@property (nonatomic, strong) PersonInformationModel *personInfo;

@end

@implementation PersonInfomationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人资料";
    self.personInfomationTableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    self.nameAry = [NSMutableArray arrayWithObjects:@"头像",@"名字",@"手机", @"学生类型",@"账号", @"学校", @"所在班级", nil];
    [self.view addSubview:self.personInfomationTableView];
    [self.personInfomationTableView registerClass:[PersonInfomationCell class] forCellReuseIdentifier:@"PersonInfomationCellId"];
    [self.personInfomationTableView registerClass:[PersonIconCell class] forCellReuseIdentifier:@"PersonIconCellId"];
    [self.personInfomationTableView registerClass:[ExitCell class] forCellReuseIdentifier:@"ExitCellId"];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNetWork];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
}

- (void)setNetWork {
    NSDictionary *dic = @{@"key":[UserManager key]};
    [[HttpRequestManager sharedSingleton] POST:getUserInfoURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        self.personInfo = [PersonInformationModel mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
        [self.personInfomationTableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}


- (UITableView *)personInfomationTableView {
    if (!_personInfomationTableView) {
        self.personInfomationTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_NAVH) style:UITableViewStylePlain];
        self.personInfomationTableView.dataSource = self;
        self.personInfomationTableView.delegate = self;
    }
    return _personInfomationTableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.nameAry.count;
    } else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    } else {
        return 10;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    } else {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 10)];
        headerView.backgroundColor = backColor;
        return headerView;
    }
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            PersonIconCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonIconCellId" forIndexPath:indexPath];
            cell.nameLabel.text = @"头像";
            cell.selectionStyle =  UITableViewCellSelectionStyleNone;
            [cell.iConImg sd_setImageWithURL:[NSURL URLWithString:self.personInfo.head_img] placeholderImage:[UIImage imageNamed:@"user"]];
            return cell;
        } else {
            PersonInfomationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonInfomationCellId" forIndexPath:indexPath];
            if (self.nameAry.count != 0) {
                cell.nameLabel.text = [self.nameAry objectAtIndex:indexPath.row];
            }
            
            cell.selectionStyle =  UITableViewCellSelectionStyleNone;
            
            if (indexPath.row == 2) {
                cell.moreImg.alpha = 1;
                cell.newTitleLabel.alpha = 1;
                cell.titleLabel.alpha = 0;
                
                if (self.personInfo.mobile == nil || [self.personInfo.mobile isEqualToString:@""]) {
                    cell.newTitleLabel.text = @"请绑定手机号";
                } else {
                    NSString *numberString = [self.personInfo.mobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
                    cell.newTitleLabel.text = numberString;
                }
            } else {
                cell.moreImg.alpha = 0;
                cell.newTitleLabel.alpha = 0;
                cell.titleLabel.alpha = 1;
            }
            
            if (indexPath.row == 1) {
                cell.titleLabel.text = self.personInfo.name;
            } else if (indexPath.row == 2) {
                cell.titleLabel.text = self.personInfo.mobile;
                
            } else if (indexPath.row == 3) {
                if (self.personInfo.nature == 1) {
                    cell.titleLabel.text = @"走读生";
                } else {
                    cell.titleLabel.text = @"住校生";
                }
                
            } else if (indexPath.row == 4) {
                cell.titleLabel.text = self.personInfo.usernum;
                
            } else if (indexPath.row == 5) {
                cell.titleLabel.text = self.personInfo.school_name;
            } else if (indexPath.row == 6) {
                cell.titleLabel.text = self.personInfo.class_name_s;
            }
            return cell;
        }
    } else {
        ExitCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExitCellId" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.exitBtn addTarget:self action:@selector(exitBtn:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }

}

- (void)exitBtn : (UIButton *)sender {
    NSLog(@"点击退出");
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"确定要退出登录吗?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *alertT = [UIAlertAction actionWithTitle:@"退出登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击退出登录");
        [self tuichuLogin];
    }];
    UIAlertAction *alertF = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消");
    }];
    
    [actionSheet addAction:alertT];
    [actionSheet addAction:alertF];
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}

- (void)tuichuLogin {
    [UserManager logoOut];
    [WProgressHUD showSuccessfulAnimatedText:@"退出成功"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 70;
    } else {
        return 50;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"youkeState"] isEqualToString:@"1"]) {
            [WProgressHUD showErrorAnimatedText:@"游客不能进行此操作"];
        } else {
            BindMobilePhoneViewController *bingMoblie = [[BindMobilePhoneViewController alloc] init];
            if (self.personInfo.mobile == nil || [self.personInfo.mobile isEqualToString:@""]) {
                bingMoblie.typeStr = @"1";
            } else {
                bingMoblie.typeStr = @"2";
            }
            [self.navigationController pushViewController:bingMoblie animated:YES];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
