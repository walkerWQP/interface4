//
//  QianDaoItemCell.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/21.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "QianDaoItemCell.h"

@implementation QianDaoItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.shuxianLabel];
        [self addSubview:self.stateLabel];
        [self addSubview:self.timeLabel];
        [self addSubview:self.detailsTimeLabel];
        [self addSubview:self.stateImg];
        [self addSubview:self.yuanImg];
    }
    return self;
}

- (UILabel *)stateLabel {
    if (!_stateLabel) {
        self.stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 40, 20)];
        self.stateLabel.textColor = [UIColor blackColor];
        self.stateLabel.font = [UIFont systemFontOfSize:17];
    }
    return _stateLabel;
}

- (UIImageView *)yuanImg {
    if (!_yuanImg) {
        self.yuanImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.stateLabel.frame.origin.x + self.stateLabel.frame.size.width + 10, 5, 5, 5)];
        self.yuanImg.image = [UIImage imageNamed:@"圆"];
    }
    return _yuanImg;
}



- (UILabel *)shuxianLabel {
    if (!_shuxianLabel) {
        self.shuxianLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.yuanImg.frame.origin.x + self.yuanImg.frame.size.width / 2  - 1.5, self.yuanImg.frame.origin.y + self.yuanImg.frame.size.height + 2, 3, 50)];
        self.shuxianLabel.backgroundColor = COLOR(248, 217, 217, 1);
    }
    return _shuxianLabel;
}

- (UIImageView *)stateImg {
    if (!_stateImg) {
        self.stateImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.yuanImg.frame.origin.x + self.yuanImg.frame.size.width +  10, 10, 17, 17)];
    }
    return _stateImg;
}



- (UILabel *)timeLabel {
    if (!_timeLabel) {
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.stateImg.frame.size.width + self.stateImg.frame.origin.x + 12, 5, 70, 20)];
        self.timeLabel.textColor = [UIColor colorWithRed:167 / 255.0 green:167 / 255.0 blue:167 / 255.0 alpha:1];
        self.timeLabel.font = [UIFont systemFontOfSize:15];
    }
    return _timeLabel;
}

- (UILabel *)detailsTimeLabel {
    if (!_detailsTimeLabel) {
        self.detailsTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake( self.timeLabel.frame.origin.x, self.timeLabel.frame.origin.y + self.timeLabel.frame.size.height, 200, 20)];
        self.detailsTimeLabel.textColor = [UIColor colorWithRed:199 / 255.0 green:199 / 255.0 blue:199 / 255.0 alpha:1];
        self.detailsTimeLabel.font = [UIFont systemFontOfSize:13];
    }
    return _detailsTimeLabel;
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
