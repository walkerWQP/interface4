//
//  TeacherOnlineCell.h
//  ZhiNengXiaoFu
//
//  Created by 独秀科技 on 2018/12/3.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TeacherOnlineCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UILabel     *subjectsLabel;
@property (nonatomic, strong) UILabel     *nameLabel;
@property (nonatomic, strong) UIImageView *numImgView;
@property (nonatomic, strong) UILabel     *numLabel;
@property (nonatomic, strong) UIImageView *stateImg;
@property (nonatomic, strong) UIView      *lineView;

@end

NS_ASSUME_NONNULL_END
