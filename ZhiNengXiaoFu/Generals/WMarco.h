//
//  WMarco.h
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/23.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#ifndef WMarco_h
#define WMarco_h

//系统版本
#define IOS_VERSION_11_OR_ABOVE (([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)? (YES):(NO))
#define IOS_VERSION_10_OR_ABOVE (([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)? (YES):(NO))
#define IOS_VERSION_9_OR_ABOVE (([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)? (YES):(NO))
#define IOS_VERSION_8_OR_ABOVE (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)? (YES):(NO))
#define IOS_VERSION_7_OR_ABOVE (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 && [[[UIDevice currentDevice] systemVersion] floatValue]<8.0)? (YES):(NO))
#define IOS_VERSION_6_OR_ABOVE (([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0 && [[[UIDevice currentDevice] systemVersion] floatValue]<8.0)? (YES):(NO))
//判断iphone版本
#define IS_IPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_IPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_IPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define isPad  ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)

//屏幕宽高
#define APP_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define APP_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#define APP_NAVH ([UIScreen mainScreen].bounds.size.height == 812 ? 88 : 64)
#define APP_TABH ([UIScreen mainScreen].bounds.size.height==812 ? 83 : 49)
#define APP_BottomH ([UIScreen mainScreen].bounds.size.height==812 ? 34 : 0)


#endif /* WMarco_h */
