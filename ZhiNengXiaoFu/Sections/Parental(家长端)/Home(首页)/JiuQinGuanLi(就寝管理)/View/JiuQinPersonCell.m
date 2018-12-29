//
//  JiuQinPersonCell.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/8/29.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "JiuQinPersonCell.h"

@implementation JiuQinPersonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.lineView];
        [self addSubview:self.headImg];
        [self addSubview:self.nameLabel];
        [self addSubview:self.typeLabel];
    }
    return self;
}

- (UIView *)lineView {
    if (!_lineView) {
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 10)];
        self.lineView.backgroundColor = backColor;
    }
    return _lineView;
}

- (UIImageView *)headImg {
    if (!_headImg) {
        self.headImg = [[UIImageView alloc] initWithFrame:CGRectMake(15,self.lineView.frame.origin.y + self.lineView.frame.size.height + 10, 70, 70)];
        self.headImg.image = [UIImage imageNamed:@"user"];
        self.headImg.layer.cornerRadius = 35;
        self.headImg.layer.masksToBounds = YES;
    }
    return _headImg;
}

- (UILabel *)typeLabel {
    if (!_typeLabel) {
        self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(APP_WIDTH - 105,  self.headImg.frame.origin.y + 25, 90, 20)];
        self.typeLabel.textColor = qianColor;
        self.typeLabel.font = titFont;
    }
    return _typeLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headImg.frame.origin.x + self.headImg.frame.size.width + 32, self.headImg.frame.origin.y + 25, APP_WIDTH - (self.headImg.frame.origin.x + self.headImg.frame.size.width + 32 + 105), 20)];
        self.nameLabel.textColor = titlColor;
        self.nameLabel.font = [UIFont systemFontOfSize:18];
    }
    return _nameLabel;
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
