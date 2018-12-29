//
//  ClassListCell.m
//  ZhiNengXiaoFu
//
//  Created by 独秀科技 on 2018/12/18.
//  Copyright © 2018 henanduxiu. All rights reserved.
//

#import "ClassListCell.h"

@implementation ClassListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeClassListCellUI];
    }
    return self;
}


- (void)makeClassListCellUI {
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 10)];
    lineView.backgroundColor = backColor;
    [self.contentView addSubview:lineView];
    
    self.numBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 20, 20)];
    self.numBtn.layer.masksToBounds = YES;
    self.numBtn.layer.cornerRadius  = 10;
    self.numBtn.layer.borderWidth   = 0.5;
    self.numBtn.layer.borderColor   = RGB(136, 136, 136).CGColor;
    self.numBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.numBtn setTitleColor:RGB(136, 136, 136) forState:UIControlStateNormal];
    [self.contentView addSubview:self.numBtn];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(30 + self.numBtn.frame.size.width, 15, 170, 30)];
    self.timeLabel.backgroundColor = [UIColor whiteColor];
    self.timeLabel.textColor = RGB(136, 136, 136);
    self.timeLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.timeLabel];
    
    self.changBtn = [[UIButton alloc] initWithFrame:CGRectMake(APP_WIDTH - 130, 15, 30, 30)];
    [self.changBtn setImage:[UIImage imageNamed:@"编辑"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.changBtn];
    
    self.delegateBtn = [[UIButton alloc] initWithFrame:CGRectMake(APP_WIDTH - 60, 15, 30, 30)];
    [self.delegateBtn setImage:[UIImage imageNamed:@"删除1"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.delegateBtn];
    
    
    
    
    
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
