//
//  SystemInformationCell.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/24.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "SystemInformationCell.h"

@implementation SystemInformationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.sysInfoImg];
        [self addSubview:self.titleLabel];
        [self addSubview:self.connectLabel];
    }
    return self;
}

- (UIImageView *)sysInfoImg {
    if (!_sysInfoImg) {
        self.sysInfoImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 80, 60)];
        self.sysInfoImg.image = [UIImage imageNamed:@"homepagelunbo1"];
    }
    return _sysInfoImg;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 15, APP_WIDTH - 110 - 20, 20)];
        self.titleLabel.textColor = COLOR(51, 51, 51, 1);
        self.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:15];
        self.titleLabel.numberOfLines = 1;
    }
    return _titleLabel;
}

- (UILabel *)connectLabel {
    if (!_connectLabel) {
        self.connectLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height, self.titleLabel.frame.size.width, 40)];
        self.connectLabel.numberOfLines = 2;
        self.connectLabel.font = [UIFont systemFontOfSize:13];
        self.connectLabel.textColor = [UIColor colorWithRed:166 / 255.0 green:166 / 255.0 blue:166 / 255.0 alpha:1];
    }
    return _connectLabel;
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
