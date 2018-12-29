//
//  TeacherOnlineModel.h
//  ZhiNengXiaoFu
//
//  Created by 独秀科技 on 2018/12/3.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TeacherOnlineModel : NSObject

@property (nonatomic, copy) NSString         *ID;
@property (nonatomic, copy) NSString         *title;
@property (nonatomic, copy) NSString         *img;
@property (nonatomic, strong) NSMutableArray *label;
@property (nonatomic, assign) NSInteger      view;
@property (nonatomic, copy) NSString         *grade_name;
@property (nonatomic, copy) NSString         *t_name;
@property (nonatomic, copy) NSString         *head_img;
@property (nonatomic, copy) NSString         *name;


@end

NS_ASSUME_NONNULL_END
