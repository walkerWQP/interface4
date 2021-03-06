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

#import "AppDelegate+EaseMob.h"
#import "AppDelegate+Parse.h"

#import <Bugly/Bugly.h>
#import <UserNotifications/UserNotifications.h>


@interface AppDelegate ()<JPUSHRegisterDelegate, UNUserNotificationCenterDelegate>

@property (nonatomic, assign) NSInteger    force;
@property (nonatomic, strong) NSDictionary *remoteNotificationUserInfo;
@end

@implementation AppDelegate

#define EaseMobAppKey @"1101181224097655#duxiu-keji-2018"

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if (NSClassFromString(@"UNUserNotificationCenter")) {
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    }

    //添加，注册好友回调代理
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
    
    _connectionState = EMConnectionConnected;
    
    [[UITabBar appearance] setTranslucent:NO];
    //设置引导页面
    [self setGuideViewWithUIWindow:self.window];
    //延时2秒
    [NSThread sleepForTimeInterval:2];

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
    if (launchOptions != nil)
    {
        remoteNotificationDic = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
        if (remoteNotificationDic != nil)
        {
            self.remoteNotificationUserInfo = remoteNotificationDic;
        }
    }
    
//    UNUserNotificationCenter * center = [UNUserNotificationCenter currentNotificationCenter];
//    center.delegate = self;
    
#warning Init SDK，detail in AppDelegate+EaseMob.m
#warning SDK注册 APNS文件的名字, 需要与后台上传证书时的名字一一对应
    NSString *apnsCertName = nil;
#ifdef DEBUG
    apnsCertName = @"";
#else
    apnsCertName = @"";
    
    //环信Demo中使用Bugly收集crash信息，没有使用cocoapods,库存放在ChatDemo-UI3.0/ChatDemo-UI3.0/3rdparty/Bugly.framework，可自行删除
    //如果你自己的项目也要使用bugly，请按照bugly官方教程自行配置
    [Bugly startWithAppId:nil];
#endif
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *appkey = [ud stringForKey:@"identifier_appkey"];
    if (!appkey) {
        appkey = EaseMobAppKey;
        [ud setObject:appkey forKey:@"identifier_appkey"];
    }
    
    [self easemobApplication:application
didFinishLaunchingWithOptions:launchOptions
                      appkey:appkey
                apnsCertName:apnsCertName
                 otherConfig:@{kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:YES]}];
    
    [self loginHunXin];
    
    return YES;
}

//用户A发送加B为好友申请，用户B会受到这个回调
- (void)didReceiveFriendInvitationFromUsername:(NSString *)aUsername message:(NSString *)aMessage {
    NSLog(@"用户：%@向你发送好友请求%@",aUsername,aMessage);;
}

