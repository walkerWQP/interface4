//
//  KeChengJieShaoCell.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/30.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "KeChengJieShaoCell.h"

@implementation KeChengJieShaoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI {
    self.userImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 60, 60)];
    self.userImg.layer.cornerRadius = 30;
    self.userImg.layer.masksToBounds = YES;
    [self addSubview:self.userImg];
    
    self.userNName = [[UILabel alloc] initWithFrame:CGRectMake(self.userImg.frame.origin.x + self.userImg.frame.size.width + 10, 20, 200, 20)];
    self.userNName.font = [UIFont systemFontOfSize:15];
    self.userNName.textColor = COLOR(51, 51, 51, 1);
    [self addSubview:self.userNName];
    
    self.jieShaoLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.userNName.frame.origin.x, self.userNName.frame.origin.y + self.userNName.frame.size.height + 5, APP_WIDTH - self.userNName.frame.origin.x - 10, 20)];
    self.jieShaoLabel.font = [UIFont systemFontOfSize:14];
    self.jieShaoLabel.textColor = COLOR(51, 51, 51, 1);
    [self addSubview:self.jieShaoLabel];
    
    self.shanChangImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, self.userImg.frame.origin.y + self.userImg.frame.size.height + 15, 19, 17)];
    self.shanChangImg.image = [UIImage imageNamed:@"擅长领域"];
    [self addSubview:self.shanChangImg];
    
    self.shanChangLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.shanChangImg.frame.origin.x + self.shanChangImg.frame.size.width + 5, self.shanChangImg.frame.origin.y, APP_WIDTH - (self.shanChangImg.frame.origin.x + self.shanChangImg.frame.size.width + 5) - 10, 20)];
    self.shanChangLabel.text = @"擅长领域";
    self.shanChangLabel.font = [UIFont systemFontOfSize:15];
    self.shanChangLabel.textColor = [UIColor blackColor];
    [self addSubview:self.shanChangLabel];
    
    self.shanChangConnectLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.shanChangImg.frame.origin.y + self.shanChangImg.frame.size.height + 15, APP_WIDTH - 30, 50)];
    self.shanChangConnectLabel.numberOfLines = 0;
    self.shanChangConnectLabel.font = [UIFont systemFontOfSize:13];
    self.shanChangConnectLabel.textColor = COLOR(147, 147, 147, 1);
    [self addSubview:self.shanChangConnectLabel];
    
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
