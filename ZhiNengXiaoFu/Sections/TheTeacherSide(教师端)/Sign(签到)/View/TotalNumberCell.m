//
//  TotalNumberCell.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/31.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "TotalNumberCell.h"

@implementation TotalNumberCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self makeTotalNumberCellUI];
    }
    return self;
}

- (void)makeTotalNumberCellUI {
    
    self.headImgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.contentView.frame.size.width - 60) / 2, 10, 60, 60)];
    self.headImgView.layer.masksToBounds = YES;
    self.headImgView.layer.cornerRadius  = 30;
    [self.contentView addSubview:self.headImgView];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.headImgView.frame.size.height + 20, self.contentView.frame.size.width, 30)];
    self.nameLabel.textColor = titlColor;
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.font = titFont;
    [self.contentView addSubview:self.nameLabel];
    
}

@end
