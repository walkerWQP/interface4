//
//  OffTheListCell.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/8/6.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "OffTheListCell.h"

@implementation OffTheListCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self makeOffTheListCellUI];
    }
    return self;
}

- (void)makeOffTheListCellUI {
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 60, 60)];
    self.headImgView.layer.cornerRadius = self.headImgView.frame.size.width/2.0;
    self.headImgView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.headImgView];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headImgView.frame.size.width + 20, (self.headImgView.frame.size.height + 10 - 30) / 2, APP_WIDTH * 0.6, 30)];
    self.nameLabel.font = titFont;
    self.nameLabel.textColor = titlColor;
    [self.contentView addSubview:self.nameLabel];
    
    self.fenQuan = [[UIView alloc] initWithFrame:CGRectMake(10, self.headImgView.frame.size.height + 21, 8, 8)];
    self.fenQuan.layer.cornerRadius = 4;
    self.fenQuan.layer.masksToBounds = YES;
    self.fenQuan.backgroundColor = COLOR(218, 23, 55, 1);
    [self.contentView addSubview:self.fenQuan];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.headImgView.frame.size.height + 10, self.contentView.frame.size.width - 30, 30)];
    self.timeLabel.font = titFont;
    self.timeLabel.textColor = titlColor;
    [self.contentView addSubview:self.timeLabel];
    
    self.lvQuan = [[UIView alloc] initWithFrame:CGRectMake(10, self.headImgView.frame.size.height + self.timeLabel.frame.size.height + 31, 8, 8)];
    self.lvQuan.layer.cornerRadius = 4;
    self.lvQuan.layer.masksToBounds = YES;
    self.lvQuan.backgroundColor = COLOR(0, 186, 255, 1);
    [self.contentView addSubview:self.lvQuan];
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.headImgView.frame.size.height + self.timeLabel.frame.size.height + 20, self.contentView.frame.size.width - 30, 30)];
    self.contentLabel.font = titFont;
    self.contentLabel.textColor = titlColor;
    [self.contentView addSubview:self.contentLabel];
    
    self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width - 100, 10, 90, 30)];
    self.typeLabel.font = titFont;
    self.typeLabel.textColor = titlColor;
    self.typeLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.typeLabel];
    
}

@end
