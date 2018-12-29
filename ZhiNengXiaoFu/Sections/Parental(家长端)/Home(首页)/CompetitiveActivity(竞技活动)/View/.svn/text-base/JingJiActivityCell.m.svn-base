//
//  JingJiActivityCell.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/28.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "JingJiActivityCell.h"

@implementation JingJiActivityCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = COLOR(246, 246, 246, 1);
        
        [self addSubview:self.timeLabel];
        [self addSubview:self.backView];
        [self.backView addSubview:self.titleLabel];
        [self.backView addSubview:self.connectLabel];
        [self.backView addSubview:self.chakanDetaislLabel];
        [self.backView addSubview:self.lineView];
        [self.backView addSubview:self.moreImg];
        
    }
    return self;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 14, APP_WIDTH - 30, 15)];
        self.timeLabel.textColor = COLOR(170, 170, 170, 1);
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLabel;
}

- (UIView *)backView {
    if (!_backView) {
        self.backView = [[UIView alloc] initWithFrame:CGRectMake(15, self.timeLabel.frame.size.height + self.timeLabel.frame.origin.y + 10, APP_WIDTH - 30, 130)];
        self.backView.backgroundColor = [UIColor whiteColor];
        self.backView.layer.cornerRadius = 4;
        self.backView.layer.masksToBounds = YES;
    }
    return _backView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 12, self.backView.frame.size.width, 15)];
        self.titleLabel.textColor = COLOR(119, 119, 119, 1);
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        self.titleLabel.numberOfLines = 1;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *)connectLabel {
    if (!_connectLabel) {
        self.connectLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.titleLabel.frame.size.height + self.titleLabel.frame.origin.y + 10, self.backView.frame.size.width - 30, 40)];
        self.connectLabel.textColor = COLOR(170, 170, 170, 1);
        self.connectLabel.numberOfLines = 2;
        self.connectLabel.font = [UIFont systemFontOfSize:15];
    }
    return _connectLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(15, self.connectLabel.frame.size.height + self.connectLabel.frame.origin.y + 10, self.backView.frame.size.width - 30, 1)];
        self.lineView.backgroundColor = COLOR(223, 223, 223, 1);
    }
    return _lineView;
}

- (UILabel *)chakanDetaislLabel {
    if (!_chakanDetaislLabel) {
        self.chakanDetaislLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.backView.frame.size.width / 2 - 40, self.lineView.frame.size.height + self.lineView.frame.origin.y + 10, 80, 15)];
        self.chakanDetaislLabel.textColor = COLOR(170, 170, 170, 1);
        self.chakanDetaislLabel.font = [UIFont systemFontOfSize:15];
    }
    return _chakanDetaislLabel;
}

- (UIImageView *)moreImg {
    if (!_moreImg) {
        self.moreImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.chakanDetaislLabel.frame.origin.x + self.chakanDetaislLabel.frame.size.width + 4, self.chakanDetaislLabel.frame.origin.y, 15, 15)];
    }
    return _moreImg;
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
