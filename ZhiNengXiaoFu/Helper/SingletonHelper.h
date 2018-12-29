//
//  SingletonHelper.h
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/31.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PersonInformationModel.h"
#import "TeacherZaiXianDetailsModel.h"

@interface SingletonHelper : NSObject

+ (SingletonHelper *)manager;
- (NSString *)encode:(NSString *)string;
- (NSString *)dencode:(NSString *)base64String;


@property (nonatomic, strong) PersonInformationModel *personInfoModel;

@property (nonatomic, strong) TeacherZaiXianDetailsModel *teacherZaiXianDetailsModel;

@property (nonatomic, assign) int            stateNewXiang;
@property (nonatomic, assign) NSInteger      force;
@property (nonatomic, copy) NSString         *version;
@property (nonatomic, assign) NSInteger      teacherZaiXianId;
@property (nonatomic, strong) NSMutableArray *yidaoAry;
@property (nonatomic, strong) NSMutableArray *weidaoAry;
@property (nonatomic, assign) NSInteger      biaojiJiuQinColor;

@end
