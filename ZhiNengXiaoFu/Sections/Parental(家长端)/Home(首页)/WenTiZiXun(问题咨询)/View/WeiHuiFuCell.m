//
//  WeiHuiFuCell.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/8/4.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "WeiHuiFuCell.h"

@implementation WeiHuiFuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.WeiHuiFuUserIconImg.layer.cornerRadius = 20;
    self.WeiHuiFuUserIconImg.layer.masksToBounds = YES;
    self.WeiHuiFuLineView.backgroundColor = backColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
