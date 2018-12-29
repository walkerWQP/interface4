//
//  LeaveDetailsHeaderCell.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/28.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "LeaveDetailsHeaderCell.h"

@implementation LeaveDetailsHeaderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = COLOR(246, 246, 246, 1);
        [self addSubview:self.backView];
        [self.backView addSubview:self.userIconImg];
        [self.backView addSubview:self.userNameLabel];
        [self addSubview:self.StartEndView];
        [self.StartEndView addSubview:self.StartImg];
        [self.StartEndView addSubview:self.EndImg];
        [self.StartEndView addSubview:self.StartLabel];
        [self.StartEndView addSubview:self.EndLabel];
    }
    return self;
}

- (UIView *)backView {
    if (!_backView) {
        self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 155)];
        self.backView.backgroundColor = tabBarColor;
    }
    return _backView;
}

- (UIImageView *)userIconImg {
    if (!_userIconImg) {
        self.userIconImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.backView.frame.size.width / 2 -35, 4, 70, 70)];
        self.userIconImg.image = [UIImage imageNamed:@"user2"];
        self.userIconImg.layer.cornerRadius = 35;
        self.userIconImg.layer.masksToBounds = YES;

    }
    return _userIconImg;
}

- (UILabel *)userNameLabel {
    if (!_userNameLabel) {
        self.userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.userIconImg.frame.size.height + self.userIconImg.frame.origin.y + 12, APP_WIDTH, 17)];
        self.userNameLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:15];
        self.userNameLabel.textColor = [UIColor whiteColor];
        self.userNameLabel.textAlignment = NSTextAlignmentCenter;
        self.userNameLabel.text = @"楠笙";
    }
    return _userNameLabel;
}

- (UIView *)StartEndView {
    if (!_StartEndView) {
        self.StartEndView = [[UIView alloc] initWithFrame:CGRectMake(32, 155 - 85 / 2, APP_WIDTH - 64, 85)];
        self.StartEndView.backgroundColor = [UIColor whiteColor];
        self.StartEndView.layer.cornerRadius = 4;
        self.StartEndView.layer.masksToBounds = YES;
    }
    return _StartEndView;
}

- (UIImageView *)StartImg {
    if (!_StartImg) {
        self.StartImg = [[UIImageView alloc] initWithFrame:CGRectMake(25, 53 / 2, 32, 32)];
        self.StartImg.image = [UIImage imageNamed:@"起"];
    }
    return _StartImg;
}

- (UILabel *)StartLabel {
    if (!_StartLabel) {
        self.StartLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.StartImg.frame.origin.x + self.StartImg.frame.size.width + 10, self.StartEndView.frame.size.height / 2 - 10, 90, 20)];
        self.StartLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:15];
        self.StartLabel.textColor = COLOR(119, 119, 119, 1);
    }
    return _StartLabel;
}

- (UIImageView *)EndImg {
    if (!_EndImg) {
        self.EndImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.StartEndView.frame.size.width / 2 + 10, 53 / 2, 32, 32)];
        self.EndImg.image = [UIImage imageNamed:@"止"];
    }
    return _EndImg;
}

- (UILabel *)EndLabel {
    if (!_EndLabel) {
        self.EndLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.EndImg.frame.origin.x + self.EndImg.frame.size.width + 10, self.StartEndView.frame.size.height / 2 - 10, 90, 20)];
        self.EndLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:15];
        self.EndLabel.textColor = COLOR(119, 119, 119, 1);
        
    }
    return _EndLabel;
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
