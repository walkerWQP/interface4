//
//  MinePersonXiXinCell.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/21.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "MinePersonXiXinCell.h"

@implementation MinePersonXiXinCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.userImg];
        [self addSubview:self.userName];
        [self addSubview:self.userZiLiao];
//        [self addSubview:self.nextImg];
    }
    return self;
}

- (UIImageView *)userImg {
    if (!_userImg) {
        self.userImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 60, 60)];
        self.userImg.layer.cornerRadius = 30;
        self.userImg.layer.masksToBounds = YES;
    }
    return _userImg;
}

- (UILabel *)userName {
    if (!_userName) {
        self.userName = [[UILabel alloc] initWithFrame:CGRectMake(self.userImg.frame.size.width + self.userImg.frame.origin.x + 15, 22, 100, 20)];
        self.userName.textColor = [UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1];
        self.userName.font = [UIFont systemFontOfSize:15];
    }
    return _userName;
}

- (UILabel *)userZiLiao {
    if (!_userZiLiao) {
        self.userZiLiao = [[UILabel alloc] initWithFrame:CGRectMake(self.userImg.frame.size.width + self.userImg.frame.origin.x + 15, self.userName.frame.origin.y + self.userName.frame.size.height + 5, 100, 20)];
        self.userZiLiao.textColor = [UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1];
        self.userZiLiao.font = [UIFont systemFontOfSize:15];
    }
    return _userZiLiao;
}


//- (UIImageView *)nextImg
//{
//    if (!_nextImg) {
//        self.nextImg = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 20 - 11.5, 45 - 8, 11.5, 16)];
//        self.nextImg.image = [UIImage imageNamed:@"more"];
//    }
//    return _nextImg;
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
