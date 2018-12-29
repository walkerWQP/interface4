//
//  AppDelegate.h
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/20.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "TotalTabBarController.h"
#import "ApplyViewController.h"

//极光推送的appkey
static NSString *appKey = @"ee405673ce881f7ab0777fdf";
static NSString *channel = @"Publish channel";
//极光推送的环境配置
static BOOL isProduction = YES;

//环信
static NSString  *huanXinAppKey = @"1101181224097655#duxiu-keji-2018";


@interface AppDelegate : UIResponder <UIApplicationDelegate,EMChatManagerDelegate>
{
    EMConnectionState _connectionState;
}

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;

@property (strong, nonatomic) TotalTabBarController *mainController;

@end

