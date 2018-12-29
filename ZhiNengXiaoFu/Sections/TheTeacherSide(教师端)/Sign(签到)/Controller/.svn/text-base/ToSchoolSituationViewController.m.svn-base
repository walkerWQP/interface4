//
//  ToSchoolSituationViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/8/13.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "ToSchoolSituationViewController.h"
#import "ToSchoolSituationModel.h"

@interface ToSchoolSituationViewController ()

@property (nonatomic, strong) ToSchoolSituationModel *toSchoolSituationModel;
@property (nonatomic, strong) UIImageView            *headImgView;
@property (nonatomic, strong) UILabel                *nameLabel;
@property (nonatomic, strong) UILabel                *timeLabel;
@property (nonatomic, strong) UILabel                *reasonLabel;
@property (nonatomic, strong) UILabel                *remarkLabel;
@property (nonatomic, strong) UILabel                *statusLabel;

@end

@implementation ToSchoolSituationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"请假信息";
    if (self.studentId == nil) {
        [WProgressHUD showErrorAnimatedText:@"数据加载错误,请重试"];
    } else {
        [self getDataFromLeaveLeaveDetail:self.studentId];
    }
    
}

- (void)getDataFromLeaveLeaveDetail:(NSString *)studentId {
    NSDictionary *dic = @{@"key":[UserManager key],@"student_id":studentId};
    [[HttpRequestManager sharedSingleton] POST:studentTodayLeaveURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            self.toSchoolSituationModel = [ToSchoolSituationModel mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
            [self makeToSchoolSituationViewControllerUI];
        } else {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
            } else {
                
            }
            [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}

- (void)makeToSchoolSituationViewControllerUI {
    
    self.view.backgroundColor = backColor;
    self.headImgView = [[UIImageView alloc] initWithFrame:CGRectMake((APP_WIDTH - 60) / 2, 20, 60, 60)];
    self.headImgView.layer.masksToBounds = YES;
    self.headImgView.layer.cornerRadius  = 30;
    if (self.toSchoolSituationModel.head_img == nil) {
        self.headImgView.image = [UIImage imageNamed:@"user"];
    } else {
        [self.headImgView sd_setImageWithURL:[NSURL URLWithString:self.toSchoolSituationModel.head_img] placeholderImage:[UIImage imageNamed:@"user"]];
    }
    [self.view addSubview:self.headImgView];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 40 + self.headImgView.frame.size.height, APP_WIDTH - 40, 30)];
    self.nameLabel.text = [NSString stringWithFormat:@"%@%@",@"姓名:",self.toSchoolSituationModel.name];
    self.nameLabel.textColor = titlColor;
    self.nameLabel.font = titFont;
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.nameLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 60 + self.headImgView.frame.size.height + self.nameLabel.frame.size.height, APP_WIDTH - 40, 30)];
    self.timeLabel.text = [NSString stringWithFormat:@"%@%@ - %@",@"请假时间:",self.toSchoolSituationModel.start,self.toSchoolSituationModel.end];
    self.timeLabel.textColor = titlColor;
    self.timeLabel.font = titFont;
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.timeLabel];
    
    self.reasonLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80 + self.headImgView.frame.size.height + self.nameLabel.frame.size.height + self.timeLabel.frame.size.height, APP_WIDTH - 40, 30)];
    self.reasonLabel.text = [NSString stringWithFormat:@"%@%@",@"请假原因:",self.toSchoolSituationModel.reason];
    self.reasonLabel.textColor = titlColor;
    self.reasonLabel.font = titFont;
    self.reasonLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.reasonLabel];
    
    self.remarkLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 100 + self.headImgView.frame.size.height + self.nameLabel.frame.size.height + self.timeLabel.frame.size.height + self.reasonLabel.frame.size.height, APP_WIDTH - 40, 30)];
    self.remarkLabel.text = [NSString stringWithFormat:@"%@%@",@"请假批注:",self.toSchoolSituationModel.remark];
    self.remarkLabel.textColor = titlColor;
    self.remarkLabel.font = titFont;
    self.remarkLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.remarkLabel];
    
    self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,  120 + self.headImgView.frame.size.height + self.nameLabel.frame.size.height + self.timeLabel.frame.size.height + self.reasonLabel.frame.size.height + self.remarkLabel.frame.size.height, APP_WIDTH - 40, 30)];
    if (self.toSchoolSituationModel.status == 0) {
        self.statusLabel.text = [NSString stringWithFormat:@"%@%@",@"请假处理状态:",@"未处理"];
    } else if (self.toSchoolSituationModel.status == 1) {
        self.statusLabel.text = [NSString stringWithFormat:@"%@%@",@"请假处理状态:",@"已处理"];
    }
    
    self.statusLabel.textColor = titlColor;
    self.statusLabel.font = titFont;
    self.statusLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.statusLabel];
    
}

@end
