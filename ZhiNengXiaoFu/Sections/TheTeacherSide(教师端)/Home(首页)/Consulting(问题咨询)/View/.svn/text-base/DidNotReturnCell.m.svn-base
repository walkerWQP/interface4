//
//  DidNotReturnCell.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/30.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "DidNotReturnCell.h"

@implementation DidNotReturnCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self makeDidNotReturnCellUI];
    }
    return self;
}

- (void)makeDidNotReturnCellUI {
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 60, 60)];
    self.headImgView.layer.masksToBounds = YES;
    self.headImgView.layer.cornerRadius = 30;
    [self.contentView addSubview:self.headImgView];
    
    self.problemLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 + self.headImgView.frame.size.width, 10, self.contentView.frame.size.width - self.headImgView.frame.size.width - 30, 30)];
    self.problemLabel.textColor = RGB(170, 170, 170);
    self.problemLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.problemLabel];
    
    self.problemContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 + self.headImgView.frame.size.height, self.contentView.frame.size.width - 20, 60)];
    self.problemContentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.problemContentLabel.numberOfLines = 0;
    self.problemContentLabel.textColor = titlColor;
    self.problemContentLabel.font = titFont;
    [self.contentView addSubview:self.problemContentLabel];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(10,self.headImgView.frame.size.height + self.problemContentLabel.frame.size.height + 10, self.contentView.frame.size.width - 20, 1)];
    self.lineView.backgroundColor = fengeLineColor;
    [self.contentView addSubview:self.lineView];
    
    self.answerBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, self.headImgView.frame.size.height + self.problemContentLabel.frame.size.height + 40, 90, 30)];
    self.answerBtn.layer.masksToBounds = YES;
    self.answerBtn.layer.cornerRadius  = 5;
    self.answerBtn.titleLabel.font = titFont;
    self.answerBtn.backgroundColor = RGB(0, 186, 255);
    [self.answerBtn setTitle:@"回答咨询" forState:UIControlStateNormal];
    [self.answerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.answerBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.contentView addSubview:self.answerBtn];
    
}

@end
