//
//  HelpCenterViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/25.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "HelpCenterViewController.h"

@interface HelpCenterViewController ()

@end

@implementation HelpCenterViewController

- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"帮助中心";
    self.view.backgroundColor = backColor;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:173/ 255.0 green:228 / 255.0 blue: 211 / 255.0 alpha:1];
    self.navigationController.navigationBar.translucent = NO;
    UIButton * rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(25, 10, 24, 24)];
    [rightBtn addTarget:self action:@selector(backItem:) forControlEvents:UIControlEventTouchDown];
    rightBtn.userInteractionEnabled = YES;
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
}

- (void)backItem:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
