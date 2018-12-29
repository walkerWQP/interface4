//
//  LeaveRequestViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/27.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "LeaveRequestViewController.h"

@interface LeaveRequestViewController ()<UITextViewDelegate>


@property (nonatomic, strong) UILabel          *chooseStart;
@property (nonatomic, strong) UILabel          *chooseEnd;
@property (nonatomic, strong) UILabel          *leaveSeason;
@property (nonatomic, strong) UITextView       *leaveSeasonTextView;
@property (nonatomic, strong) STPickerDate     *beginDatePicker;
@property (nonatomic, strong) STPickerDate     *endDatePicker;
@property (nonatomic, assign) NSInteger        typeID;


@end

@implementation LeaveRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"请假申请";
    //请假开始view
    UIView *leaveStart = [[UIView alloc] initWithFrame:CGRectMake(17, 15, APP_WIDTH - 34, 60)];
    leaveStart.layer.cornerRadius = 4;
    leaveStart.layer.masksToBounds = YES;
    leaveStart.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:leaveStart];
    //请假开始时间
    UILabel *leaveStartTime = [[UILabel alloc] initWithFrame:CGRectMake(16, 22, 100, 16)];
    leaveStartTime.text = @"请假开始时间:";
    leaveStartTime.font = [UIFont systemFontOfSize:15];
    leaveStartTime.textColor = COLOR(119, 119, 119, 1);
    [leaveStart addSubview:leaveStartTime];
    
    //选择请假开始时间
    self.chooseStart = [[UILabel alloc] initWithFrame:CGRectMake(APP_WIDTH - 16 - 160, 0, 140, 60)];
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:@"选择请假开始时间"];
    NSRange contentRange = {0, [content length]};
        [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    self.chooseStart.attributedText = content;
    self.chooseStart.textColor = COLOR(170, 170, 170, 1);
    self.chooseStart.font = [UIFont systemFontOfSize:15];
    [leaveStart addSubview:self.chooseStart];
    
    UITapGestureRecognizer *chooseStartTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseStartTap:)];
    self.chooseStart.userInteractionEnabled = YES;
    [self.chooseStart addGestureRecognizer:chooseStartTap];
    
    //请假结束view
    UIView *leaveEnd = [[UIView alloc] initWithFrame:CGRectMake(17, leaveStart.frame.origin.y + leaveStart.frame.size.height + 10, APP_WIDTH - 34, 60)];
    leaveEnd.layer.cornerRadius = 4;
    leaveEnd.layer.masksToBounds = YES;
    leaveEnd.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:leaveEnd];
    //请假结束时间
    UILabel *leaveStartEnd = [[UILabel alloc] initWithFrame:CGRectMake(16, 22, 100, 16)];
    leaveStartEnd.text = @"请假结束时间:";
    leaveStartEnd.font = [UIFont systemFontOfSize:15];
    leaveStartEnd.textColor = COLOR(119, 119, 119, 1);
    [leaveEnd addSubview:leaveStartEnd];
    
    //选择请假结束时间
    self.chooseEnd = [[UILabel alloc] initWithFrame:CGRectMake(APP_WIDTH - 16 - 160, 0, 140, 60)];
    NSMutableAttributedString *content1 = [[NSMutableAttributedString alloc] initWithString:@"选择请假结束时间"];
    NSRange contentRange1 = {0, [content1 length]};
    [content1 addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange1];
    self.chooseEnd.attributedText = content1;
    self.chooseEnd.textColor = COLOR(170, 170, 170, 1);
    self.chooseEnd.font = [UIFont systemFontOfSize:15];
    [leaveEnd addSubview:self.chooseEnd];
    
    UITapGestureRecognizer *chooseEndTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseEndTap:)];
    self.chooseEnd.userInteractionEnabled = YES;
    [self.chooseEnd addGestureRecognizer:chooseEndTap];
    
    //请假原因view
    UIView *leaveSeason = [[UIView alloc] initWithFrame:CGRectMake(17, leaveEnd.frame.size.height + leaveEnd.frame.origin.y  + 10, APP_WIDTH - 34, 200)];
    leaveSeason.layer.cornerRadius = 4;
    leaveSeason.layer.masksToBounds = YES;
    leaveSeason.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:leaveSeason];
    
    //请假原因
    UILabel *leaveSeasonLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 22, 100 , 20)];
    leaveSeasonLabel.text = @"请假原因";
    leaveSeasonLabel.font = [UIFont systemFontOfSize:15];
    leaveSeasonLabel.textColor = COLOR(119, 119, 119, 1);
    [leaveSeason addSubview:leaveSeasonLabel];
    
    //横线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, leaveSeasonLabel.frame.size.height + leaveSeasonLabel.frame.origin.y + 10, leaveSeason.frame.size.width, 1)];
    lineView.backgroundColor = COLOR(229, 229, 229, 1);
    [leaveSeason addSubview:lineView];
    
    //输入框
    self.leaveSeasonTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, lineView.frame.size.height + lineView.frame.origin.y + 15, leaveSeason.frame.size.width - 20, 140)];
    self.leaveSeasonTextView.font = [UIFont systemFontOfSize:15];
    self.leaveSeasonTextView.delegate = self;
    self.leaveSeasonTextView.textColor = COLOR(170, 170, 170, 1);
    self.leaveSeasonTextView.text = @"请输入请假原因...";
    [leaveSeason addSubview:self.leaveSeasonTextView];
    
    UIButton *submit = [[UIButton alloc] initWithFrame:CGRectMake(APP_WIDTH / 2 - 100, leaveSeason.frame.origin.y + leaveSeason.frame.size.height + 30, 200, 40)];
    [submit setTitle:@"提交" forState:UIControlStateNormal];
    [submit setBackgroundColor:tabBarColor];
    submit.layer.cornerRadius = 4;
    submit.layer.masksToBounds = YES;
    [self.view addSubview:submit];
    [submit addTarget:self action:@selector(submitBtn:) forControlEvents:UIControlEventTouchDown];
    submit.userInteractionEnabled = YES;
}

