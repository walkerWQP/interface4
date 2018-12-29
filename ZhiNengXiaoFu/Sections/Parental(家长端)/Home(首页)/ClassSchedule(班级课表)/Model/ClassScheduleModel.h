//
//  ClassScheduleModel.h
//  ZhiNengXiaoFu
//
//  Created by 独秀科技 on 2018/12/19.
//  Copyright © 2018 henanduxiu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ClassScheduleModel : NSObject

@property (nonatomic, strong) NSString   *start;
@property (nonatomic, strong) NSString   *end;
@property (nonatomic, strong) NSString   *ID;
@property (nonatomic, strong) NSString   *day;
@property (nonatomic, strong) NSString   *name;

@end

NS_ASSUME_NONNULL_END
