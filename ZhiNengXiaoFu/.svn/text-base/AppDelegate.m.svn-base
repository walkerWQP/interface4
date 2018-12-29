//
//  AppDelegate.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/20.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "AppDelegate.h"
#import "TotalTabBarController.h"
#import "ChooseHomeViewController.h"
#import "LoginHomePageViewController.h"
//相册权限
#import <AssetsLibrary/AssetsLibrary.h>
//相机权限
#import <AVFoundation/AVCaptureDevice.h>
#import "TheGuideViewController.h"
#import "PrefixHeader.pch"

// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#import "TongZhiDetailsViewController.h"
#import "MainNavigationController.h"
#import "SchoolDongTaiDetailsViewController.h"
#import "WenTiZiXunViewController.h"
#import "WorkDetailsViewController.h"
#import "LeaveTheDetailsViewController.h"
#import "LeaveDetailsViewController.h"
#import "LeaveDetailsViewController.h"
#import "ConsultingViewController.h"
#endif


@interface AppDelegate ()<JPUSHRegisterDelegate, UNUserNotificationCenterDelegate>

@property (nonatomic, assign) NSInteger    force;
@property (nonatomic, strong) NSDictionary *remoteNotificationUserInfo;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    [[UITabBar appearance] setTranslucent:NO];
    //设置引导页面
    [self setGuideViewWithUIWindow:self.window];
    //延时2秒
    [NSThread sleepForTimeInterval:2];

    //高德地图
    [AMapServices sharedServices].apiKey = @"0a06fef6aaa158c44f0d88f5728b4c6c";

    //极光推送
//    [self peiZhiJiGuang:launchOptions];

    IQKeyboardManager * manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
    
    
    //添加初始化 APNs 代码
    //Required
    //notice: 3.0.0 及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义 categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];

    [JPUSHService setupWithOption:launchOptions appKey:appKey channel:channel apsForProduction:isProduction advertisingIdentifier:nil];
    
    NSDictionary *remoteNotificationDic = nil;
    if (launchOptions != nil) {
        remoteNotificationDic = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
        if (remoteNotificationDic != nil) {
            self.remoteNotificationUserInfo = remoteNotificationDic;
        }
    }
    
//    UNUserNotificationCenter * center = [UNUserNotificationCenter currentNotificationCenter];
//    center.delegate = self;
    
    return YES;
}

- (void)peiZhiJiGuang:(NSDictionary *)launchOptions
{
    
}


//设置引导页面

- (void)setGuideViewWithUIWindow:(UIWindow *)window {
    
    // 2设置窗口的根控制器
    //如何知道第一次使用这个版本？比较上次的使用情况
    NSString *versionKey = (__bridge NSString *)kCFBundleVersionKey;
    // 从沙盒中取出上次存储的软件版本号(取出用户上次的使用记录)
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults objectForKey:versionKey];
    // 获得当前打开软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    // 当前版本号 == 上次使用的版本：显示
    if ([currentVersion isEqualToString:lastVersion]) {
       
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"chooseLoginState"] == nil) {
            LoginHomePageViewController * loginHomePageVC = [[LoginHomePageViewController alloc] init];
            self.window.rootViewController = loginHomePageVC;
        } else {
            TotalTabBarController * totalTabBarVC = [[TotalTabBarController alloc] init];
            self.window.rootViewController = totalTabBarVC;
        }
        
        [self setHuoQuShangXianBanBen];

    } else { // 当前版本号 != 上次使用的版本：显示版本新特性
        
        //展示弹出框
        
        TheGuideViewController *guide = [[TheGuideViewController alloc]init];
//        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:guide];
        window.rootViewController = guide;
        // 存储这次使用的软件版本
        [defaults setObject:currentVersion forKey:versionKey];
        [defaults synchronize];
    }
 }

