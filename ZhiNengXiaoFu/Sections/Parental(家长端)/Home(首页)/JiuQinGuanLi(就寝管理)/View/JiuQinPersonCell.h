//
//  JiuQinPersonCell.h
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/8/29.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JiuQinPersonCell : UITableViewCell

//横线
@property (nonatomic, strong) UIView      *lineView;
//头像
@property (nonatomic, strong) UIImageView *headImg;
//名字
@property (nonatomic, strong) UILabel     *nameLabel;
//类型
@property (nonatomic, strong) UILabel     *typeLabel;


@end
