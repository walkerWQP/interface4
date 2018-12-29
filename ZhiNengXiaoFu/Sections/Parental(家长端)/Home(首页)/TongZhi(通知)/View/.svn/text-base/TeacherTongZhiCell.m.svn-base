//
//  TeacherTongZhiCell.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/25.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "TeacherTongZhiCell.h"

@implementation TeacherTongZhiCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.imgView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.contentLabel];
        [self addSubview:self.noticeImgView];
        [self addSubview:self.timeLabel];
        [self addSubview:self.lineView];
    }
    return self;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 15, 100, 80)];
//        self.imgView.image = [UIImage imageNamed:@"放假通知"];
    }
    return _imgView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.imgView.frame.size.width + self.imgView.frame.origin.x + 16, 26, APP_WIDTH - 10 - (self.imgView.frame.size.width + self.imgView.frame.origin.x + 16), 16)];
        self.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:15];
        self.titleLabel.textColor = COLOR(51, 51, 51, 1);
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 10, APP_WIDTH - self.titleLabel.frame.origin.x - 10, 15)];
        self.contentLabel.textColor = COLOR(79,243,164, 1);
        self.contentLabel.font = [UIFont systemFontOfSize:14];
        self.contentLabel.numberOfLines = 1;
    }
    return _contentLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(APP_WIDTH - 70 - 20, self.contentLabel.frame.size.height + self.contentLabel.frame.origin.y + 5, 70, 20)];
        self.timeLabel.font = [UIFont systemFontOfSize:12];
        self.timeLabel.textColor = RGB(119, 119, 119);
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 109, APP_WIDTH - 20, 10)];
        self.lineView.backgroundColor = backColor;
    }
    return _lineView;
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
