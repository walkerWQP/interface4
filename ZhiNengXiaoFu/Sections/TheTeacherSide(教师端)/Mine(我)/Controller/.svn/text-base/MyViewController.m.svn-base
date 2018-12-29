//
//  MyViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/23.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "MyViewController.h"
#import "ExitCell.h"
#import "MyInformationCell.h"
#import "HomeworkCell.h"
#import "PersonalDataViewController.h"
#import "HelperCenterViewController.h"
#import "LoginHomePageViewController.h"
#import "OffTheListViewController.h"
#import "ChangePasswordViewController.h"
#import "OngoingTableViewController.h"
#import "PersonInformationModel.h"
#import "SleepManagementViewController.h"
#import "BindMobilePhoneViewController.h"
#import "OngoingTableViewController.h"
#import "AdviceFeedbackViewController.h"
#import "HelperCenterModel.h"
#import "NewDynamicsViewController.h"

@interface MyViewController ()<UIAlertViewDelegate>

@property (nonatomic, strong) NSMutableArray         *myArr;
@property (nonatomic, strong) PersonInformationModel *model;
@property (nonatomic, strong) HelperCenterModel      *helperCenterModel;
@property (nonatomic, strong) UIView                 *back;
@property (nonatomic, strong) UIWebView              *webView;
@property (nonatomic, strong) UILabel                *nameLabel;
@property (nonatomic, strong) UIImageView            *iconImg;
@property (nonatomic, strong)  UIImageView           *touxiangIcon;
@property (nonatomic, strong) NSMutableArray         *iconAry;
@property (nonatomic, strong) NSMutableArray         *titleAry;
@property (nonatomic, strong)  UIView                *bottom;

@end

@implementation MyViewController

- (NSMutableArray *)myArr {
    if (!_myArr) {
        _myArr = [NSMutableArray array];
    }
    return _myArr;
}

- (NSMutableArray *)iconAry {
    if (!_iconAry) {
        self.iconAry = [@[]mutableCopy];
    }
    return _iconAry;
}

- (NSMutableArray *)titleAry {
    if (!_titleAry) {
        self.titleAry = [@[]mutableCopy];
    }
    return _titleAry;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backColor;
    self.title = @"我的";
    [self setUser];
    [self setNetWorkNew];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView * header = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth * 226 / 375)];
    header.image = [UIImage imageNamed:@"背景图我的"];
    [self.view addSubview:header];
    
    UIImageView * whiteImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 54 + APP_NAVH, kScreenWidth - 30, (kScreenWidth - 30) * 109 / 345 + 20)];
    whiteImg.image = [UIImage imageNamed:@"头像底"];
    [self.view addSubview:whiteImg];
    
    UIButton * person = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 7.5 - 25, APP_NAVH - 30 - 5, 15, 18)];
    [person setBackgroundImage:[UIImage imageNamed:@"个人信息"] forState:UIControlStateNormal];
    [person addTarget:self action:@selector(person:) forControlEvents:UIControlEventTouchDown];
    person.userInteractionEnabled = YES;
    [self.view addSubview:person];
    
    UILabel * my = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 30, APP_NAVH - 30, 60, 22)];
    my.text = @"我的";
    my.textColor = [UIColor whiteColor];
    my.textAlignment = NSTextAlignmentCenter;
    my.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:18];
    [self.view addSubview:my];
    
    self.touxiangIcon  = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 62, APP_NAVH + 9, 124, 124)];
    self.touxiangIcon.image = [UIImage imageNamed:@"头像"];
    [self.view addSubview:self.touxiangIcon];
    
    self.iconImg = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 50, 12 + APP_NAVH + 9, 100, 100)];
    self.iconImg.layer.cornerRadius = 50;
    self.iconImg.layer.masksToBounds = YES;
    [self.view addSubview:self.iconImg];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.textColor = RGB(51, 51, 51);
    self.nameLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:self.nameLabel];
    
    self.bottom = [[UIView alloc] initWithFrame:CGRectMake(0, whiteImg.frame.origin.y + whiteImg.frame.size.height + 10, kScreenWidth, 249)];
    self.bottom.userInteractionEnabled = YES;
    [self.view addSubview:self.bottom];
    
    NSInteger width = (kScreenWidth - 60) / 3;
    UIView * hengOneView = [[UIView alloc] initWithFrame:CGRectMake(30 + width, 0, 1, 248)];
    hengOneView.backgroundColor = RGBA(186, 186, 186, 0.2);
    [self.bottom addSubview:hengOneView];
    
    UIView * hengTwoView = [[UIView alloc] initWithFrame:CGRectMake(30 + width * 2, 0, 1, 248)];
    hengTwoView.backgroundColor = RGBA(186, 186, 186, 0.2);
    [self.bottom addSubview:hengTwoView];
    
    UIView * shuOneView = [[UIView alloc] initWithFrame:CGRectMake(30, 83, self.bottom.frame.size.width - 60, 1)];
    shuOneView.backgroundColor = RGBA(186, 186, 186, 0.2);
    [self.bottom addSubview:shuOneView];
    
    UIView * shuTwoView = [[UIView alloc] initWithFrame:CGRectMake(30, 83 * 2, self.bottom.frame.size.width- 60, 1)];
    shuTwoView.backgroundColor = RGBA(186, 186, 186, 0.2);
    [self.bottom addSubview:shuTwoView];
    self.navigationController.navigationBar.translucent = YES;

}

