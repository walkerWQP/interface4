//
//  ClassDetailsTableViewCell.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/8/13.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "ClassDetailsTableViewCell.h"

@implementation ClassDetailsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeClassDetailsCellCellUI];
    }
    return self;
}

- (void)makeClassDetailsCellCellUI {
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , APP_WIDTH, 10)];
    self.lineView.backgroundColor = backColor;
    [self.contentView addSubview:self.lineView];
    self.backgroundColor = [UIColor whiteColor];
    self.headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 60, 60)];
//    self.headImgView.layer.cornerRadius = self.headImgView.frame.size.width/2.0;
//    self.headImgView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.headImgView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 + self.headImgView.frame.size.width, 15, APP_WIDTH - 30 - self.headImgView.frame.size.width, 30)];
    self.titleLabel.font = titFont;
    self.titleLabel.textColor = titlColor;
    [self.contentView addSubview:self.titleLabel];
    
    self.subjectsLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 + self.headImgView.frame.size.width, self.titleLabel.frame.size.height + 17, APP_WIDTH * 0.5, 30)];
    self.subjectsLabel.font = contentFont;
    self.subjectsLabel.textColor = RGB(170, 170, 170);
    [self.contentView addSubview:self.subjectsLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(APP_WIDTH - 90, self.titleLabel.frame.size.height + 17, 80, 30)];
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
