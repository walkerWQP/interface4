//
//  TotalNumberModel.h
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/8/6.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TotalNumberModel : NSObject

@property (nonatomic, strong) NSString   *all;  //班级总数
@property (nonatomic, strong) NSString   *sign;  //签到人数
@property (nonatomic, strong) NSString   *no_sign; //未签到人数
@property (nonatomic, strong) NSString   *leave;  //请假人数
@property (nonatomic, strong) NSString   *ID;
@property (nonatomic, strong) NSString   *head_img;
@property (nonatomic, strong) NSString   *name;
@property (nonatomic, assign) NSInteger  is_leave;  //1请假2逃学3签到

@end
