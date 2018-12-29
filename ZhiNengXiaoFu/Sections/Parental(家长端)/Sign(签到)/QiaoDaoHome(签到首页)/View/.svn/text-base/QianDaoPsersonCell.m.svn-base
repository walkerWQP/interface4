//
//  QianDaoPsersonCell.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/21.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "QianDaoPsersonCell.h"

@implementation QianDaoPsersonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.itemImg];
        [self addSubview:self.itemLabel];
    }
    return self;
}

- (UILabel *)itemLabel {
    if (!_itemLabel) {
        self.itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.itemImg.frame.size.width + self.itemImg.frame.origin.x + 15, 40, 100, 20)];
        self.itemLabel.textColor = [UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1];
        self.itemLabel.font = [UIFont systemFontOfSize:17];
    }
    return _itemLabel;
}

- (UIImageView *)itemImg {
    if (!_itemImg) {
        self.itemImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 70, 70)];
        self.itemImg.image = [UIImage imageNamed:@"user"];
        self.itemImg.layer.cornerRadius = 35;
        self.itemImg.layer.masksToBounds = YES;
    }
    return _itemImg;
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
