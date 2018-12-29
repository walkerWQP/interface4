//
//  ConsultingViewController.m
//  ZhiNengXiaoFu
//  
//  Created by duxiu on 2018/7/26.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "ConsultingViewController.h"
#import "DidNotReturnViewController.h"
#import "HaveToReplyViewController.h"

@interface ConsultingViewController ()

@property (nonatomic,strong) JohnTopTitleView *titleView;

@end

@implementation ConsultingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"问题咨询";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    [self makeConsultingViewControllerUI];
    NSUserDefaults *pushJudge = [NSUserDefaults standardUserDefaults];
    if([[pushJudge objectForKey:@"notify"]isEqualToString:@"push"]) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回拷贝"] style:UIBarButtonItemStylePlain target:self action:@selector(rebackToRootViewAction)];
        self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
        NSUserDefaults *pushJudge = [NSUserDefaults standardUserDefaults];
        [pushJudge setObject:@""forKey:@"notify"];
        [pushJudge synchronize];//记得立即同步
    } else {
        
    }
    
}

- (void)rebackToRootViewAction {
    NSUserDefaults *pushJudge = [NSUserDefaults standardUserDefaults];
    [pushJudge setObject:@""forKey:@"notify"];
    [pushJudge synchronize];//记得立即同步
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)makeConsultingViewControllerUI {
    NSArray *titleArray = [NSArray arrayWithObjects:@"已回复",@"未回复",nil];
    self.titleView.title = titleArray;
    [self.titleView setupViewControllerWithFatherVC:self childVC:[self setChildVC]];
    [self.view addSubview:self.titleView];
}

- (NSArray <UIViewController *>*)setChildVC {
    //已回复
    HaveToReplyViewController *haveToReplyVC = [[HaveToReplyViewController alloc]init];
    //未回复
    DidNotReturnViewController *didNotReturnVC = [[DidNotReturnViewController alloc]init];
    NSArray *childVC = [NSArray arrayWithObjects:haveToReplyVC,didNotReturnVC, nil];
    return childVC;
}

- (JohnTopTitleView *)titleView {
    if (!_titleView) {
        _titleView = [[JohnTopTitleView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    }
    return _titleView;
}

@end
