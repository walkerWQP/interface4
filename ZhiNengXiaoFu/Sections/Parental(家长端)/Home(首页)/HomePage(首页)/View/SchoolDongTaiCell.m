//
//  SchoolDongTaiCell.m
//  ZhiNengXiaoFu
//
//  Created by 独秀科技 on 2018/10/9.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "SchoolDongTaiCell.h"

@implementation SchoolDongTaiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.SchoolDongTaiImg.layer.cornerRadius = 5;
    self.SchoolDongTaiImg.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
