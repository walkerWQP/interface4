//
//  TeacherZhuanLanCell.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/30.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "TeacherZhuanLanCell.h"

@implementation TeacherZhuanLanCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.UserIcon];
        [self addSubview:self.UserName];
        [self addSubview:self.timeLabel];
        [self addSubview:self.titleLabel];
        [self addSubview:self.subTitleLabel];
        [self addSubview:self.stateImg];
        [self addSubview:self.stateLabel];
    }
    return self;
}

- (UIImageView *)UserIcon {
    if (!_UserIcon) {
        self.UserIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 50, 50)];
        self.UserIcon.layer.cornerRadius = 25;
        self.UserIcon.layer.masksToBounds = YES;
        self.UserIcon.contentMode=UIViewContentModeScaleAspectFill;
        self.UserIcon.clipsToBounds=YES;
    }
    return _UserIcon;
}

- (UILabel *)UserName {
    if (!_UserName) {
        self.UserName = [[UILabel alloc] initWithFrame:CGRectMake(self.UserIcon.frame.origin.x,self.UserIcon.frame.origin.y + self.UserIcon.frame.size.height + 5, 50, 20)];
        self.UserName.font = [UIFont systemFontOfSize:15];
        self.UserName.textAlignment = NSTextAlignmentCenter;
        self.UserName.textColor = COLOR(147, 147, 147, 1);
    }
    return _UserName;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.UserIcon.frame.origin.x + self.UserIcon.frame.size.width + 10, self.UserIcon.frame.origin.y, APP_WIDTH - (self.UserIcon.frame.origin.x + self.UserIcon.frame.size.width + 10) - 70, 20)];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.textColor = COLOR(147, 147, 147, 1);
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        self.subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 5, APP_WIDTH - self.titleLabel.frame.origin.x - 15, 20)];
        self.subTitleLabel.font = [UIFont systemFontOfSize:15];
        self.subTitleLabel.textColor = COLOR(147, 147, 147, 1);
    }
    return _subTitleLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabel.frame.origin.x, self.subTitleLabel.frame.origin.y + self.subTitleLabel.frame.size.height + 10, 100, 20)];
        self.timeLabel.font = [UIFont systemFontOfSize:15];
        self.timeLabel.textColor = COLOR(147, 147, 147, 1);
    }
    return _timeLabel;
}

- (UIImageView *)stateImg {
    if (!_stateImg) {
        self.stateImg = [[UIImageView alloc] initWithFrame:CGRectMake(APP_WIDTH - 45 - 15, self.titleLabel.frame.origin.y, 45, 19)];
        self.stateImg.image = [UIImage imageNamed:@"公开课"];
    }
    return _stateImg;
}

- (UILabel *)stateLabel {
    if (!_stateLabel) {
        self.stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(APP_WIDTH - 45 - 15, self.titleLabel.frame.origin.y, 45, 19)];
        self.stateLabel.font = [UIFont systemFontOfSize:12];
        self.stateLabel.textAlignment = NSTextAlignmentCenter;
        self.stateLabel.textColor = [UIColor whiteColor];
    }
    return _stateLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
