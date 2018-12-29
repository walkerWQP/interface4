//
//  ClassInformationViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/24.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "ClassInformationViewController.h"

@interface ClassInformationViewController ()

@property (nonatomic, strong) UILabel  *headTeacherNameLabel;
@property (nonatomic, strong) UILabel  *keRenTeacherNameLabel;
@property (nonatomic, strong) UILabel  *ClassCommitteeLabel;
@property (nonatomic, strong) UILabel  *ClassCountLabel;
@property (nonatomic, strong) UILabel  *ClassMessageLabel;

@end

@implementation ClassInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"班级信息";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT)];
    backImg.image = [UIImage imageNamed:@"img_class_info_bg"];
    [self.view addSubview:backImg];
    
    UILabel *headTeacher = [[UILabel alloc] initWithFrame:CGRectMake(50, 150, 60, 20)];
    headTeacher.textColor = COLOR(51, 51, 51, 1);
    headTeacher.text = @"班主任:";
    headTeacher.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:15];
    [self.view addSubview:headTeacher];
    
    UILabel *kerenTeacher = [[UILabel alloc] initWithFrame:CGRectMake(35, 180, 70, 20)];
    kerenTeacher.text = @"科任老师:";
    kerenTeacher.textColor = COLOR(51, 51, 51, 1);
    kerenTeacher.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:15];
    [self.view addSubview:kerenTeacher];
    
    UILabel *ClassCommittee = [[UILabel alloc] initWithFrame:CGRectMake(35, 210, 70, 20)];
    ClassCommittee.text = @"班委班干:";
    ClassCommittee.textColor = COLOR(51, 51, 51, 1);
    ClassCommittee.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:15];
    [self.view addSubview:ClassCommittee];

    UILabel *ClassCount = [[UILabel alloc] initWithFrame:CGRectMake(35, 240, 70, 20)];
    ClassCount.text = @"班级人数:";
    ClassCount.textColor = COLOR(51, 51, 51, 1);
    ClassCount.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:15];
    [self.view addSubview:ClassCount];
    
    UILabel *ClassMessage = [[UILabel alloc] initWithFrame:CGRectMake(35, 270, 70, 20)];
    ClassMessage.text = @"班级寄语:";
    ClassMessage.textColor = COLOR(51, 51, 51, 1);
    ClassMessage.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:15];
    [self.view addSubview:ClassMessage];
    
    self.headTeacherNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 150, 120, 20)];
    self.headTeacherNameLabel.text = @"阿刁";
    self.headTeacherNameLabel.textColor = COLOR(51, 51, 51, 1);
    self.headTeacherNameLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.headTeacherNameLabel];

    self.keRenTeacherNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 180, 120, 20)];
    self.keRenTeacherNameLabel.text = @"阿刁(语文)";
    self.keRenTeacherNameLabel.textColor = COLOR(51, 51, 51, 1);
    self.keRenTeacherNameLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.keRenTeacherNameLabel];
    
    self.ClassCommitteeLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 210, 120, 20)];
    self.ClassCommitteeLabel.text = @"暂无";
    self.ClassCommitteeLabel.textColor = COLOR(51, 51, 51, 1);
    self.ClassCommitteeLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.ClassCommitteeLabel];
    
    self.ClassCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 240, 120, 20)];
    self.ClassCountLabel.text = @"5人";
    self.ClassCountLabel.textColor = COLOR(51, 51, 51, 1);
    self.ClassCountLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.ClassCountLabel];
    
    self.ClassMessageLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 270, 120, 20)];
    self.ClassMessageLabel.text = @"1233333";
    self.ClassMessageLabel.textColor = COLOR(51, 51, 51, 1);
    self.ClassMessageLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.ClassMessageLabel];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
