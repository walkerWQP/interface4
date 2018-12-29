//
//  ParentXueTangCell.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/30.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "ParentXueTangCell.h"

@implementation ParentXueTangCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI {
    self.ShiPinListImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 136, 97)];
    self.ShiPinListImg.image = [UIImage imageNamed:@"视频列表"];
    [self addSubview:self.ShiPinListImg];
    self.ShiPinListImg.layer.cornerRadius = 5;
    self.ShiPinListImg.layer.masksToBounds = YES;
    self.ShiPinListImg.contentMode=UIViewContentModeScaleAspectFill;
    self.ShiPinListImg.clipsToBounds=YES;
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.ShiPinListImg.frame.origin.x + self.ShiPinListImg.frame.size.width + 10, 25, kScreenWidth - 10 - 136 - 20, 15)];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.textColor = COLOR(51, 51, 51, 1);
    [self addSubview:self.titleLabel];
    
    self.biaoQianOneImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 5, 31, 16)];
    [self addSubview:self.biaoQianOneImg];
    
    self.biaoQianTwoImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.biaoQianOneImg.frame.origin.x + self.biaoQianOneImg.frame.size.width + 5, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 5, 31, 16)];
    [self addSubview:self.biaoQianTwoImg];
    
    self.biaoQianThreeImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.biaoQianTwoImg.frame.origin.x + self.biaoQianTwoImg.frame.size.width + 5, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 5, 31, 16)];
    [self addSubview:self.biaoQianThreeImg];
    
    //标签3个
    self.biaoQianOneLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 8, 31, 16)];
    self.biaoQianOneLabel.textAlignment = NSTextAlignmentCenter;
    self.biaoQianOneLabel.textColor = RGBA(0, 172, 241, 1);
    self.biaoQianOneLabel.layer.cornerRadius = 3;
    self.biaoQianOneLabel.layer.masksToBounds = YES;
    self.biaoQianOneLabel.layer.borderWidth = 1;
    self.biaoQianOneLabel.layer.borderColor = [UIColor colorWithRed:0 / 255.0 green:172 / 255.0 blue:241 / 255.0 alpha:1].CGColor;
    self.biaoQianOneLabel.font = [UIFont systemFontOfSize:11];
    [self addSubview:self.biaoQianOneLabel];
    
    self.biaoQianTwoLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.biaoQianOneImg.frame.origin.x + self.biaoQianOneImg.frame.size.width + 5, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 8, 31, 16)];
    self.biaoQianTwoLabel.textColor = RGBA(0, 172, 241, 1);
    self.biaoQianTwoLabel.textAlignment = NSTextAlignmentCenter;
    self.biaoQianTwoLabel.font = [UIFont systemFontOfSize:11];
    
    self.biaoQianTwoLabel.layer.cornerRadius = 3;
    self.biaoQianTwoLabel.layer.masksToBounds = YES;
    self.biaoQianTwoLabel.layer.borderWidth = 1;
    self.biaoQianTwoLabel.layer.borderColor = [UIColor colorWithRed:0 / 255.0 green:172 / 255.0 blue:241 / 255.0 alpha:1].CGColor;
    [self addSubview:self.biaoQianTwoLabel];
    
    self.biaoQianThreeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.biaoQianTwoImg.frame.origin.x + self.biaoQianTwoImg.frame.size.width + 5, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 8, 31, 16)];
    self.biaoQianThreeLabel.font = [UIFont systemFontOfSize:11];
    self.biaoQianThreeLabel.textAlignment = NSTextAlignmentCenter;
    self.biaoQianThreeLabel.textColor = RGBA(0, 172, 241, 1);
    
    self.biaoQianThreeLabel.layer.cornerRadius = 3;
    self.biaoQianThreeLabel.layer.masksToBounds = YES;
    self.biaoQianThreeLabel.layer.borderWidth = 1;
    self.biaoQianThreeLabel.layer.borderColor = [UIColor colorWithRed:0 / 255.0 green:172 / 255.0 blue:241 / 255.0 alpha:1].CGColor;
    [self addSubview:self.biaoQianThreeLabel];
    
    self.liulanImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.ShiPinListImg.frame.origin.x + self.ShiPinListImg.frame.size.width + 10, self.biaoQianOneLabel.frame.origin.y + self.biaoQianOneLabel.frame.size.height + 17, 15, 9)];
    self.liulanImg.image = [UIImage imageNamed:@"眼睛"];
    [self addSubview:self.liulanImg];

    self.liulanLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.liulanImg.frame.origin.x + self.liulanImg.frame.size.width + 2, self.liulanImg.frame.origin.y, 70, 10)];
    self.liulanLabel.font = [UIFont systemFontOfSize:10];
    self.liulanLabel.textColor = COLOR(119, 119, 119, 1);
    self.liulanLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.liulanLabel];
    
//    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.ShiPinListImg.frame.origin.y + self.ShiPinListImg.frame.size.height + 10, APP_WIDTH, 10)];
//    self.lineView.backgroundColor = backColor;
//    [self addSubview:self.lineView];
    
    
    self.xuexiLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 56, 97 + 15 - 22, 46, 22)];
    self.xuexiLabel.textColor = [UIColor whiteColor];
    self.xuexiLabel.text = @"学习";
    self.xuexiLabel.font = [UIFont systemFontOfSize:12];
    self.xuexiLabel.textAlignment = NSTextAlignmentCenter;
    self.xuexiLabel.backgroundColor = RGBA(0, 172, 241, 0.3);
    self.xuexiLabel.layer.cornerRadius = 10;
    self.xuexiLabel.layer.masksToBounds = YES;
    [self addSubview:self.xuexiLabel];

    
//    self.JiShuImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.liulanLabel.frame.origin.x + self.liulanLabel.frame.size.width + 5, self.liulanImg.frame.origin.y - 1, 15, 14)];
//    self.JiShuImg.image = [UIImage imageNamed:@"播放"];
//    [self addSubview:self.JiShuImg];
//    
//    self.jiShuLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.JiShuImg.frame.origin.x + self.JiShuImg.frame.size.width + 5 , self.JiShuImg.frame.origin.y, 40, 12)];
//    self.jiShuLabel.font = [UIFont systemFontOfSize:12];
//    self.jiShuLabel.textColor = COLOR(167, 167, 167, 1);
//    [self addSubview:self.jiShuLabel];
    
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
