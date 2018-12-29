//
//  HomeworkCell.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/23.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "HomeworkCell.h"

@implementation HomeworkCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.itemImg];
        [self addSubview:self.itemLabel];
//        [self addSubview:self.jiantouImg];
        [self addSubview:self.lineView];
    }
    return self;
}


- (UILabel *)itemLabel {
    if (!_itemLabel) {
        self.itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.itemImg.frame.size.width + self.itemImg.frame.origin.x + 15, 15, 100, 20)];
        self.itemLabel.textColor = RGB(51, 51, 51);
        
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

//- (UIImageView *)jiantouImg {
//    if (!_jiantouImg) {
//        self.jiantouImg = [[UIImageView alloc] initWithFrame:CGRectMake(APP_WIDTH - 20 - 11.5, 17, 11.5, 16)];
//        self.jiantouImg.image = [UIImage imageNamed:@"more"];
//    }
//    return _jiantouImg;
//}

- (UIView *)lineView {
    if (!_lineView) {
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(18, 49, APP_WIDTH - 36, 1)];
        self.lineView.backgroundColor = fengeLineColor;
    }
    return _lineView;
}

@end
