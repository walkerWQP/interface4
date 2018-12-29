//
//  ClassDetailsTableViewCell.h
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/8/13.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassDetailsTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView  *headImgView;
@property (nonatomic, strong) UILabel      *titleLabel;
@property (nonatomic, strong) UILabel      *subjectsLabel;
@property (nonatomic, strong) UILabel      *timeLabel;
@property (nonatomic, strong) UIButton     *delegateBtn;
@property (nonatomic, strong) UIView       *lineView;
@end
