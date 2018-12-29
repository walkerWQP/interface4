//
//  CompetitiveActivityViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/25.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "CompetitiveActivityViewController.h"
#import "HuoDongIngViewController.h"
#import "HuoDongYiJieShuViewController.h"
#import "HuoDongWeiKaiShiViewController.h"

@interface CompetitiveActivityViewController ()

@property (nonatomic,strong) JohnTopTitleView *titleView;

@end

@implementation CompetitiveActivityViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"竞技活动";
    self.view.backgroundColor = COLOR(246, 246, 246, 1);
    [self makeActivityManagementViewControllerUI];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
}


- (void)makeActivityManagementViewControllerUI {
    NSArray *titleArray = [NSArray arrayWithObjects:@"正在进行",@"未开始", @"已结束",nil];
    self.titleView.title = titleArray;
    [self.titleView setupViewControllerWithFatherVC:self childVC:[self setChildVC]];
    [self.view addSubview:self.titleView];
    
}

- (NSArray <UIViewController *>*)setChildVC{
    //正在进行
    HuoDongIngViewController *ongoingVC = [[HuoDongIngViewController alloc]init];
    //未开始
    HuoDongWeiKaiShiViewController *isAboutToBeginVC = [[HuoDongWeiKaiShiViewController alloc]init];
    //明日预告
    HuoDongYiJieShuViewController *tomorrowVC = [[HuoDongYiJieShuViewController alloc]init];
    NSArray *childVC = [NSArray arrayWithObjects:ongoingVC,isAboutToBeginVC,tomorrowVC, nil];
    return childVC;
}

- (JohnTopTitleView *)titleView{
    if (!_titleView) {
        _titleView = [[JohnTopTitleView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    }
    return _titleView;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
