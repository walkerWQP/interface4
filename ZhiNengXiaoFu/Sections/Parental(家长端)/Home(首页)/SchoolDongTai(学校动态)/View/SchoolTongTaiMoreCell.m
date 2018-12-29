//
//  SchoolTongTaiMoreCell.m
//  ZhiNengXiaoFu
//
//  Created by 独秀科技 on 2018/10/10.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "SchoolTongTaiMoreCell.h"

@implementation SchoolTongTaiMoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeSchoolDynamicCellCellUI];
    }
    return self;
}

- (void)makeSchoolDynamicCellCellUI {
    
    self.backImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, kScreenWidth - 30, (kScreenWidth - 30) * 119 / 364)];
    self.backImg.image = [UIImage imageNamed:@"卡片底"];
    [self addSubview:self.backImg];
    
    self.headerImg = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 40 - ((kScreenWidth - 30) * 119 / 364 - 40) * 112 / 82, 20, ((kScreenWidth - 30) * 119 / 364 - 40) * 112 / 82, (kScreenWidth - 30) * 119 / 364 - 40)];
    self.headerImg.contentMode = UIViewContentModeScaleAspectFill;
    self.headerImg.clipsToBounds = YES;
    self.headerImg.layer.cornerRadius = 5;
    self.headerImg.layer.masksToBounds = YES;
    [self.backImg addSubview:self.headerImg];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 24, self.backImg.frame.size.width - (((kScreenWidth - 30) * 119 / 364 - 40) * 112 / 82) - 50, 15)];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.textColor = RGBA(51, 51, 51, 1);
    [self.backImg addSubview:self.titleLabel];
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 6, self.titleLabel.frame.size.width, 30)];
    self.contentLabel.numberOfLines = 2;
    self.contentLabel.font = [UIFont systemFontOfSize:11];
    self.contentLabel.textColor = RGBA(119, 119, 119, 1);
    [self.backImg addSubview:self.contentLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.contentLabel.frame.origin.y + self.contentLabel.frame.size.height + 8, 100, 10)];
    self.timeLabel.textColor = RGBA(170, 170, 170, 1);
    self.timeLabel.font = [UIFont systemFontOfSize:10];
    [self.backImg addSubview:self.timeLabel];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
