//
//  JiuQinStuCell.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/8/30.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "JiuQinStuCell.h"

@implementation JiuQinStuCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.headImg];
        [self addSubview:self.nameLabel];
    }
    return self;
}

- (UIImageView *)headImg {
    if (!_headImg) {
        self.headImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 35, 20, 70, 70)];
        self.headImg.layer.cornerRadius = 35;
        self.headImg.layer.masksToBounds = YES;
        self.headImg.contentMode = UIViewContentModeScaleAspectFill;
        self.headImg.clipsToBounds = YES;
    }
    return _headImg;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headImg.frame.origin.x, self.headImg.frame.size.height + self.headImg.frame.origin.y + 10, 70, 15)];
        self.nameLabel.font = [UIFont systemFontOfSize:12];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.textColor = titlColor;
    }
    return _nameLabel;
}


@end
