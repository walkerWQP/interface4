//
//  WenTiZiXunListCell.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/31.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "WenTiZiXunListCell.h"

@implementation WenTiZiXunListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI {
    
    self.lineViewT = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 10)];
    self.lineViewT.backgroundColor = COLOR(247, 247, 247, 1);
    [self addSubview:self.lineViewT];
    
    self.userIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15,self.lineViewT.frame.origin.y + self.lineViewT.frame.size.height + 10, 40, 40)];
    self.userIcon.layer.cornerRadius = 20;
    self.userIcon.layer.masksToBounds = YES;
    [self addSubview:self.userIcon];
    
    self.userName = [[UILabel alloc] initWithFrame:CGRectMake(self.userIcon.frame.origin.x + self.userIcon.frame.size.width + 10, self.lineViewT.frame.origin.y + self.lineViewT.frame.size.height + 20, 200, 20)];
    self.userName.font = [UIFont systemFontOfSize:14];
    self.userName.textColor = COLOR(147, 147, 147, 1);
    [self addSubview:self.userName];
    
    self.questionLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.userIcon.frame.origin.y + self.userIcon.frame.size.height + 5, APP_WIDTH - 30, 20)];
    self.questionLabel.textColor = COLOR(147, 147, 147, 1);
    self.questionLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.questionLabel];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(15, self.questionLabel.frame.origin.y + self.questionLabel.frame.size.height + 5, APP_WIDTH - 15, 1)];
    self.lineView.backgroundColor = COLOR(224, 224, 224, 1);
    [self addSubview:self.lineView];
    
    
    self.userIconT = [[UIImageView alloc] initWithFrame:CGRectMake( 15, self.lineView.frame.origin.y +  self.lineView.frame.size.height + 10, 40, 40)];
    self.userIconT.layer.cornerRadius = 20;
    self.userIconT.layer.masksToBounds = YES;
    [self addSubview:self.userIconT];
    
    self.userNameT = [[UILabel alloc] initWithFrame:CGRectMake(self.userIconT.frame.origin.x + self.userIconT.frame.size.width + 10, self.lineView.frame.origin.y +  self.lineView.frame.size.height + 20, 200, 20)];
    self.userNameT.font = [UIFont systemFontOfSize:14];
    self.userNameT.textColor = COLOR(147, 147, 147, 1);
    [self addSubview:self.userNameT];
    
    self.questionLabelT = [[UILabel alloc] initWithFrame:CGRectMake(15, self.userIconT.frame.origin.y + self.userIconT.frame.size.height + 5, APP_WIDTH - 30, 20)];
    self.questionLabelT.textColor = COLOR(147, 147, 147, 1);
    self.questionLabelT.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.questionLabelT];
    
    
    
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