- (void)setUser {
    NSDictionary * dic = @{@"key":[UserManager key]};
    [WProgressHUD showHUDShowText:@"加载中..."];
    [[HttpRequestManager sharedSingleton] POST:getUserInfoURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        [WProgressHUD hideAllHUDAnimated:YES];
        self.model = [PersonInformationModel mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
        self.nameLabel.text = self.model.name;
        CGSize size = [self.nameLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.nameLabel.font,NSFontAttributeName,nil]];
        CGFloat JGlabelContentWidth = size.width;
        // 如果label的内容的宽度度超过150，则label的宽度就设置为150，即label的最大宽度为150
        if (JGlabelContentWidth >= 230) {
            JGlabelContentWidth = 230;
        }
        self.nameLabel.frame =  CGRectMake(kScreenWidth / 2 - JGlabelContentWidth / 2 ,self.touxiangIcon.frame.size.height + self.touxiangIcon.frame.origin.y + 10, JGlabelContentWidth, 16);

        [self.iconImg sd_setImageWithURL:[NSURL URLWithString:self.model.head_img] placeholderImage:[UIImage imageNamed:@"user"]];
        if (self.model.is_adviser == 1 && self.model.dorm_open == 1) {
            NSMutableArray * imgAry = [NSMutableArray arrayWithObjects:@"请假列表新",@"已发活动新",@"就寝管理新",@"修改密码新",@"绑定手机新",@"联系我们新",@"关注我们新",@"建议反馈新", nil];
            NSMutableArray * TitleAry = [NSMutableArray arrayWithObjects:@"请假管理",@"已发活动",@"就寝管理",@"修改密码",@"绑定手机",@"联系我们",@"关注我们",@"建议反馈", nil];
            for (int i = 0; i < imgAry.count; i++) {
                NSString * img  = [imgAry objectAtIndex:i];
                NSString * title = [TitleAry objectAtIndex:i];
                NSDictionary * dic = @{@"img":img, @"title":title};
                [self.myArr  addObject:dic];
            }
            
            NSInteger width = (kScreenWidth - 60) / 3;
            for (int i = 0; i < self.myArr .count; i++) {
                NSDictionary * dic = [self.myArr  objectAtIndex:i];
                UIView * itemView = [[UIView alloc] initWithFrame:CGRectMake(30 + width *  (i %3), 0 + 83 * (i / 3), width, 83)];
                [self.bottom addSubview:itemView];
                itemView.tag = i;
                
                UITapGestureRecognizer * itmeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itmeTap:)];
                itemView.userInteractionEnabled = YES;
                [itemView addGestureRecognizer:itmeTap];
                
                UIImageView * itemImg = [[UIImageView alloc] initWithFrame:CGRectMake(itemView.frame.size.width / 2 - 15, 20, 30, 30)];
                itemImg.image = [UIImage imageNamed:[dic objectForKey:@"img"]];
                [itemView addSubview:itemImg];
                
                UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(itemView.frame.size.width / 2 - 30, itemImg.frame.origin.y + itemImg.frame.size.height + 10, 60, 15)];
                nameLabel.textColor = RGB(51, 51, 51);
                nameLabel.textAlignment = NSTextAlignmentCenter;
                nameLabel.font = [UIFont systemFontOfSize:13];
                nameLabel.text = [dic objectForKey:@"title"];
                [itemView addSubview:nameLabel];
            }
        } else {
            NSMutableArray * imgAry = [NSMutableArray arrayWithObjects:@"请假列表新",@"已发活动新",@"修改密码新",@"绑定手机新",@"联系我们新",@"关注我们新",@"建议反馈新", nil];
            NSMutableArray * TitleAry = [NSMutableArray arrayWithObjects:@"请假管理",@"已发活动",@"修改密码",@"绑定手机",@"联系我们",@"关注我们",@"建议反馈", nil];
            
            for (int i = 0; i < imgAry.count; i++) {
                NSString * img  = [imgAry objectAtIndex:i];
                NSString * title = [TitleAry objectAtIndex:i];
                NSDictionary * dic = @{@"img":img, @"title":title};
                [self.myArr  addObject:dic];
            }
            
            NSInteger width = (kScreenWidth - 60) / 3;
            for (int i = 0; i < self.myArr .count; i++) {
                NSDictionary * dic = [self.myArr  objectAtIndex:i];
                UIView * itemView = [[UIView alloc] initWithFrame:CGRectMake(30 + width *  (i % 3), 0 + 83 * (i / 3), width, 83)];
                [self.bottom addSubview:itemView];
                
                itemView.tag = i;
            
                UITapGestureRecognizer * itmeTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itmeTap1:)];
                itemView.userInteractionEnabled = YES;
                [itemView addGestureRecognizer:itmeTap1];
                
                UIImageView * itemImg = [[UIImageView alloc] initWithFrame:CGRectMake(itemView.frame.size.width / 2 - 15, 20, 30, 30)];
                itemImg.image = [UIImage imageNamed:[dic objectForKey:@"img"]];
                [itemView addSubview:itemImg];
                
                UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(itemView.frame.size.width / 2 - 30, itemImg.frame.origin.y + itemImg.frame.size.height + 10, 60, 15)];
                nameLabel.textColor = RGB(51, 51, 51);
                nameLabel.font = [UIFont systemFontOfSize:13];
                nameLabel.textAlignment = NSTextAlignmentCenter;

                nameLabel.text = [dic objectForKey:@"title"];
                [itemView addSubview:nameLabel];
            }
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}




