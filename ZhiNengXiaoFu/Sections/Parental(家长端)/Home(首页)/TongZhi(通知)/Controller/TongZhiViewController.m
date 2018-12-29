//
//  TongZhiViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/28.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "TongZhiViewController.h"
#import "JohnTopTitleView.h"
#import "SchoolTongZhiViewController.h"
#import "TeacherTongZhiViewController.h"
@interface TongZhiViewController ()
@property (nonatomic,strong) JohnTopTitleView *titleView;

@end

@implementation TongZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR(246, 246, 246, 1);
    self.title = @"通知";
    [self createUI];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
}

- (void)createUI{
    NSArray *titleArray = [NSArray arrayWithObjects:@"学校通知",@"班级通知", nil];
    self.titleView.title = titleArray;
    [self.titleView setupViewControllerWithFatherVC:self childVC:[self setChildVC]];
    [self.view addSubview:self.titleView];
}

- (NSArray <UIViewController *>*)setChildVC{
    
    SchoolTongZhiViewController *vc1 = [[SchoolTongZhiViewController alloc]init];
    vc1.identityID = self.teacherID;

    TeacherTongZhiViewController *vc2 = [[TeacherTongZhiViewController alloc]init];
    vc2.identityID = self.teacherID;
    
    NSArray *childVC = [NSArray arrayWithObjects:vc1,vc2, nil];
    return childVC;
    
}

#pragma mark - getter
- (JohnTopTitleView *)titleView{
    if (!_titleView) {
        _titleView = [[JohnTopTitleView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _titleView.lineViewWidth = 20l;
    }
    return _titleView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
