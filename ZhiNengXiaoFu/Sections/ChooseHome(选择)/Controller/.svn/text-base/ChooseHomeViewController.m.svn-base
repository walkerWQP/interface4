//
//  ChooseHomeViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/23.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "ChooseHomeViewController.h"
#import "PrefixHeader.pch"
#import "LoginHomePageViewController.h"
@interface ChooseHomeViewController ()

@property (nonatomic, strong) UIButton *teachaerBtn;
@property (nonatomic, strong) UIButton *ParentBtn;

@end

@implementation ChooseHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.teachaerBtn = [[UIButton alloc] initWithFrame:CGRectMake(APP_WIDTH / 2 - 100, 150, 200, 50)];
    [self.teachaerBtn setTitle:@"教师端" forState:UIControlStateNormal];
    [self.teachaerBtn setBackgroundColor:COLOR(173, 228, 211, 1)];
    [self.view addSubview:_teachaerBtn];
    [self.teachaerBtn addTarget:self action:@selector(teachaerBtn:) forControlEvents:UIControlEventTouchDown];
    self.teachaerBtn.userInteractionEnabled = YES;
    
    self.ParentBtn = [[UIButton alloc] initWithFrame:CGRectMake(APP_WIDTH / 2 - 100, 300, 200, 50)];
    [self.ParentBtn setTitle:@"家长端" forState:UIControlStateNormal];
    [self.ParentBtn setBackgroundColor:COLOR(173, 228, 211, 1)];
    [self.view addSubview:self.ParentBtn];
    [self.ParentBtn addTarget:self action:@selector(ParentBtn:) forControlEvents:UIControlEventTouchDown];
    self.ParentBtn.userInteractionEnabled = YES;
}

- (void)teachaerBtn:(UIButton *)sender {
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"teacherStudentBiaoJi"];
    LoginHomePageViewController *loginHomePageVC = [[LoginHomePageViewController alloc] init];
    [self.navigationController pushViewController:loginHomePageVC animated:YES];
}

- (void)ParentBtn:(UIButton *)sender {
    [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"teacherStudentBiaoJi"];
    LoginHomePageViewController * loginHomePageVC = [[LoginHomePageViewController alloc] init];
    [self.navigationController pushViewController:loginHomePageVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
