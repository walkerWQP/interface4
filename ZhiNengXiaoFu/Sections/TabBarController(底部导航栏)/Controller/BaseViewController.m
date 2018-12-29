//
//  BaseViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/25.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "BaseViewController.h"
#import "MainNavigationController.h"


@interface BaseViewController ()

@property (nonatomic, strong) void(^backBlock)(void);

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backColor;
    //改变状态栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //兼容iOS7.0导航栏问题
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.view.backgroundColor = backColor;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.hidesBackButton = YES;
    
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
    
    //    isKindOfClass来确定一个对象是否是一个类的成员，或者是派生自该类的成员
    //    　　isMemberOfClass只能确定一个对象是否是当前类的成员
    UIViewController *vc = nil;
    if ([viewControllerToPresent isKindOfClass:[MainNavigationController class]]) {
        vc = viewControllerToPresent.childViewControllers[0];
    } else if ([viewControllerToPresent isKindOfClass:[self class]]) {
        vc = viewControllerToPresent;
    }
    if (vc != nil) {
        UIBarButtonItem *back = [UIBarButtonItem itemWithImage:@"返回拷贝" highImage:@"返回拷贝" target:self action:@selector(backButnClicked:)];
        vc.navigationItem.leftBarButtonItem = back;
    }
}

// 添加一个自定义的返回按钮  block 处理点击事件
- (void)addBackButton:(void(^)(void))block {
    UIBarButtonItem *back = [UIBarButtonItem itemWithImage:@"返回拷贝" highImage:@"返回拷贝" target:self action:@selector(backButnClicked:)];
    self.navigationItem.leftBarButtonItem = back;
    if (block) {
        self.backBlock = block;
    }
}

-(void)backButnClicked:(id)sender {
    if (self.backBlock) {
        self.backBlock();
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
