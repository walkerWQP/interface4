//
//  TongZhiCell.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/28.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "TongZhiCell.h"

@implementation TongZhiCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeSchoolDynamicCellCellUI];
    }
    return self;
}

- (void)makeSchoolDynamicCellCellUI {
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , APP_WIDTH, 10)];
    self.lineView.backgroundColor = backColor;
    [self.contentView addSubview:self.lineView];
    self.backgroundColor = [UIColor whiteColor];
    self.headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.lineView.frame.origin.y + self.lineView.frame.size.height + 5, 60, 60)];
    self.headImgView.layer.cornerRadius = 5;
    self.headImgView.layer.masksToBounds = YES;
    
    self.headImgView.contentMode = UIViewContentModeScaleAspectFill;
    self.headImgView.clipsToBounds = YES;
    
    [self.contentView addSubview:self.headImgView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(25 + self.headImgView.frame.size.width,self.headImgView.frame.origin.y, APP_WIDTH - 30 - self.headImgView.frame.size.width, 20)];
    self.titleLabel.font = titFont;
    self.titleLabel.textColor = titlColor;
    [self.contentView addSubview:self.titleLabel];
    
    self.subjectsLabel = [[UILabel alloc] initWithFrame:CGRectMake(25 + self.headImgView.frame.size.width, self.titleLabel.frame.size.height+ self.titleLabel.frame.origin.y + 20, APP_WIDTH * 0.6, 20)];
    self.subjectsLabel.font = contentFont;
    self.subjectsLabel.textColor = RGB(170, 170, 170);;
    [self.contentView addSubview:self.subjectsLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(APP_WIDTH - 90, self.subjectsLabel.frame.origin.y, 80, 30)];
    self.timeLabel.textColor = RGB(170, 170, 170);
    self.timeLabel.font = contentFont;
    [self.contentView addSubview:self.timeLabel];
    
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
