//
//  WorkNewTwoCell.m
//  ZhiNengXiaoFu
//
//  Created by 独秀科技 on 2018/10/11.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "WorkNewTwoCell.h"

@implementation WorkNewTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.WorkNewTwoIconImg.layer.cornerRadius = 15;
    self.WorkNewTwoIconImg.layer.masksToBounds = YES;
    self.WorkNewTwoFenLeiLabel.layer.cornerRadius = 5;
    self.WorkNewTwoFenLeiLabel.layer.masksToBounds = YES;
}

@end
