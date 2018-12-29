//
//  JingJiActivityCell.h
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/28.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JingJiActivityCell : UITableViewCell

//时间
@property (nonatomic, strong) UILabel     *timeLabel;
//背景
@property (nonatomic, strong) UIView      *backView;
//标题
@property (nonatomic, strong) UILabel     *titleLabel;
//内容
@property (nonatomic, strong) UILabel     *connectLabel;
//线
@property (nonatomic, strong) UIView      *lineView;
//查看详情
@property (nonatomic, strong) UILabel     *chakanDetaislLabel;
//更多图片
@property (nonatomic, strong) UIImageView *moreImg;


@end
