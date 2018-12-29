//
//  TeacherOnlineModel.m
//  ZhiNengXiaoFu
//
//  Created by 独秀科技 on 2018/12/3.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "TeacherOnlineModel.h"

@implementation TeacherOnlineModel

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"ID": @"id"};
}

- (NSMutableArray *)label {
    if (!_label) {
        self.label = [@[]mutableCopy];
    }
    return _label;
}

@end
