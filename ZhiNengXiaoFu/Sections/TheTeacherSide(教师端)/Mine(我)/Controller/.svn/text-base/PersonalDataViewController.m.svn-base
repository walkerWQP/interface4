//
//  PersonalDataViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/24.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "PersonalDataViewController.h"
#import "PersonInfomationCell.h"
#import "PersonIconCell.h"
#import "BindMobilePhoneViewController.h"
#import "ExitCell.h"

@interface PersonalDataViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView            *personalDataTableView;
@property (nonatomic, strong) NSMutableArray         *nameArr;
@property (nonatomic, strong) PersonInformationModel *personInfo;

@end

@implementation PersonalDataViewController


- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = NO;
    [super viewWillAppear:animated];
    [self setUser];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人资料";
    self.view.backgroundColor = backColor;
    self.personalDataTableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    self.nameArr = [NSMutableArray arrayWithObjects:@"头像",@"姓名",@"手机", @"账号", @"学校", nil];
    [self.view addSubview:self.personalDataTableView];
    [self.personalDataTableView registerClass:[PersonInfomationCell class] forCellReuseIdentifier:@"PersonInfomationCellId"];
    [self.personalDataTableView registerClass:[PersonIconCell class] forCellReuseIdentifier:@"PersonIconCellId"];
    [self.personalDataTableView registerClass:[ExitCell class] forCellReuseIdentifier:@"ExitCellId"];
}

- (void)setUser {
    NSDictionary * dic = @{@"key":[UserManager key]};
    [[HttpRequestManager sharedSingleton] POST:getUserInfoURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        self.personInfo = [PersonInformationModel mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
        [self.personalDataTableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}


- (UITableView *)personalDataTableView {
    if (!_personalDataTableView) {
        self.personalDataTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_NAVH) style:UITableViewStylePlain];
        self.personalDataTableView.backgroundColor = backColor;
        self.personalDataTableView.dataSource = self;
        self.personalDataTableView.delegate = self;
        self.personalDataTableView.separatorStyle = UITableViewCellEditingStyleNone;
    }
    return _personalDataTableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.nameArr.count;
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
        UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 10)];
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
            PersonIconCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PersonIconCellId" forIndexPath:indexPath];
            cell.nameLabel.text = @"头像";
            cell.selectionStyle =  UITableViewCellSelectionStyleNone;
            if (self.personInfo.head_img == nil) {
                cell.iConImg.image = [UIImage imageNamed:@"user"];
            } else {
                [cell.iConImg sd_setImageWithURL:[NSURL URLWithString:self.personInfo.head_img] placeholderImage:[UIImage imageNamed:@"user"]];
            }
            return cell;
        }  else {
            PersonInfomationCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PersonInfomationCellId" forIndexPath:indexPath];
            if (self.nameArr.count != 0) {
                cell.nameLabel.text = [self.nameArr objectAtIndex:indexPath.row];
            }
            
            cell.selectionStyle =  UITableViewCellSelectionStyleNone;
            if (indexPath.row == 2) {
                cell.moreImg.alpha = 1;
                cell.newTitleLabel.alpha = 1;
                cell.titleLabel.alpha = 0;
            } else {
                cell.moreImg.alpha = 0;
                cell.newTitleLabel.alpha = 0;
                cell.titleLabel.alpha = 1;
            }
            if (indexPath.row == 1) {
                cell.titleLabel.text = self.personInfo.name;
            } else if (indexPath.row == 2) {
                if (self.personInfo.mobile == nil || [self.personInfo.mobile isEqualToString:@""]) {
                    cell.newTitleLabel.text = @"请绑定手机号";
                } else {
                    NSString *numberString = [self.personInfo.mobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
                    cell.newTitleLabel.text = numberString;
                }
                
            } else if (indexPath.row == 3) {
                cell.titleLabel.text = self.personInfo.usernum;
            } else if (indexPath.row == 4) {
                cell.titleLabel.text = self.personInfo.school_name;
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



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
        {
            NSLog(@"头像");
        }
            break;
        case 1:
        {
            NSLog(@"姓名");
        }
            break;
        case 2:
        {
            NSLog(@"手机号");
            
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
            break;
        case 3:
        {
            NSLog(@"账号");
        }
            break;
        case 4:
        {
            NSLog(@"学校");
        }
            break;
            
        default:
            break;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 70;
    } else {
        return 50;
    }
}



@end