- (void)person:(UIButton *)sender {
    PersonalDataViewController *personalDataVC = [[PersonalDataViewController alloc] init];
    [self.navigationController pushViewController:personalDataVC animated:YES];
}

#pragma mark ======= 就寝管理 =======
- (void)itmeTap:(UITapGestureRecognizer *)sender {
    switch (sender.view.tag) {
        case 0:
        {
            NSLog(@"请假列表");
            OffTheListViewController *offTheListVC = [OffTheListViewController new];
            [self.navigationController pushViewController:offTheListVC animated:YES];
        }
            break;
        case 1:
        {
            NSLog(@"已发活动");
            OngoingTableViewController *ongoingTableVC = [OngoingTableViewController new];
            [self.navigationController pushViewController:ongoingTableVC animated:YES];
        }
            break;
        case 2:
        {
            NSLog(@"点击就寝管理");
            SleepManagementViewController * sleepManagementVC = [[SleepManagementViewController alloc] init];
            [self.navigationController pushViewController:sleepManagementVC animated:YES];
        }
            break;
        case 3:
        {
            NSLog(@"修改密码");
            ChangePasswordViewController *changePasswordVC = [ChangePasswordViewController new];
            [self.navigationController pushViewController:changePasswordVC animated:YES];
        }
            break;
        case 4:
        {
            NSLog(@"绑定手机");
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"youkeState"] isEqualToString:@"1"]) {
                [WProgressHUD showErrorAnimatedText:@"游客不能进行此操作"];
                
            } else {
                BindMobilePhoneViewController *bingMoblie = [[BindMobilePhoneViewController alloc] init];
                if (self.model.mobile == nil || [self.model.mobile isEqualToString:@""]) {
                    bingMoblie.typeStr = @"1";
                } else {
                    bingMoblie.typeStr = @"2";
                }
                
                [self.navigationController pushViewController:bingMoblie animated:YES];
            }
        }
            break;
        case 5:
        {
            NSLog(@"联系我们");
            if (_webView == nil) {
                _webView = [[UIWebView alloc] initWithFrame:CGRectZero];
            }
            [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", self.helperCenterModel.phone]]]];
        }
            break;
        case 6:
        {
            NSLog(@"关注我们");
            self.back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT)];
            self.back.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:0.8];
            [[[UIApplication sharedApplication] keyWindow] addSubview:self.back];
            
            UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(APP_WIDTH / 2 - 100, APP_HEIGHT / 2 - 100, 200, 200)];
            [img sd_setImageWithURL:[NSURL URLWithString:self.helperCenterModel.wx] placeholderImage:nil];
            [self.back addSubview:img];
            
            UITapGestureRecognizer * imgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTap:)];
            self.back.userInteractionEnabled = YES;
            [self.back addGestureRecognizer:imgTap];
        }
            break;
        case 7:
        {
            NSLog(@"建议反馈");
            AdviceFeedbackViewController *adviceFeedbackVC = [AdviceFeedbackViewController new];
            [self.navigationController pushViewController:adviceFeedbackVC animated:YES];
        }
            break;
       
        default:
            break;
    }
}

