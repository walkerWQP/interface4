//
//  TuiChuLoginCell.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/21.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "TuiChuLoginCell.h"

@implementation TuiChuLoginCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.tuichuLoginBtn];
    }
    return self;
}

- (UIButton *)tuichuLoginBtn {
    if (!_tuichuLoginBtn) {
        self.tuichuLoginBtn = [[UIButton alloc] initWithFrame:CGRectMake(75, 0, APP_WIDTH - 150, 50)];
        [self.tuichuLoginBtn setTitle:@"退出账号" forState:UIControlStateNormal];
        self.tuichuLoginBtn.titleLabel.font = [UIFont systemFontOfSize: 13.0];
        [self.tuichuLoginBtn setTitleColor:[UIColor colorWithRed:235 / 255.0 green:7 / 255.0 blue:25 / 255.0 alpha:1] forState:UIControlStateNormal];
        
//        [self.tuichuLoginBtn setBackgroundColor:THEMECOLOR];
    }
    return _tuichuLoginBtn;
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
