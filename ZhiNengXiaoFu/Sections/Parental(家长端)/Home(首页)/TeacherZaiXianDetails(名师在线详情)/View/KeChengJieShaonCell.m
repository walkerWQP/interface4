//
//  KeChengJieShaonCell.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/8/14.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "KeChengJieShaonCell.h"

@implementation KeChengJieShaonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.userImg.layer.cornerRadius = 30;
    self.userImg.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
