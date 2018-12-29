//
//  TeacherZaiXianDetailsModel.h
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/8/7.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeacherZaiXianDetailsModel : NSObject

@property (nonatomic, copy) NSString         *ID;
@property (nonatomic, copy) NSString         *name;
@property (nonatomic, copy) NSString         *video_url;
@property (nonatomic, copy) NSString         *img;
@property (nonatomic, copy) NSString         *title;
@property (nonatomic, copy) NSString         *content;
@property (nonatomic, strong) NSMutableArray *label;
@property (nonatomic, assign) NSInteger      t_id;
@property (nonatomic, copy) NSString         *head_img;
@property (nonatomic, assign) NSInteger      view;
@property (nonatomic, strong) NSString       *create_time;

@end
