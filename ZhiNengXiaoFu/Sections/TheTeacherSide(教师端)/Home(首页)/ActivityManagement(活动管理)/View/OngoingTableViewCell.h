//
//  OngoingTableViewCell.h
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/8/13.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OngoingTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView   *imgView;
@property (nonatomic, strong) UILabel       *titleLabel;
@property (nonatomic, strong) UILabel       *timeLabel;
@property (nonatomic, strong) UILabel       *detailsLabel;
@property (nonatomic, strong) UIView        *lineView;
@property (nonatomic, strong) UIView        *titleView;

@end
