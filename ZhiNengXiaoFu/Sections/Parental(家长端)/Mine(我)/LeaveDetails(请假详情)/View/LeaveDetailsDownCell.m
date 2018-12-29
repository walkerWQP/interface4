//
//  LeaveDetailsDownCell.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/28.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "LeaveDetailsDownCell.h"

@implementation LeaveDetailsDownCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.LeaveDetailsDownBackView.layer.cornerRadius = 4;
    self.LeaveDetailsDownBackView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
