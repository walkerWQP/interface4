//
//  TongZhiDetailsModel.h
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/8/1.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PrefixHeader.pch"
@interface TongZhiDetailsModel : NSObject

@property (nonatomic, copy) NSString         *content;
@property (nonatomic, copy) NSString         *create_time;
@property (nonatomic, copy) NSString         *ID;
@property (nonatomic, strong) NSMutableArray *img;
@property (nonatomic, assign) NSInteger      is_school;
@property (nonatomic, copy) NSString         *title;

@end
