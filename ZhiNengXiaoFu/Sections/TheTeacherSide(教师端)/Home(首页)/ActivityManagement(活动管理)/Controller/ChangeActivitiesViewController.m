//
//  ChangeActivitiesViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/8/13.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "ChangeActivitiesViewController.h"

@interface ChangeActivitiesViewController ()<UITextFieldDelegate,LQPhotoPickerViewDelegate,HQPickerViewDelegate,UIScrollViewDelegate,STPickerDateDelegate>


//活动标题
@property (nonatomic, strong) UILabel        *titleLabel;
@property (nonatomic, strong) UITextField    *titleTextField;
//时间
@property (nonatomic, strong) UILabel        *timeLabel;
@property (nonatomic, strong) UIView         *timeView;
@property (nonatomic, strong) UILabel        *changeLabel;
@property (nonatomic, strong) UIButton       *beginTimeBtn;
@property (nonatomic, strong) UIButton       *endTimeBtn;
//活动简介
@property (nonatomic, strong) UILabel        *introductionLabel;
@property (nonatomic, strong) WTextView      *introductionTextView;
//发送班级活动
@property (nonatomic, strong) UIButton       *releaseBtn;
@property (nonatomic, assign) NSInteger      timeID;
@property (nonatomic, strong) UIScrollView   *launchEventScrollView;

@property (nonatomic, strong) STPickerDate     *beginDatePicker;
@property (nonatomic, strong) STPickerDate     *endDatePicker;
@property (nonatomic, assign) NSInteger        typeID;

@end

@implementation ChangeActivitiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改活动";
    [self makeChangeActivitiesViewControllerUI];
}

