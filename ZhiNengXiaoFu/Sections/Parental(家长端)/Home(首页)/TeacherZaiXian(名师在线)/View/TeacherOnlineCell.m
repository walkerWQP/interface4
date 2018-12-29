//
//  TeacherOnlineCell.m
//  ZhiNengXiaoFu
//
//  Created by 独秀科技 on 2018/12/3.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "TeacherOnlineCell.h"

@implementation TeacherOnlineCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeCellUI];
    }
    return self;
}

- (void)makeCellUI {
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 110, 80)];
    self.imgView.layer.cornerRadius = 5;
    self.imgView.layer.masksToBounds = YES;
    self.imgView.contentMode=UIViewContentModeScaleAspectFill;
    self.imgView.clipsToBounds=YES;
    [self.contentView addSubview:self.imgView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.imgView.frame.size.width + 20, 15, APP_WIDTH - self.imgView.frame.size.width - 30, 20)];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.textColor = COLOR(51,51,51, 1);
    [self.contentView addSubview:self.titleLabel];
    
    self.subjectsLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.imgView.frame.size.width + 20, 20 + self.titleLabel.frame.size.height, APP_WIDTH - self.imgView.frame.size.width - 30, 20)];
    self.subjectsLabel.font = [UIFont systemFontOfSize:12];
    self.subjectsLabel.textColor = RGB(170, 170, 170);
    [self.contentView addSubview:self.subjectsLabel];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.imgView.frame.size.width + 20, 22 + self.titleLabel.frame.size.height + self.subjectsLabel.frame.size.height, 60, 20)];
    self.nameLabel.font = [UIFont systemFontOfSize:12];
    self.nameLabel.textColor = RGB(170, 170, 170);
    [self.contentView addSubview:self.nameLabel];
    
    self.numImgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.imgView.frame.size.width + self.nameLabel.frame.size.width + 25, 27.5 + self.titleLabel.frame.size.height + self.subjectsLabel.frame.size.height, 10, 10)];
    self.numImgView.image = [UIImage imageNamed:@"播放次数"];
    [self.contentView addSubview:self.numImgView];
    
    self.numLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.imgView.frame.size.width + self.nameLabel.frame.size.width + 35, 22.5 + self.titleLabel.frame.size.height + self.subjectsLabel.frame.size.height, APP_WIDTH - self.imgView.frame.size.width - 50, 20)];
    self.numLabel.font = [UIFont systemFontOfSize:12];
    self.numLabel.textColor = RGB(170, 170, 170);
    [self.contentView addSubview:self.numLabel];
    
    self.stateImg = [[UIImageView alloc] initWithFrame:CGRectMake(APP_WIDTH - 15, 80 / 2, 8, 15)];
    self.stateImg.image = [UIImage imageNamed:@"箭头new"];
    [self.contentView addSubview:self.stateImg];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 100 - 1, APP_WIDTH, 1)];
    self.lineView.backgroundColor = RGB(247,242,242);
    [self.contentView addSubview:self.lineView];
    
    
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
