//
//  TeacherNotifiedCell.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/27.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "TeacherNotifiedCell.h"

@implementation TeacherNotifiedCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self makeSchoolDynamicCellCellUI];
    }
    return self;
}

- (void)makeSchoolDynamicCellCellUI {
    self.backgroundColor = [UIColor whiteColor];
    self.headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 60, 60)];
    self.headImgView.layer.cornerRadius = 5;
    self.headImgView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.headImgView];
    
    self.classLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 + self.headImgView.frame.size.width, 20, APP_WIDTH * 0.6, 30)];
    self.classLabel.font = titFont;
    self.classLabel.textColor = titlColor;
    [self.contentView addSubview:self.classLabel];
    
    self.rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(APP_WIDTH - 40, 25, 20, 20)];
    [self.rightBtn setImage:[UIImage imageNamed:@"返回(1)拷贝"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.rightBtn];
    
}

@end
