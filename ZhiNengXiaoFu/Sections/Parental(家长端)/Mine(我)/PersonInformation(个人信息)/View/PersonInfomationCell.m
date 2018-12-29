//
//  PersonInfomationCell.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/23.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "PersonInfomationCell.h"

@implementation PersonInfomationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.nameLabel];
        [self addSubview:self.titleLabel];
        [self addSubview:self.moreImg];
        [self addSubview:self.lineView];
        [self addSubview:self.newTitleLabel];
    }
    return self;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 50 / 2 - 10, 100, 20)];
        self.nameLabel.textColor = COLOR(51, 51, 51, 1);
        self.nameLabel.font = [UIFont systemFontOfSize:15];
    }
    return _nameLabel;
}

- (UIImageView *)moreImg {
    if (!_moreImg) {
        self.moreImg = [[UIImageView alloc] initWithFrame:CGRectMake(APP_WIDTH - 15 - 6, 50 / 2 - 5, 6, 10)];
        self.moreImg.image = [UIImage imageNamed:@"箭头new"];
    }
    return _moreImg;
}

- (UILabel *)newTitleLabel {
    if (!_newTitleLabel) {
        self.newTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(APP_WIDTH - 15 - 6 - 15 - 100, 50 / 2 - 10, 100, 20)];
        self.newTitleLabel.textColor = COLOR(51, 51, 51, 1);
        self.newTitleLabel.font = [UIFont systemFontOfSize:15];
        self.newTitleLabel.textAlignment = NSTextAlignmentRight;
//        self.newTitleLabel.text = @"请绑定手机号";
    }
    return _newTitleLabel;
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(APP_WIDTH - 15 - 100, 50 / 2 - 10, 100, 20)];
        self.titleLabel.textColor = COLOR(51, 51, 51, 1);
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.textAlignment = NSTextAlignmentRight;
    }
    return _titleLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 49, APP_WIDTH - 20, 1)];
        self.lineView.backgroundColor = COLOR(232, 232, 232, 1);
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