//选择开始时间
- (void)chooseStartTap:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
    self.typeID = 0;
    self.beginDatePicker = [[STPickerDate alloc]initWithDelegate:self];
    [self.beginDatePicker show];
}

//选择结束时间
- (void)chooseEndTap:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
    self.typeID = 1;
    self.endDatePicker = [[STPickerDate alloc]initWithDelegate:self];
    [self.beginDatePicker show];
}

- (void)pickerDate:(STPickerDate *)pickerDate year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    NSString *text = [NSString stringWithFormat:@"%ld-%ld-%ld", year, month, day];
    NSLog(@"%ld",self.typeID);
    if (self.typeID == 0) {
        self.chooseStart.text = text;
    }
    if (self.typeID == 1) {
        self.chooseEnd.text = text;
    }
    
}

#pragma mark - UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView {
    if(textView.text.length < 1) {
        textView.text = @"请输入请假原因...";
        textView.textColor = [UIColor grayColor];
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView {
    if([textView.text isEqualToString:@"请输入请假原因..."]) {
        textView.text=@"";
        textView.textColor=[UIColor blackColor];
    }
}


- (void)submitBtn:(UIButton *)sender {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"youkeState"] isEqualToString:@"1"]) {
        [WProgressHUD showErrorAnimatedText:@"游客不能进行此操作"];
    } else if ([self.chooseStart.text isEqualToString:@"选择请假开始时间"]) {
        [WProgressHUD showErrorAnimatedText:@"请选择请假开始时间"];
    } else if ([self.chooseEnd.text isEqualToString:@"选择请假结束时间"]) {
        [WProgressHUD showErrorAnimatedText:@"请选择请假结束时间"];
    } else {
        if (![self.leaveSeasonTextView.text isEqualToString:@"请输入请假原因..."] && ![self.leaveSeasonTextView.text isEqualToString:@""]) {
            NSDictionary *dic = @{@"key":[UserManager key], @"start":self.chooseStart.text, @"end":self.chooseEnd.text, @"reason":self.leaveSeasonTextView.text};
            [[HttpRequestManager sharedSingleton] POST:leaveAddLeave parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
                if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
                    [WProgressHUD showSuccessfulAnimatedText:[responseObject objectForKey:@"msg"]];
                    [self.navigationController popViewControllerAnimated:YES];
                } else {
                    if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                        [UserManager logoOut];
                    } else {
                        
                    }
                    [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
                }
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"%@", error);
            }];
        } else {
            [WProgressHUD showErrorAnimatedText:@"请输入请假原因..."];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