- (void)makeChangeActivitiesViewControllerUI {
    
    self.launchEventScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT)];
    self.launchEventScrollView.backgroundColor = backColor;
    self.launchEventScrollView.contentSize = CGSizeMake(APP_WIDTH, APP_HEIGHT * 1.5);
    self.launchEventScrollView.bounces = YES;
    self.launchEventScrollView.indicatorStyle = UIScrollViewIndicatorStyleDefault;
    self.launchEventScrollView.maximumZoomScale = 2.0;//最多放大到两倍
    self.launchEventScrollView.minimumZoomScale = 0.5;//最多缩小到0.5倍
    //设置是否允许缩放超出倍数限制，超出后弹回
    self.launchEventScrollView.bouncesZoom = YES;
    //设置委托
    self.launchEventScrollView.delegate = self;
    [self.view addSubview:self.launchEventScrollView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, APP_WIDTH - 20, 30)];
    self.titleLabel.textColor = titlColor;
    self.titleLabel.font = titFont;
    self.titleLabel.text = @"活动标题";
    [self.launchEventScrollView addSubview:self.titleLabel];
    
    self.titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, self.titleLabel.frame.size.height + 10, APP_WIDTH - 20, 40)];
    self.titleTextField.backgroundColor = [UIColor whiteColor];
    self.titleTextField.layer.masksToBounds = YES;
    self.titleTextField.layer.cornerRadius = 5;
    self.titleTextField.layer.borderColor = fengeLineColor.CGColor;
    self.titleTextField.layer.borderWidth = 1.0f;
    self.titleTextField.font = contentFont;
    self.titleTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入活动标题" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]}];
    self.titleTextField.delegate = self;
    self.titleTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.titleTextField.text = self.titleStr;
    [self.launchEventScrollView addSubview:self.titleTextField];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.titleLabel.frame.size.height + self.titleTextField.frame.size.height + 20, APP_WIDTH - 20, 30)];
    self.timeLabel.textColor = titlColor;
    self.timeLabel.font = titFont;
    self.timeLabel.text = @"时间";
    [self.launchEventScrollView addSubview:self.timeLabel];
    
    self.timeView = [[UIView alloc] initWithFrame:CGRectMake(10, self.titleLabel.frame.size.height + self.titleTextField.frame.size.height + self.timeLabel.frame.size.height + 20, APP_WIDTH - 20, 40)];
    self.timeView.backgroundColor = [UIColor whiteColor];
    self.timeView.layer.masksToBounds = YES;
    self.timeView.layer.cornerRadius = 5;
    self.timeView.layer.borderColor = fengeLineColor.CGColor;
    self.timeView.layer.borderWidth = 1.0f;
    [self.launchEventScrollView addSubview:self.timeView];
    
    self.changeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 40, 30)];
    self.changeLabel.text = @"请选择";
    self.changeLabel.textColor = backTitleColor;
    self.changeLabel.font = contentFont;
    [self.timeView addSubview:self.changeLabel];
    
    self.beginTimeBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.changeLabel.frame.size.width + 15, 5, (self.timeView.frame.size.width - self.changeLabel.frame.size.width - 25) / 2, 30)];
    self.beginTimeBtn.layer.masksToBounds = YES;
    self.beginTimeBtn.layer.cornerRadius = 5;
    self.beginTimeBtn.layer.borderColor = fengeLineColor.CGColor;
    self.beginTimeBtn.layer.borderWidth = 1.0f;
    [self.beginTimeBtn setTitle:@"开始时间" forState:UIControlStateNormal];
    self.beginTimeBtn.titleLabel.font = contentFont;
    [self.beginTimeBtn setTitleColor:backTitleColor forState:UIControlStateNormal];
    [self.beginTimeBtn addTarget:self action:@selector(beginTimeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.beginTimeBtn setTitle:self.start forState:UIControlStateNormal];
    [self.timeView addSubview:self.beginTimeBtn];
    
    self.endTimeBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.timeView.frame.size.width - self.beginTimeBtn.frame.size.width - 5, 5, self.beginTimeBtn.frame.size.width, 30)];
    self.endTimeBtn.layer.masksToBounds = YES;
    self.endTimeBtn.layer.cornerRadius = 5;
    self.endTimeBtn.layer.borderColor = fengeLineColor.CGColor;
    self.endTimeBtn.layer.borderWidth = 1.0f;
    [self.endTimeBtn setTitle:@"结束时间" forState:UIControlStateNormal];
    self.endTimeBtn.titleLabel.font = contentFont;
    [self.endTimeBtn setTitleColor:backTitleColor forState:UIControlStateNormal];
    [self.endTimeBtn addTarget:self action:@selector(endTimeBtnBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.endTimeBtn setTitle:self.end forState:UIControlStateNormal];
    [self.timeView addSubview:self.endTimeBtn];
    
    self.introductionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.titleLabel.frame.size.height + self.titleTextField.frame.size.height + self.timeLabel.frame.size.height + self.timeView.frame.size.height + 40, APP_WIDTH - 20, 30)];
    self.introductionLabel.text = @"活动简介";
    self.introductionLabel.textColor = titlColor;
    self.introductionLabel.font = contentFont;
    [self.launchEventScrollView addSubview:self.introductionLabel];
    
    self.introductionTextView = [[WTextView alloc] initWithFrame:CGRectMake(10, self.titleLabel.frame.size.height + self.titleTextField.frame.size.height + self.timeLabel.frame.size.height + self.timeView.frame.size.height + self.introductionLabel.frame.size.height + 40, APP_WIDTH - 20, 200)];
    self.introductionTextView.backgroundColor = [UIColor whiteColor];
    self.introductionTextView.layer.masksToBounds = YES;
    self.introductionTextView.layer.cornerRadius = 5;
    self.introductionTextView.layer.borderColor = fengeLineColor.CGColor;
    self.introductionTextView.layer.borderWidth = 1.0f;
    self.introductionTextView.font = contentFont;
    self.introductionTextView.placeholder = @"请输入活动内容...";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.introductionTextView.text = self.introduction;
    [self.launchEventScrollView addSubview:self.introductionTextView];
    
    self.releaseBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, self.titleLabel.frame.size.height + self.titleTextField.frame.size.height + self.timeLabel.frame.size.height + self.timeView.frame.size.height + self.introductionLabel.frame.size.height + self.introductionTextView.frame.size.height + 70, APP_WIDTH - 40, 40)];
    self.releaseBtn.backgroundColor = THEMECOLOR;
    [self.releaseBtn setTitle:@"发布修改" forState:UIControlStateNormal];
    self.releaseBtn.layer.masksToBounds = YES;
    self.releaseBtn.layer.cornerRadius = 5;
    self.releaseBtn.layer.borderColor = fengeLineColor.CGColor;
    self.releaseBtn.layer.borderWidth = 1.0f;
    self.releaseBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.releaseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.releaseBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.releaseBtn addTarget:self action:@selector(releaseBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.launchEventScrollView addSubview:self.releaseBtn];
    self.launchEventScrollView.backgroundColor = backColor;
}

