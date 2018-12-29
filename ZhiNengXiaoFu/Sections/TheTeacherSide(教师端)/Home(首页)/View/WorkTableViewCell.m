//
//  WorkTableViewCell.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/10/10.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "WorkTableViewCell.h"

@implementation WorkTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.imgView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.lineView];
    }
    return self;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 60, 60)];
        self.imgView.layer.cornerRadius  = 5;
        self.imgView.layer.masksToBounds = YES;
        self.imgView.image = [UIImage imageNamed:@"user"];
    }
    return _imgView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.imgView.frame.size.width + self.imgView.frame.origin.x + 16, 26, APP_WIDTH - 10 - (self.imgView.frame.size.width + self.imgView.frame.origin.x + 16), 16)];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.textColor = RGB(51, 51, 51);
        self.titleLabel.text = @"三年级二班";
    }
    return _titleLabel;
}



- (UIView *)lineView {
    if (!_lineView) {
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 70, APP_WIDTH - 20, 0.8)];
        self.lineView.backgroundColor = fengeLineColor;
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
