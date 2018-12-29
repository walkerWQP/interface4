//
//  HomeItemCell.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/23.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "HomeItemCell.h"

@implementation HomeItemCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.itemImg];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.itemImg.frame.origin.x, self.itemImg.frame.size.height + self.itemImg.frame.origin.y + 5, 60, 20)];
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = RGB(51, 51, 51);
    }
    return _titleLabel;
}

- (UIImageView *)itemImg {
    if (!_itemImg) {
        self.itemImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 30, 15, 60, 60)];
    }
    return _itemImg;
}

@end
