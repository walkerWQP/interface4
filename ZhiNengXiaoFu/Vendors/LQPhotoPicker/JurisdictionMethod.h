//
//  JurisdictionMethod.h
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/8/13.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JurisdictionMethod : NSObject

+ (JurisdictionMethod *)shareJurisdictionMethod;
//相机权限
+ (BOOL)videoJurisdiction;
//没有相机权限时执行
- (void)photoJurisdictionAlert;

//相册权限
+ (BOOL)libraryJurisdiction;
//没有相册权限时执行
- (void)libraryJurisdictionAlert;

//定位权限
+ (BOOL)locationJurisdiction;
//没有定位权限时执行
- (void)locationJurisdictionAlert;

@end
