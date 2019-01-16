//
//  MainNavigationController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/25.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "MainNavigationController.h"


@interface MainNavigationController ()

@property (nonatomic,strong) UIButton *backBtn;

@end

@implementation MainNavigationController

+ (void)load {
    
    // 获取当前整个应用程序下的所有导航条的外观
    //    UINavigationBar *navBar = [UINavigationBar appearance];
    // 只影响当前类下面的导航条
    // 获取当前类下面的导航条
    UINavigationBar *navbar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    [navbar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    
    [[UITabBar appearance] setTintColor:tabBarColor];

    
    [navbar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionary];
    mDict[NSForegroundColorAttributeName] = [UIColor blackColor];
    navbar.titleTextAttributes = mDict;
    //去掉黑线
    [navbar setShadowImage:[[UIImage alloc] init]];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"返回拷贝"] forState:UIControlStateNormal];
        btn.titleLabel.hidden = YES;
        [btn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        btn.frame = CGRectMake(0, 0, 44, 40);
        btn;
    });
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.backBtn];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:YES];
}




- (void)backBtnClicked:(UIButton *)btn {
    [self popViewControllerAnimated:YES];
}

@end
