//
//  ParentXueTangDetailsModel.h
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/8/10.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParentXueTangDetailsModel : NSObject

@property (nonatomic, copy) NSString         *content;
@property (nonatomic, copy) NSString         *create_time;
@property (nonatomic, copy) NSString         *ID;
@property (nonatomic, copy) NSString         *img;
@property (nonatomic, strong) NSMutableArray *label;
@property (nonatomic, assign) NSInteger      view;
@property (nonatomic, copy) NSString         *title;
@property (nonatomic, copy) NSString         *url;

@end
