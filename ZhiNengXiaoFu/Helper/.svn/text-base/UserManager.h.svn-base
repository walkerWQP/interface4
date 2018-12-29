//
//  UserManager.h
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/8/2.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonInformationModel.h"

@interface UserManager : NSObject

@property (nonatomic, strong) PersonInformationModel * userInfo;

//判断是否是登录状态
+(BOOL)isLogin;

//储存用户信息
+(void)saveUserObject:(PersonInformationModel *)userinfo;

//获取用户基本信息
+(PersonInformationModel *)getUserObject;


//退出登录，清除用户信息
+(void)logoOut;

//获取key
+(NSString  *)key;

@end
