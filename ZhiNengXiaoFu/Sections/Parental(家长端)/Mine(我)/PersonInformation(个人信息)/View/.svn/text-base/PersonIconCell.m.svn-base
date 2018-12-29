//
//  PersonIconCell.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/23.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "PersonIconCell.h"

@implementation PersonIconCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.nameLabel];
        [self addSubview:self.iConImg];
//        [self addSubview:self.moreImg];
        [self addSubview:self.lineView];
    }
    return self;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 70 / 2 - 10, 100, 20)];
        self.nameLabel.textColor = COLOR(51, 51, 51, 1);
        self.nameLabel.font = [UIFont systemFontOfSize:15];
    }
    return _nameLabel;
}

//- (UIImageView *)moreImg
//{
//    if (!_moreImg) {
//        self.moreImg = [[UIImageView alloc] initWithFrame:CGRectMake(APP_WIDTH - 15 - 11.5, 70 / 2 - 8, 11.5, 16)];
//        self.moreImg.image = [UIImage imageNamed:@"more"];
//    }
//    return _moreImg;
//}

- (UIImageView *)iConImg {
    if (!_iConImg) {
        self.iConImg = [[UIImageView alloc] initWithFrame:CGRectMake(APP_WIDTH - 15 - 50, 10 , 50, 50)];
        self.iConImg.layer.cornerRadius = 25;
        self.iConImg.layer.masksToBounds = YES;
    }
    return _iConImg;
}

- (UIView *)lineView {
    if (!_lineView) {
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 69, APP_WIDTH - 20, 1)];
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