- (void)releaseBtn:(UIButton *)sender {
    NSLog(@"发布修改");
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"youkeState"] isEqualToString:@"1"]) {
        [WProgressHUD showErrorAnimatedText:@"游客不能进行此操作"];
        return;
    }
    
    if ([self.titleTextField.text isEqualToString:@""]) {
        [WProgressHUD showErrorAnimatedText:@"活动标题不能为空"];
        return;
    }
    
    if ([self.beginTimeBtn.titleLabel.text isEqualToString:@"开始时间"]) {
        [WProgressHUD showErrorAnimatedText:@"请选择活动开始时间"];
        return;
    }
    
    if ([self.endTimeBtn.titleLabel.text isEqualToString:@"结束时间"]) {
        [WProgressHUD showErrorAnimatedText:@"请选择活动结束时间"];
        return;
    }
    
    if (![self.beginTimeBtn.titleLabel.text isEqualToString:@"开始时间"] && ![self.endTimeBtn.titleLabel.text isEqualToString:@"结束时间"]) {
        NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
        [dateformater setDateFormat:@"yyyy-MM-dd"];
        NSDate *dta = [[NSDate alloc] init];
        NSDate *dtb = [[NSDate alloc] init];
        
        dta = [dateformater dateFromString:self.beginTimeBtn.titleLabel.text];
        dtb = [dateformater dateFromString:self.endTimeBtn.titleLabel.text];
        NSComparisonResult result = [dta compare:dtb];
        if (result == NSOrderedDescending) {
            //bDate比aDate小
            NSLog(@"第二个比第一个小");
            [WProgressHUD showErrorAnimatedText:@"开始时间不能小于结束时间"];
            [self.beginTimeBtn setTitle:@"开始时间" forState:UIControlStateNormal];
            [self.endTimeBtn setTitle:@"结束时间" forState:UIControlStateNormal];
            return;
        }
    }
    
    if ([self.introductionTextView.text isEqualToString:@""]) {
        [WProgressHUD showErrorAnimatedText:@"请输入活动内容"];
        return;
    } else {
        NSDictionary *dic  = @{@"key":[UserManager key],@"title":self.titleTextField.text,@"start":self.beginTimeBtn.titleLabel.text,@"end":self.endTimeBtn.titleLabel.text,@"id":self.ID,@"introduction":self.introductionTextView.text};
        [self updateActivityURLForData:dic];
    }
    
}

- (void)updateActivityURLForData:(NSDictionary *)dic {
    [[HttpRequestManager sharedSingleton] POST:updateActivityURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
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
    }];
}

- (void)endTimeBtnBtn : (UIButton *)sender {
    NSLog(@"点击结束时间");
    [self.view endEditing:YES];
//    self.timeID = 0;
//    [self setupDateView:DateTypeOfEnd];
    self.typeID = 1;
    self.endDatePicker = [[STPickerDate alloc]initWithDelegate:self];
    [self.beginDatePicker show];
}

- (void)beginTimeBtn : (UIButton *)sender {
    NSLog(@"点击开始时间");
    [self.view endEditing:YES];
//    self.timeID = 0;
//    [self setupDateView:DateTypeOfStart];
//    [self.endTimeBtn setTitle:@"结束时间" forState:UIControlStateNormal];
    self.typeID = 0;
    self.beginDatePicker = [[STPickerDate alloc]initWithDelegate:self];
    [self.beginDatePicker show];
}

- (void)pickerDate:(STPickerDate *)pickerDate year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    NSString *text = [NSString stringWithFormat:@"%ld-%ld-%ld", year, month, day];
    NSLog(@"%ld",self.typeID);
    if (self.typeID == 0) {
        [self.beginTimeBtn setTitle:text forState:UIControlStateNormal];
    }
    if (self.typeID == 1) {
        [self.endTimeBtn setTitle:text forState:UIControlStateNormal];
    }
    
}






@end
