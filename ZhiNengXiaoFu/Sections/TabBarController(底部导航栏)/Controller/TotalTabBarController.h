//
//  TotalTabBarController.h
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/20.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>

#import "ConversationListController.h"
#import "ContactListViewController.h"
#import "SettingsViewController.h"


@interface TotalTabBarController : UITabBarController

@property (nonatomic, strong) ConversationListController *chatListVC;
@property (nonatomic, strong) ContactListViewController  *contactsVC;
@property (nonatomic, strong) SettingsViewController     *settingsVC;

- (void)jumpToChatList;

- (void)setupUntreatedApplyCount;

- (void)setupUnreadMessageCount;

- (void)networkChanged:(EMConnectionState)connectionState;

- (void)didReceiveLocalNotification:(UILocalNotification *)notification;

- (void)didReceiveUserNotification:(UNNotification *)notification;

- (void)playSoundAndVibration;

- (void)showNotificationWithMessage:(EMMessage *)message;

@end
