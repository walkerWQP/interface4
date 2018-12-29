//
//  ManagementModel.h
//  ZhiNengXiaoFu
//
//  Created by 独秀科技 on 2018/12/6.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ManagementModel : NSObject

@property (nonatomic, strong) NSString   *ID;
@property (nonatomic, strong) NSString   *title;
@property (nonatomic, assign) NSInteger  view;
@property (nonatomic, assign) NSInteger  check; //0未审核1通过2不通过
@property (nonatomic, strong) NSString   *stage_name; //阶段名称
@property (nonatomic, strong) NSString   *grade_name; //年级名称
@property (nonatomic, strong) NSString   *t_name; //科目名称

@end

NS_ASSUME_NONNULL_END
