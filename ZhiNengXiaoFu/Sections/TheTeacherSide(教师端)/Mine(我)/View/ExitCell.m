//
//  ExitCell.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/24.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "ExitCell.h"

@implementation ExitCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.exitBtn];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (UIButton *)exitBtn {
    if (!_exitBtn) {
        self.exitBtn = [[UIButton alloc] initWithFrame:CGRectMake(75, 0, APP_WIDTH - 150, 50)];
        self.exitBtn.layer.masksToBounds = YES;
        self.exitBtn.layer.cornerRadius = 25;
        self.exitBtn.backgroundColor = RGB(255, 144, 144);
        [self.exitBtn setTitle:@"退出账号" forState:UIControlStateNormal];
        self.exitBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:15];
        [self.exitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _exitBtn;
}

@end
