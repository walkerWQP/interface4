//
//  LeaveListItemCell.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/24.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "LeaveListItemCell.h"

@implementation LeaveListItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.LeaveTimeLabel];
        [self addSubview:self.titleLabel];
        [self addSubview:self.LeaveReasonLabel];
        [self addSubview:self.stateLabel];
        [self addSubview:self.fenQuan];
        [self addSubview:self.lvQuan];
        [self addSubview:self.lineView];
    }
    return self;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 100, 20)];
        self.titleLabel.text = @"个人请假情况";
        self.titleLabel.textColor = COLOR(51, 51, 51, 1);
        self.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:15];
    }
    return _titleLabel;
}

- (UIView *)fenQuan {
    if (!_fenQuan) {
        self.fenQuan = [[UIView alloc] initWithFrame:CGRectMake(20, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 11, 8, 8)];
        self.fenQuan.layer.cornerRadius = 4;
        self.fenQuan.layer.masksToBounds = YES;
        self.fenQuan.backgroundColor = COLOR(218, 23, 55, 1);
    }
    return _fenQuan;
}

- (UILabel *)LeaveTimeLabel {
    if (!_LeaveTimeLabel) {
        self.LeaveTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.fenQuan.frame.origin.x + self.fenQuan.frame.size.width + 10, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 7, APP_WIDTH - (self.fenQuan.frame.origin.x + self.fenQuan.frame.size.width + 10 + 20), 16)];
        self.LeaveTimeLabel.font = [UIFont systemFontOfSize:13];
        self.LeaveTimeLabel.textColor = COLOR(170, 170, 170, 1);
    }
    return _LeaveTimeLabel;
}

- (UIView *)lvQuan {
    if (!_lvQuan) {
        self.lvQuan = [[UIView alloc] initWithFrame:CGRectMake(20, self.LeaveTimeLabel.frame.origin.y + self.LeaveTimeLabel.frame.size.height + 11, 8, 8)];
        self.lvQuan.layer.cornerRadius = 4;
        self.lvQuan.layer.masksToBounds = YES;
        self.lvQuan.backgroundColor = COLOR(0, 186, 255, 1);
    }
    return _lvQuan;
}

- (UILabel *)LeaveReasonLabel {
    if (!_LeaveReasonLabel) {
        self.LeaveReasonLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.LeaveTimeLabel.frame.origin.x, self.LeaveTimeLabel.frame.origin.y + self.LeaveTimeLabel.frame.size.height + 7, APP_WIDTH - (self.fenQuan.frame.origin.x + self.fenQuan.frame.size.width + 10 + 20), 16)];
        self.LeaveReasonLabel.font = [UIFont systemFontOfSize:13];
        self.LeaveReasonLabel.textColor = COLOR(170, 170, 170, 1);
    }
    return _LeaveReasonLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 99, APP_WIDTH - 20, 1)];
        self.lineView.backgroundColor = COLOR(231, 231, 231, 1);
    }
    return _lineView;
}

- (UILabel *)stateLabel {
    if (!_stateLabel) {
        self.stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(APP_WIDTH - 60, 15, 50, 15)];
        self.stateLabel.font = [UIFont systemFontOfSize:14];
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
