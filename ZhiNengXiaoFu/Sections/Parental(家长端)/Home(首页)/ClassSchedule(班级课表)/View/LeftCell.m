//
//  LeftCell.m
//  ZhiNengXiaoFu
//
//  Created by 独秀科技 on 2018/12/19.
//  Copyright © 2018 henanduxiu. All rights reserved.
//

#import "LeftCell.h"

@implementation LeftCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeLeftCellUI];
    }
    return self;
}

- (void)makeLeftCellUI {
    
    self.beginLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 60, 20)];
    self.beginLabel.font = [UIFont systemFontOfSize:12];
    self.beginLabel.textColor = RGB(51, 51, 51);
    self.beginLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.beginLabel];
    
    self.numLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 30, 30, 20)];
    self.numLabel.font = [UIFont systemFontOfSize:12];
    self.numLabel.textColor = RGB(110, 213, 240);
    self.numLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.numLabel];
    
    self.endLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 55, 30, 20)];
    self.endLabel.font = [UIFont systemFontOfSize:12];
    self.endLabel.textColor = RGB(51, 51, 51);
    self.endLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.endLabel];
    
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
