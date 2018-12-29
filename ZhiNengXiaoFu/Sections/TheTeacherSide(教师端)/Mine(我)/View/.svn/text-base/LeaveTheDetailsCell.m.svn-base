//
//  LeaveTheDetailsCell.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/8/6.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "LeaveTheDetailsCell.h"

@implementation LeaveTheDetailsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeLeaveTheDetailsCellUI];
    }
    return self;
}

- (void)makeLeaveTheDetailsCellUI {
    
    self.backgroundColor = backColor;
    self.typeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 50)];
    self.typeView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.typeView];
    
    self.typeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 20, 28)];
    self.typeImgView.image = [UIImage imageNamed:@"请加状态"];
    [self.typeView addSubview:self.typeImgView];
    
    self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.typeImgView.frame.size.width + 20, 10, APP_WIDTH * 0.6, 30)];
    self.typeLabel.text = @"请假状态";
    self.typeLabel.textColor = titlColor;
    self.typeLabel.font = titFont;
    [self.typeView addSubview:self.typeLabel];
    
    self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(APP_WIDTH - 100, 5, 90, 30)];
    self.statusLabel.font = titFont;
    [self.typeView addSubview:self.statusLabel];
    
    self.whyView = [[UIView alloc] initWithFrame:CGRectMake(0, self.typeView.frame.size.height + 20, APP_WIDTH, 100)];
    self.whyView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.whyView];
    
    self.whyImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 20, 28)];
    self.whyImgView.image = [UIImage imageNamed:@"请假原因"];
    [self.whyView addSubview:self.whyImgView];
    
    self.whyLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 + self.whyImgView.frame.size.width, 10, APP_WIDTH * 0.6, 30)];
    self.whyLabel.text = @"请假原因:";
    self.whyLabel.tintColor = titlColor;
    self.whyLabel.font = titFont;
    [self.whyView addSubview:self.whyLabel];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49, APP_WIDTH, 1)];
    self.lineView.backgroundColor = fengeLineColor;
    [self.whyView addSubview:self.lineView];
    
    self.reasonLeaveLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, APP_WIDTH - 40, 30)];
    self.reasonLeaveLabel.textColor = titlColor;
    self.reasonLeaveLabel.font = contentFont;
    [self.whyView addSubview:self.reasonLeaveLabel];
    
    self.noteView = [[UIView alloc] initWithFrame:CGRectMake(0, self.typeView.frame.size.height + self.whyView.frame.size.height + 40, APP_WIDTH, 150)];
    self.noteView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.noteView];
    
    self.noteImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 20, 28)];
    self.noteImgView.image = [UIImage imageNamed:@"备注"];
    [self.noteView addSubview:self.noteImgView];
    
    self.noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.noteImgView.frame.size.width + 20, 10, APP_WIDTH * 0.6, 30)];
    self.noteLabel.text = @"备注:";
    self.noteLabel.textColor = titlColor;
    self.noteLabel.font = titFont;
    [self.noteView addSubview:self.noteLabel];
    
    self.lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 49, APP_WIDTH, 1)];
    self.lineView1.backgroundColor = fengeLineColor;
    [self.noteView addSubview:self.lineView1];
    
    self.noteTextView = [[WTextView alloc] initWithFrame:CGRectMake(20, 60, APP_WIDTH - 40, 70)];
    self.noteTextView.placeholder = @"请输入审核内容";
    self.noteTextView.backgroundColor = backColor;
    [self.noteView addSubview:self.noteTextView];
    
    self.submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, self.typeView.frame.size.height + self.whyView.frame.size.height + self.noteView.frame.size.height + 60, APP_WIDTH - 40, 40)];
    self.submitBtn.backgroundColor = THEMECOLOR;
    [self.submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [self.submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.submitBtn.layer.masksToBounds = YES;
    self.submitBtn.layer.cornerRadius = 5;
    self.submitBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:self.submitBtn];
    
}

@end
