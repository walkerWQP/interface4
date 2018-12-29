//
//  TeacherZaiXianModel.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/8/7.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "TeacherZaiXianModel.h"
#import "PrefixHeader.pch"
@implementation TeacherZaiXianModel

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
