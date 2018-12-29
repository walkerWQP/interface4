//
//  AppDelegate+ShareFiles.m
//  ChatDemo-UI3.0
//
//  Created by 杜洁鹏 on 15/03/2017.
//  Copyright © 2017 杜洁鹏. All rights reserved.
//

#import "AppDelegate+ShareFiles.h"
#import "ShareFilesViewController.h"
#import "MainNavigationController.h"
#import "LoginHomePageViewController.h"


@implementation AppDelegate (ShareFiles)
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(nonnull NSDictionary<NSString *,id> *)options
{
    if(self.window.rootViewController) {
        id vc = self.window.rootViewController;
        if ([vc isKindOfClass:[MainNavigationController class]]) {
            MainNavigationController *emNav = (MainNavigationController *)vc;
            if (![emNav.topViewController isKindOfClass:[LoginHomePageViewController class]]) {
                if (emNav.viewControllers.count > 0) {
                    [emNav popToRootViewControllerAnimated:NO];
                }
                ShareFilesViewController *shareFilesVC = [[ShareFilesViewController alloc] initWithUrl:url];
                [emNav pushViewController:shareFilesVC animated:YES];
                return YES;
            }
        }
    }
    return YES;
}

@end