#pragma mark ======= 无就寝管理 =======
- (void)itmeTap1:(UITapGestureRecognizer *)sender {
    switch (sender.view.tag) {
        case 0:
        {
            OffTheListViewController *offTheListVC = [OffTheListViewController new];
            [self.navigationController pushViewController:offTheListVC animated:YES];
        }
            break;
        case 1:
        {
            OngoingTableViewController *ongoingTableVC = [OngoingTableViewController new];
            [self.navigationController pushViewController:ongoingTableVC animated:YES];
        }
            break;
        case 2:
        {
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"youkeState"] isEqualToString:@"1"]) {
                [WProgressHUD showErrorAnimatedText:@"游客不能进行此操作"];
            } else {
                NSLog(@"修改密码");
                ChangePasswordViewController *changePasswordVC = [[ChangePasswordViewController alloc] init];
                [self.navigationController pushViewController:changePasswordVC animated:YES];
            }
        }
            break;
        case 3:
        {
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"youkeState"] isEqualToString:@"1"]) {
                [WProgressHUD showErrorAnimatedText:@"游客不能进行此操作"];
                
            } else {
                BindMobilePhoneViewController *bingMoblie = [[BindMobilePhoneViewController alloc] init];
                if (self.model.mobile == nil || [self.model.mobile isEqualToString:@""]) {
                    bingMoblie.typeStr = @"1";
                } else {
                    bingMoblie.typeStr = @"2";
                }
                
                [self.navigationController pushViewController:bingMoblie animated:YES];
            }
        }
            break;
        case 4:
        {
            NSLog(@"拨打电话");
            if (_webView == nil) {
                _webView = [[UIWebView alloc] initWithFrame:CGRectZero];
            }
            [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", self.helperCenterModel.phone]]]];
        }
            break;
        case 5:
        {
            self.back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT)];
            self.back.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:0.8];
            [[[UIApplication sharedApplication] keyWindow] addSubview:self.back];
            
            UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(APP_WIDTH / 2 - 100, APP_HEIGHT / 2 - 100, 200, 200)];
            [img sd_setImageWithURL:[NSURL URLWithString:self.helperCenterModel.wx] placeholderImage:nil];
            [self.back addSubview:img];
            
            UITapGestureRecognizer * imgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTap:)];
            self.back.userInteractionEnabled = YES;
            [self.back addGestureRecognizer:imgTap];
        }
            break;
        case 6:
        {
            AdviceFeedbackViewController *adviceFeedbackVC = [AdviceFeedbackViewController new];
            [self.navigationController pushViewController:adviceFeedbackVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (void)imgTap:(UITapGestureRecognizer *)sender {
    [self.back removeFromSuperview];
}

- (void)setNetWorkNew {
    NSDictionary * dic = @{@"key":[UserManager key]};
    [[HttpRequestManager sharedSingleton] POST:userContactUs parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            self.helperCenterModel = [HelperCenterModel mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
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




@end
