//
//  OngoingTableViewCell.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/8/13.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "OngoingTableViewCell.h"

@implementation OngoingTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeOngoingCellUI];
    }
    return self;
}

- (void)makeOngoingCellUI {
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 10)];
    self.lineView.backgroundColor = backColor;
    [self.contentView addSubview:self.lineView];
    
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.lineView.frame.size.height, APP_WIDTH - 20, 200)];
    self.imgView.layer.masksToBounds = YES;
    self.imgView.layer.cornerRadius  = 10;
    [self.contentView addSubview:self.imgView];
    
//    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.imgView.frame.size.width, 40)];
//    self.titleLabel.backgroundColor = touMColor;
//    self.titleLabel.textColor = [UIColor whiteColor];
//    self.titleLabel.font = [UIFont systemFontOfSize:18];
//    self.titleLabel.textAlignment = NSTextAlignmentCenter;
//    [self.imgView addSubview:self.titleLabel];
    
    self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, self.imgView.frame.size.height - 30, self.imgView.frame.size.width, 30)];
    self.titleView.backgroundColor = touMColor;
    [self.imgView addSubview:self.titleView];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.imgView.frame.size.width * 0.5 - 10, 0, self.imgView.frame.size.width * 0.5, 30)];
    self.timeLabel.backgroundColor = [UIColor clearColor];
    self.timeLabel.textColor = [UIColor whiteColor];
    self.timeLabel.font = [UIFont systemFontOfSize:10];
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    [self.titleView addSubview:self.timeLabel];
    
    self.detailsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.imgView.frame.size.width * 0.45, 30)];
    self.detailsLabel.backgroundColor = [UIColor clearColor];
    self.detailsLabel.textColor = [UIColor whiteColor];
    self.detailsLabel.font = [UIFont systemFontOfSize:16];
    self.detailsLabel.text = @"查看详情";
    self.detailsLabel.textAlignment = NSTextAlignmentLeft;
    [self.titleView addSubview:self.detailsLabel];
    
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