- (void)setHuoQuShangXianBanBen {
    NSDictionary * dic = @{@"system":@"2"};
    [[HttpRequestManager sharedSingleton] POST:versionGetVersion parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //一句代码实现检测更新
        self.force = [[[responseObject objectForKey:@"data"] objectForKey:@"force"] integerValue];
        
        [self hsUpdateApp:[[responseObject objectForKey:@"data"] objectForKey:@"version"] force:[[[responseObject objectForKey:@"data"] objectForKey:@"force"] integerValue]];
        
        [SingletonHelper manager].version = [[responseObject objectForKey:@"data"] objectForKey:@"version"];
        [SingletonHelper manager].force = [[[responseObject objectForKey:@"data"] objectForKey:@"force"] integerValue];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}

/**
 *  天朝专用检测app更新
 */
- (void)hsUpdateApp:(NSString *)version  force:(NSInteger)force {
    //2先获取当前工程项目版本号
    NSDictionary *infoDic=[[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion=[infoDic[@"CFBundleShortVersionString"] stringByReplacingOccurrencesOfString:@"."withString:@""];
    
    NSString * versinNew  = [version stringByReplacingOccurrencesOfString:@"."withString:@""];
    //3从网络获取appStore版本号
    
    if([currentVersion integerValue] < [versinNew integerValue]) {
        [self setGengXinNeiRon:force];
    } else {
        NSLog(@"版本号好像比商店大噢!检测到不需要更新");
    }
    
}

- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (self.force == 1) {
        if(buttonIndex==0)
        {
            //6此处加入应用在app store的地址，方便用户去更新，一种实现方式如下：
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@?ls=1&mt=8", STOREAPPID]];
            [[UIApplication sharedApplication] openURL:url];
        }
    } else {
        //5实现跳转到应用商店进行更新
        if(buttonIndex==1) {
            //6此处加入应用在app store的地址，方便用户去更新，一种实现方式如下：
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@?ls=1&mt=8", STOREAPPID]];
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

- (void)setGengXinNeiRon:(NSInteger)force {
    if (force == 1) {
        UIAlertView * neironAlertView = [[UIAlertView alloc] initWithTitle:@"版本有更新,请前往appstore下载" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [neironAlertView show];
    } else {
        UIAlertView * neironAlertView = [[UIAlertView alloc] initWithTitle:@"版本有更新,请前往appstore下载" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [neironAlertView show];
    }
    
}

//注册 APNs 成功并上报 DeviceToken
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

//实现注册 APNs 失败接口
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

//添加处理 APNs 通知回调方法
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    completionHandler(UNNotificationPresentationOptionAlert|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound); // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
    
    
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    } else {
        
    }
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"chooseLoginState"] == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"notify"];

    } else {
        
        if ([[userInfo objectForKey:@"identity"] isEqualToString:@"0"] || [[userInfo objectForKey:@"identity"] isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"chooseLoginState"]]) {
            if ([[userInfo objectForKey:@"type"] isEqualToString:@"notice"]) {
                TongZhiDetailsViewController * tongZhiDetails  = [[TongZhiDetailsViewController alloc] init];
                tongZhiDetails.tongZhiId = [userInfo objectForKey:@"id"];
                
                if ([[userInfo objectForKey:@"identity"] isEqualToString:@"2"]) {
                    tongZhiDetails.typeStr = @"1";
                    
                }
                MainNavigationController *pushNav = [[MainNavigationController alloc] initWithRootViewController:tongZhiDetails];
                
                UIViewController *rootViewController = [[UIApplication  sharedApplication] keyWindow].rootViewController;
                while (rootViewController.presentedViewController)
                {
                    rootViewController = rootViewController.presentedViewController;
                }
                [rootViewController presentViewController:pushNav animated:YES completion:nil];
                
                
            } else if ([[userInfo objectForKey:@"type"] isEqualToString:@"homework"]) {
                
                WorkDetailsViewController * workDetailsVC = [[WorkDetailsViewController alloc] init];
                workDetailsVC.workId = [userInfo objectForKey:@"id"];
                if ([[userInfo objectForKey:@"identity"] isEqualToString:@"2"]) {
                    workDetailsVC.typeID = @"1";
                }
                MainNavigationController *pushNav = [[MainNavigationController alloc] initWithRootViewController:workDetailsVC];
                UIViewController *rootViewController = [[UIApplication  sharedApplication] keyWindow].rootViewController;
                while (rootViewController.presentedViewController) {
                    rootViewController = rootViewController.presentedViewController;
                }
                [rootViewController presentViewController:pushNav animated:YES completion:nil];
            } else if ([[userInfo objectForKey:@"type"] isEqualToString:@"consult"]) {
             
                if ([[userInfo objectForKey:@"identity"] isEqualToString:@"2"]) {
                    ConsultingViewController * consult = [[ConsultingViewController alloc] init];
                    MainNavigationController *pushNav = [[MainNavigationController alloc] initWithRootViewController:consult];
                    UIViewController *rootViewController = [[UIApplication  sharedApplication] keyWindow].rootViewController;
                    while (rootViewController.presentedViewController) {
                        rootViewController = rootViewController.presentedViewController;
                    }
                    [rootViewController presentViewController:pushNav animated:YES completion:nil];
                
                } else if ([[userInfo objectForKey:@"identity"] isEqualToString:@"1"]) {
                    WenTiZiXunViewController * wenTiZiXunVC = [[WenTiZiXunViewController alloc] init];
                    MainNavigationController *pushNav = [[MainNavigationController alloc] initWithRootViewController:wenTiZiXunVC];
                    UIViewController *rootViewController = [[UIApplication  sharedApplication] keyWindow].rootViewController;
                    while (rootViewController.presentedViewController) {
                        rootViewController = rootViewController.presentedViewController;
                    }
                    [rootViewController presentViewController:pushNav animated:YES completion:nil];
                }
            } else if ([[userInfo objectForKey:@"type"] isEqualToString:@"leave"]) {
                if ([[userInfo objectForKey:@"identity"] isEqualToString:@"2"]) {
                    LeaveTheDetailsViewController *leaveTheDetailsVC = [LeaveTheDetailsViewController new];
                    
                    leaveTheDetailsVC.ID = [userInfo objectForKey:@"id"];
                    
                    MainNavigationController *pushNav = [[MainNavigationController alloc] initWithRootViewController:leaveTheDetailsVC];
                    UIViewController *rootViewController = [[UIApplication  sharedApplication] keyWindow].rootViewController;
                    while (rootViewController.presentedViewController) {
                        rootViewController = rootViewController.presentedViewController;
                    }
                    [rootViewController presentViewController:pushNav animated:YES completion:nil];
                } else {
                    LeaveDetailsViewController *leaveTheDetailsVC = [LeaveDetailsViewController new];
                    
                    leaveTheDetailsVC.leaveDetailsId = [userInfo objectForKey:@"id"];
                    
                    MainNavigationController *pushNav = [[MainNavigationController alloc] initWithRootViewController:leaveTheDetailsVC];
                    UIViewController *rootViewController = [[UIApplication  sharedApplication] keyWindow].rootViewController;
                    while (rootViewController.presentedViewController) {
                        rootViewController = rootViewController.presentedViewController;
                    }
                    [rootViewController presentViewController:pushNav animated:YES completion:nil];
                }
             
            }
            
            [[NSUserDefaults standardUserDefaults] setObject:@"push" forKey:@"notify"];
        } else {
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"notify"];
        }
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {

    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    
//    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
//    content.body = self.remoteNotificationUserInfo[@"data"][@"content"];
//    content.userInfo = self.remoteNotificationUserInfo;
//    content.sound = [UNNotificationSound defaultSound];
//    [content setValue:@(YES) forKeyPath:@"shouldAlwaysAlertWhileAppIsForeground"];//很重要的设置
//
//    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"Notif" content:content trigger:nil];
//    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
//    }];
}

//ios 系统6以下 不考虑
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {

    // Required, For systems with less than or equal to iOS 6
    [JPUSHService handleRemoteNotification:userInfo];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    if (@available(iOS 11.0, *)) {
        [UIApplication sharedApplication].applicationIconBadgeNumber = -1;
        [JPUSHService setBadge:0];
    } else {
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = [NSDate date];
        localNotification.applicationIconBadgeNumber = -1;
        [JPUSHService setBadge:0];
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    }
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    if ([SingletonHelper manager].force == 1) {

        [self hsUpdateApp:[SingletonHelper manager].version force:[SingletonHelper manager].force];
    }
    
    if (@available(iOS 11.0, *)) {
        [UIApplication sharedApplication].applicationIconBadgeNumber = -1;
        [JPUSHService setBadge:0];
    } else {
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = [NSDate date];
        localNotification.applicationIconBadgeNumber = -1;
        [JPUSHService setBadge:0];
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    }
//
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"ZhiNengXiaoFu"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