- (void)loginHunXin {
    
    
    EMError *error = [[EMClient sharedClient] loginWithUsername:[[NSUserDefaults standardUserDefaults] objectForKey:@"easemob_num"] password:@"000000"];
    if (!error) {
        NSLog(@"环信登录成功");
        [[EMClient sharedClient].options setIsAutoLogin:YES];
    } else {
        NSLog(@"环信登录失败");
        
    }
    
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
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
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
    
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"youkeState"] isEqualToString:@"1"]) {
        
    } else {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"chooseLoginState"] == nil) {
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"notify"];
            
        } else {
            
            if ([userInfo objectForKey:@"identity"] != nil) {
                //identity用户身份0全部，1家长，2教师
                NSString *identityStr = [NSString stringWithFormat:@"%@",[userInfo objectForKey:@"identity"]];
                
                if ([identityStr isEqualToString:@"0"] || [identityStr isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"chooseLoginState"]]) {
                    
                    if ([[userInfo objectForKey:@"type"] isEqualToString:@"notice"]) {
                        TongZhiDetailsViewController * tongZhiDetails  = [[TongZhiDetailsViewController alloc] init];
                        tongZhiDetails.tongZhiId = [NSString stringWithFormat:@"%@",[userInfo objectForKey:@"id"]];
                        
                        if ([identityStr isEqualToString:@"2"]) { //教师
                            tongZhiDetails.typeStr = @"1";
                        }
                        MainNavigationController *pushNav = [[MainNavigationController alloc] initWithRootViewController:tongZhiDetails];
                        
                        UIViewController *rootViewController = [[UIApplication  sharedApplication] keyWindow].rootViewController;
                        while (rootViewController.presentedViewController)
                        {
                            rootViewController = rootViewController.presentedViewController;
                        }
                        [rootViewController presentViewController:pushNav animated:YES completion:nil];
                        
                        
                    }else if ([[userInfo objectForKey:@"type"] isEqualToString:@"homework"]) {
                        
                        WorkDetailsViewController * workDetailsVC = [[WorkDetailsViewController alloc] init];
                        workDetailsVC.workId = [NSString stringWithFormat:@"%@",[userInfo objectForKey:@"id"]];
                        if ([identityStr isEqualToString:@"2"])
                        {
                            workDetailsVC.typeID = @"1";
                        }
                        MainNavigationController *pushNav = [[MainNavigationController alloc] initWithRootViewController:workDetailsVC];
                        UIViewController *rootViewController = [[UIApplication  sharedApplication] keyWindow].rootViewController;
                        while (rootViewController.presentedViewController)
                        {
                            rootViewController = rootViewController.presentedViewController;
                        }
                        [rootViewController presentViewController:pushNav animated:YES completion:nil];
                    } else if ([[userInfo objectForKey:@"type"] isEqualToString:@"consult"]) {
                        
                        if ([identityStr isEqualToString:@"2"]) {
                            ConsultingViewController * consult = [[ConsultingViewController alloc] init];
                            MainNavigationController *pushNav = [[MainNavigationController alloc] initWithRootViewController:consult];
                            UIViewController *rootViewController = [[UIApplication  sharedApplication] keyWindow].rootViewController;
                            while (rootViewController.presentedViewController)
                            {
                                rootViewController = rootViewController.presentedViewController;
                            }
                            [rootViewController presentViewController:pushNav animated:YES completion:nil];
                            
                        } else if ([identityStr isEqualToString:@"1"]) {
                            WenTiZiXunViewController * wenTiZiXunVC = [[WenTiZiXunViewController alloc] init];
                            MainNavigationController *pushNav = [[MainNavigationController alloc] initWithRootViewController:wenTiZiXunVC];
                            UIViewController *rootViewController = [[UIApplication  sharedApplication] keyWindow].rootViewController;
                            while (rootViewController.presentedViewController)
                            {
                                rootViewController = rootViewController.presentedViewController;
                            }
                            [rootViewController presentViewController:pushNav animated:YES completion:nil];
                            
                        }
                    } else if ([[userInfo objectForKey:@"type"] isEqualToString:@"leave"]) {
                        if ([identityStr isEqualToString:@"2"]) {
                            LeaveTheDetailsViewController *leaveTheDetailsVC = [LeaveTheDetailsViewController new];
                            
                            leaveTheDetailsVC.ID = [NSString stringWithFormat:@"%@",[userInfo objectForKey:@"id"]];
                            
                            MainNavigationController *pushNav = [[MainNavigationController alloc] initWithRootViewController:leaveTheDetailsVC];
                            UIViewController *rootViewController = [[UIApplication  sharedApplication] keyWindow].rootViewController;
                            while (rootViewController.presentedViewController)
                            {
                                rootViewController = rootViewController.presentedViewController;
                            }
                            [rootViewController presentViewController:pushNav animated:YES completion:nil];
                            
                        } else {
                            LeaveDetailsViewController *leaveTheDetailsVC = [LeaveDetailsViewController new];
                            
                            leaveTheDetailsVC.leaveDetailsId = [NSString stringWithFormat:@"%@",[userInfo objectForKey:@"id"]];
                            
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
            } else {
                
            }
        }
    }
    
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    
    if (_mainController) {
        [_mainController jumpToChatList];
    }
    [self easemobApplication:application didReceiveRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    if (_mainController) {
        [_mainController didReceiveLocalNotification:notification];
    }
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler
{
    NSDictionary *userInfo = notification.request.content.userInfo;
    [self easemobApplication:[UIApplication sharedApplication] didReceiveRemoteNotification:userInfo];
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler
{
    if (_mainController) {
        [_mainController didReceiveUserNotification:response.notification];
    }
    completionHandler();
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
    
    [[EMClient sharedClient] applicationDidEnterBackground:application];
    
    if (@available(iOS 11.0, *))
    {
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
    [[EMClient sharedClient] applicationWillEnterForeground:application];
    if ([SingletonHelper manager].force == 1) {
        
        [self hsUpdateApp:[SingletonHelper manager].version force:[SingletonHelper manager].force];
    }
    
    if (@available(iOS 11.0, *))
    {
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
