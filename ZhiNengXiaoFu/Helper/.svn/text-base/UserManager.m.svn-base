//
//  UserManager.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/8/2.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "UserManager.h"
#import "LoginHomePageViewController.h"
@implementation UserManager


+ (BOOL)isLogin {
    
    BOOL loginState;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefault objectForKey:@"personInfo"];
    if (data.length > 0) {
        loginState = YES;
    } else {
        loginState = NO;
    }
    return loginState;
}



+ (void)saveUserObject:(PersonInformationModel *)userinfo {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userinfo];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:data forKey:@"personInfo"];
    [userDefault synchronize];
}



+ (PersonInformationModel *)getUserObject {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefault objectForKey:@"personInfo"];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data ];
}



+(void)logoOut {
    
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"chooseLoginState"];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"personInfo"];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"key"];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"youkeState"];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"guanbiGunDong" object:nil];
        LoginHomePageViewController * loginHomepage = [[LoginHomePageViewController alloc] init];
        // 定义一个变量存放当前屏幕显示的viewcontroller
        UIViewController *result = nil;
    
        // 得到当前应用程序的主要窗口
        UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    
        // windowLevel是在 Z轴 方向上的窗口位置，默认值为UIWindowLevelNormal
        if (window.windowLevel != UIWindowLevelNormal) {
            // 获取应用程序所有的窗口
            NSArray *windows = [[UIApplication sharedApplication] windows];
            for(UIWindow * tmpWin in windows) {
                // 找到程序的默认窗口（正在显示的窗口）
                if (tmpWin.windowLevel == UIWindowLevelNormal) {
                    // 将关键窗口赋值为默认窗口
                    window = tmpWin;
                    break;
                }
            }
        }
    
        // 获取窗口的当前显示视图
        UIView *frontView = [[window subviews] objectAtIndex:0];
    
        // 获取视图的下一个响应者，UIView视图调用这个方法的返回值为UIViewController或它的父视图
        id nextResponder = [frontView nextResponder];
    
        // 判断显示视图的下一个响应者是否为一个UIViewController的类对象
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            result = nextResponder;
        } else {
            result = window.rootViewController;
        }
    
        [result presentViewController:loginHomepage animated:YES completion:NULL];
    
}

+(NSString  *)key {
    NSString * key = [[NSUserDefaults standardUserDefaults] objectForKey:@"key"];
    if (key == nil) {
        key = @"";
    } else {
       
    }
    return key;
}


#pragma mark 获取当前屏幕显示的viewcontroller


@end
