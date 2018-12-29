//
//  ConsultListModel.h
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/8/4.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConsultListModel : NSObject

@property (nonatomic, copy) NSString    *answer;
@property (nonatomic, copy) NSString    *class_name;
@property (nonatomic, copy) NSString    *course_name;
@property (nonatomic, copy) NSString    *ID;
@property (nonatomic, copy) NSString    *question;
@property (nonatomic, copy) NSString    *s_headimg;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString    *student_name;
@property (nonatomic, copy) NSString    *t_headimg;
@property (nonatomic, copy) NSString    *teacher_name;

@end
