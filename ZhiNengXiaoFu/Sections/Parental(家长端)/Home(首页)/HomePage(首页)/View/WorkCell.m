//
//  WorkCell.m
//  ZhiNengXiaoFu
//
//  Created by 独秀科技 on 2018/10/9.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "WorkCell.h"

@implementation WorkCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.WorkImg.layer.cornerRadius = 30;
    self.WorkImg.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
