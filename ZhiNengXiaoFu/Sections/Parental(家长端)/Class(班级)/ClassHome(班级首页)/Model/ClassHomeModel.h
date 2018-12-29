//
//  ClassHomeModel.h
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/8/10.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassHomeModel : NSObject

@property (nonatomic, copy) NSString         *adviser_name;
@property (nonatomic, copy) NSString         *class_head_img;
@property (nonatomic, copy) NSString         *class_name;
@property (nonatomic, copy) NSString         *message;
@property (nonatomic, assign) NSInteger      num;
@property (nonatomic, strong) NSMutableArray *teachers;

@end
