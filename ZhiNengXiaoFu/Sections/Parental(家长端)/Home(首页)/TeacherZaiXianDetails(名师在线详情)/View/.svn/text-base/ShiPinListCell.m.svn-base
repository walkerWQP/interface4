//
//  ShiPinListCell.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/30.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "ShiPinListCell.h"

@implementation ShiPinListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI {
    self.ShiPinListImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 111, 92)];
    self.ShiPinListImg.image = [UIImage imageNamed:@"视频列表"];
    [self addSubview:self.ShiPinListImg];
    
    self.bofangImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, self.ShiPinListImg.frame.size.height / 2 - 9, 14, 18)];
    self.bofangImg.image = [UIImage imageNamed:@"小暂停"];
    [self.ShiPinListImg addSubview:self.bofangImg];
    
    self.bofangLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bofangImg.frame.size.width + self.bofangImg.frame.origin.x + 5, self.bofangImg.frame.origin.y, 55, 20)];
    self.bofangLabel.text = @"正在播放";
    self.bofangLabel.font = [UIFont systemFontOfSize:13];
    self.bofangLabel.textColor = [UIColor whiteColor];
    [self.ShiPinListImg addSubview:self.bofangLabel];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.ShiPinListImg.frame.origin.x + self.ShiPinListImg.frame.size.width + 10, 30, 150, 20)];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.textColor = COLOR(147, 147, 147, 1);
    [self addSubview:self.titleLabel];

    self.naozhongImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.size.height + self.titleLabel.frame.origin.y + 10, 14, 13)];
    self.naozhongImg.image = [UIImage imageNamed:@"时间"];
    [self addSubview:self.naozhongImg];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.naozhongImg.frame.size.width + self.naozhongImg.frame.origin.x + 5, self.naozhongImg.frame.origin.y - 4, 100, 20)];
    self.timeLabel.textColor = COLOR(117, 117, 117, 1);
    self.timeLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.timeLabel];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(15, self.ShiPinListImg.frame.origin.y + self.ShiPinListImg.frame.size.height + 10, APP_WIDTH - 15, 1)];
    self.lineView.backgroundColor = COLOR(229, 229, 229, 1);
    [self addSubview:self.lineView];

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
