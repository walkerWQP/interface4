//
//  ClassHomePageItemCell.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/21.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "ClassHomePageItemCell.h"

@implementation ClassHomePageItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.itemImg];
        [self addSubview:self.itemLabel];
        [self addSubview:self.jiantouImg];
        [self addSubview:self.lineView];
    }
    return self;
}


- (UILabel *)itemLabel {
    if (!_itemLabel) {
        self.itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.itemImg.frame.size.width + self.itemImg.frame.origin.x + 15, 15, 100, 20)];
        self.itemLabel.textColor = [UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1];
        self.itemLabel.font = [UIFont systemFontOfSize:13];
    }
    return _itemLabel;
}

- (UIImageView *)itemImg {
    if (!_itemImg) {
        self.itemImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 30, 30)];
    }
    return _itemImg;
}

- (UIImageView *)jiantouImg {
    if (!_jiantouImg) {
        self.jiantouImg = [[UIImageView alloc] initWithFrame:CGRectMake(APP_WIDTH - 20 - 11.5, 17, 11.5, 16)];
        self.jiantouImg.image = [UIImage imageNamed:@"more"];
//        self.jiantouImg.alpha = 0;
    }
    return _jiantouImg;
}

- (UILabel *)lineView {
    if (!_lineView) {
        self.lineView = [[UILabel alloc] initWithFrame:CGRectMake(18, 49, APP_WIDTH - 18, 1)];
        self.lineView.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
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
