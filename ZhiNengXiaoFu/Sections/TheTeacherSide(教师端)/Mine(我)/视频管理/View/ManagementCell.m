//
//  ManagementCell.m
//  ZhiNengXiaoFu
//
//  Created by 独秀科技 on 2018/12/6.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "ManagementCell.h"

@implementation ManagementCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeManagementCellUI];
    }
    return self;
}

- (void)makeManagementCellUI {
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , APP_WIDTH, 10)];
    self.lineView.backgroundColor = backColor;
    [self.contentView addSubview:self.lineView];
    self.backgroundColor = [UIColor whiteColor];
    
    self.videoNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10 + self.lineView.frame.size.height, 100, 20)];
    self.videoNameLabel.font = [UIFont systemFontOfSize:18];
    self.videoNameLabel.textColor = RGB(51, 51, 51);
    [self.contentView addSubview:self.videoNameLabel];
    
    self.numLabel = [[UILabel alloc] initWithFrame:CGRectMake(APP_WIDTH - 130, 10 + self.lineView.frame.size.height, 100, 20)];
    self.numLabel.textColor = RGB(81, 81, 81);
    self.numLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.numLabel];
    
    self.classLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 40 + self.lineView.frame.size.height + self.videoNameLabel.frame.size.height, APP_WIDTH * 0.5, 20)];
    self.classLabel.textColor = RGB(81, 81, 81);
    self.classLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.classLabel];
    
    self.auditLabel = [[UILabel alloc] initWithFrame:CGRectMake(APP_WIDTH - 130, 40 + self.lineView.frame.size.height + self.videoNameLabel.frame.size.height, 70, 20)];
    self.auditLabel.textColor = RGB(81, 81, 81);
    self.auditLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.auditLabel];
    
    self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(APP_WIDTH - 60, 40 + self.lineView.frame.size.height + self.videoNameLabel.frame.size.height, 50, 20)];
    self.typeLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.typeLabel];
    
    
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
