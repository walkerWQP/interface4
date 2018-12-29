//
//  QianDaoItemCell.h
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/21.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QianDaoItemCell : UITableViewCell

//竖线
@property (nonatomic, strong) UILabel * shuxianLabel;
//圆
@property (nonatomic, strong) UIImageView * yuanImg;
@property (nonatomic, strong) UIImageView * stateImg;
//状态
@property (nonatomic, strong) UILabel * stateLabel;
//时间
@property (nonatomic, strong) UILabel * timeLabel;
//具体时间
@property (nonatomic, strong) UILabel * detailsTimeLabel;



@end
