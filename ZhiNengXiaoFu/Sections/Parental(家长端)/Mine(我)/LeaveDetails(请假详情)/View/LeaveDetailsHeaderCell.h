//
//  LeaveDetailsHeaderCell.h
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/28.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaveDetailsHeaderCell : UITableViewCell

@property (nonatomic, strong) UIImageView *userIconImg;
@property (nonatomic, strong) UILabel     *userNameLabel;
@property (nonatomic, strong) UIView      *backView;
@property (nonatomic, strong) UIView      *StartEndView;
@property (nonatomic, strong) UIImageView *StartImg;
@property (nonatomic, strong) UIImageView *EndImg;
@property (nonatomic, strong) UILabel     *StartLabel;
@property (nonatomic, strong) UILabel     *EndLabel;

@end
