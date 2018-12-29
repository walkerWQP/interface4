//
//  JurisdictionMethod.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/8/13.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "JurisdictionMethod.h"
#import <CoreLocation/CoreLocation.h>

//相册权限
#import <AssetsLibrary/AssetsLibrary.h>
//相机权限
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <Photos/Photos.h>
@interface JurisdictionMethod()<UIAlertViewDelegate>
{
    UIAlertView *photoAlert;
}

@end

static JurisdictionMethod *jurisdictionMethod;

@implementation JurisdictionMethod

+ (JurisdictionMethod *)shareJurisdictionMethod
{
    if (jurisdictionMethod == nil) {
        jurisdictionMethod = [[JurisdictionMethod alloc] init];
    }
    return jurisdictionMethod;
}

//相机权限
+ (BOOL)videoJurisdiction
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
    {
        return NO;
    }
    return YES;
}


- (void)photoJurisdictionAlert
{
    if (![JurisdictionMethod videoJurisdiction]) {
        photoAlert = [[UIAlertView alloc] initWithTitle:@"打开相机" message:@"相机功能未开启，请进入系统【设置】>【隐私】>【相机】中打开开关，并允许一山智慧使用相机功能" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"立即开启", nil];
        [photoAlert show];
    }
}

//相册权限
+ (BOOL)libraryJurisdiction
{
    
    
    
    
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];

         if (authStatus == PHAuthorizationStatusRestricted|| authStatus == PHAuthorizationStatusDenied)
        {
            return NO;
        }
            return YES;
//
//        }
}


- (void)libraryJurisdictionAlert
{
    if (![JurisdictionMethod libraryJurisdiction]) {
        
        photoAlert = [[UIAlertView alloc] initWithTitle:@"失败" message:@"用户拒绝访问\n请开启一山智慧的图片访问权限,请进入系统【设置】>【隐私】>【照片】" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"立即开启", nil];
        [photoAlert show];
    }
}

//定位权限
+ (BOOL)locationJurisdiction
{
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
        return NO;
    }
    return YES;
}

- (void)locationJurisdictionAlert
{
    UIAlertView *locationAlert = [[UIAlertView alloc] initWithTitle:@"定位失败" message:@"定位服务未开启\n请开启一山智慧的定位服务权限,请进入系统【设置】>【隐私】>【定位服务】>【一山智慧】中打开开关，并允许一山智慧使用定位服务" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"立即开启", nil];
    [locationAlert show];
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //if (alertView == photoAlert) {
    if (buttonIndex == 1) {
        if(IOS_VERSION_8_OR_ABOVE)
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }
        //        else if (IOS_VERSION_7_OR_ABOVE)
        //        {
        //            NSURL*url=[NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"];
        //            [[UIApplication sharedApplication] openURL:url];
        //        }
    }
    //}
    
}

//+ (BOOL)notificationJurisdiction {
//        //iOS8 check if user allow notification
//    if (IOS_VERSION_8_OR_ABOVE) {// system is iOS8
//        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
//        if (UIUserNotificationTypeNone != setting.types) return YES;
//
//    } else {//iOS7
//        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
//        if(UIRemoteNotificationTypeNone != type) return YES;
//    }
//    return NO;
//}
//
//- (void)notificationJurisdictionAlert
//{
//    UIAlertView *notificationAlert = [[UIAlertView alloc] initWithTitle:@"打开通知服务" message:@"通知服务未开启，请进入系统【设置】>【通知】>【快鸟先锋】中打开允许通知开关." delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"立即开启", nil];
//    [notificationAlert show];
//}

@end
