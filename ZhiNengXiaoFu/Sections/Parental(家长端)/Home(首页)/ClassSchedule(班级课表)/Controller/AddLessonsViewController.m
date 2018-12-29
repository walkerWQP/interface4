//
//  AddLessonsViewController.m
//  ZhiNengXiaoFu
//
//  Created by 独秀科技 on 2018/12/18.
//  Copyright © 2018 henanduxiu. All rights reserved.
//

#import "AddLessonsViewController.h"

@interface AddLessonsViewController ()<DateTimePickerViewDelegate>

@property (nonatomic, strong) UIView             *beginView;
@property (nonatomic, strong) UIImageView        *beginImgView;
@property (nonatomic, strong) UILabel            *beginLabel;
@property (nonatomic, strong) UILabel            *beginTimeLabel;
@property (nonatomic, strong) UIImageView        *beginImg;

@property (nonatomic, strong) UIView             *endView;
@property (nonatomic, strong) UIImageView        *endImgView;
@property (nonatomic, strong) UILabel            *endLabel;
@property (nonatomic, strong) UILabel            *endTimeLabel;
@property (nonatomic, strong) UIImageView        *endImg;

@property (nonatomic, strong) UIButton           *subimtBtn;
@property (nonatomic, assign) NSInteger          typeID;
@property (nonatomic, strong) DateTimePickerView *datePickerView;


@end

@implementation AddLessonsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加课节";
    [self makeAddLessonsViewControllerUI];
    NSLog(@"%@",self.class_id);
}

- (void)makeAddLessonsViewControllerUI {
    
    self.beginView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, APP_WIDTH, 40)];
    self.beginView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.beginView];
    
    self.beginImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 20, 20)];
    self.beginImgView.image = [UIImage imageNamed:@"时间1"];
    [self.beginView addSubview:self.beginImgView];
    
    self.beginLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 100, 30)];
    self.beginLabel.textColor = [UIColor blackColor];
    self.beginLabel.font = [UIFont systemFontOfSize:14];
    self.beginLabel.text = @"请选择上课时间";
    [self.beginView addSubview:self.beginLabel];
    
    self.beginTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(APP_WIDTH - 100, 5, 60, 30)];
    self.beginTimeLabel.textColor = RGB(136, 136, 136);
    self.beginTimeLabel.font = [UIFont systemFontOfSize:14];
    if (self.begintStr != nil) {
        self.beginTimeLabel.text = self.begintStr;
    }
    [self.beginView addSubview:self.beginTimeLabel];
    
    self.beginImg = [[UIImageView alloc] initWithFrame:CGRectMake(APP_WIDTH - 40, 12.5, 10, 15)];
    self.beginImg.image = [UIImage imageNamed:@"箭头new"];
    [self.beginView addSubview:self.beginImg];
    
    UIButton *beginTimeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 40)];
    beginTimeBtn.backgroundColor = [UIColor clearColor];
    [beginTimeBtn addTarget:self action:@selector(beginTimeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.beginView addSubview:beginTimeBtn];
    
    self.endView = [[UIView alloc] initWithFrame:CGRectMake(0, 60, APP_WIDTH, 40)];
    self.endView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.endView];
    
    self.endImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 20, 20)];
    self.endImgView.image = [UIImage imageNamed:@"时间1"];
    [self.endView addSubview:self.endImgView];
    
    self.endLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 100, 30)];
    self.endLabel.textColor = [UIColor blackColor];
    self.endLabel.font = [UIFont systemFontOfSize:14];
    self.endLabel.text = @"请选择下课时间";
    [self.endView addSubview:self.endLabel];
    
    self.endTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(APP_WIDTH - 100, 5, 60, 30)];
    self.endTimeLabel.textColor = RGB(136, 136, 136);
    self.endTimeLabel.font = [UIFont systemFontOfSize:14];
    if (self.endStr != nil) {
        self.endTimeLabel.text = self.endStr;
    }
    [self.endView addSubview:self.endTimeLabel];
    
    self.endImg = [[UIImageView alloc] initWithFrame:CGRectMake(APP_WIDTH - 40, 12.5, 10, 15)];
    self.endImg.image = [UIImage imageNamed:@"箭头new"];
    [self.endView addSubview:self.endImg];
    
    UIButton *endTimeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 40)];
    endTimeBtn.backgroundColor = [UIColor clearColor];
    [endTimeBtn addTarget:self action:@selector(endTimeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.endView addSubview:endTimeBtn];
    
    self.subimtBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, 300, APP_WIDTH - 80, 40)];
    self.subimtBtn.backgroundColor = THEMECOLOR;
    [self.subimtBtn setTitle:@"提交" forState:UIControlStateNormal];
    self.subimtBtn.layer.masksToBounds = YES;
    self.subimtBtn.layer.cornerRadius = 5;
    self.subimtBtn.layer.borderColor = fengeLineColor.CGColor;
    self.subimtBtn.layer.borderWidth = 1.0f;
    self.subimtBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.subimtBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.subimtBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.subimtBtn addTarget:self action:@selector(subimtBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.subimtBtn];
    
    
}

- (void)beginTimeBtn:(UIButton *)sender {
    NSLog(@"开始时间选择");
    self.typeID = 1;
    DateTimePickerView *pickerView = [[DateTimePickerView alloc] init];
    self.datePickerView = pickerView;
    pickerView.delegate = self;
    pickerView.pickerViewMode = DatePickerViewTimeMode;
    [self.view addSubview:pickerView];
    [pickerView showDateTimePickerView];
    
}

- (void)endTimeBtn:(UIButton *)sender {
    NSLog(@"结束时间选择");
    self.typeID = 2;
    DateTimePickerView *pickerView = [[DateTimePickerView alloc] init];
    self.datePickerView = pickerView;
    pickerView.delegate = self;
    pickerView.pickerViewMode = DatePickerViewTimeMode;
    [self.view addSubview:pickerView];
    [pickerView showDateTimePickerView];
}

#pragma mark - delegate

- (void)didClickFinishDateTimePickerView:(NSString *)date{
    NSLog(@"%@",date);
    switch (self.typeID) {
        case 1:
            {
                self.beginTimeLabel.text = date;
            }
            break;
        case 2:
        {
            self.endTimeLabel.text = date;
        }
            break;
            
        default:
            break;
    }
}


- (void)subimtBtn:(UIButton *)sender {
    NSLog(@"点击提交"); //AddTimeURL
    
    if ([self.typeStr isEqualToString:@"1"]) {
        if ([self.beginTimeLabel.text isEqualToString:self.begintStr] && [self.endTimeLabel.text isEqualToString:self.endStr]) {
            [WProgressHUD showErrorAnimatedText:@"您未做出修改"];
            return;
        } else {
            [self compareDate:self.beginTimeLabel.text withDate:self.endTimeLabel.text];
            int comparisonResult = [self compareDate:self.beginTimeLabel.text withDate:self.endTimeLabel.text];
            if(comparisonResult >= 0){
                //endDate 大
                NSLog(@"上课时间大于等于下课时间");
                
                if (self.class_id != nil) {
                     NSDictionary *dic = @{@"key":[UserManager key],@"id":self.class_id,@"start":[NSString stringWithFormat:@"%@:00",self.beginTimeLabel.text],@"end":[NSString stringWithFormat:@"%@:00",self.endTimeLabel.text]};
                    [self UpdateTimeURLData:dic];
                }
                
            } else {
                [WProgressHUD showErrorAnimatedText:@"下课时间应小于上课时间"];
                self.beginTimeLabel.text = nil;
                self.endTimeLabel.text   = nil;
                return;
            }
        }
    } else {
        NSLog(@"%@",self.typeStr);
        if (self.beginTimeLabel.text == nil) {
            [WProgressHUD showErrorAnimatedText:@"请选择上课时间"];
            return;
        } else if (self.endTimeLabel.text == nil) {
            [WProgressHUD showErrorAnimatedText:@"请选择下课时间"];
            return;
        } else {
            
            [self compareDate:self.beginTimeLabel.text withDate:self.endTimeLabel.text];
            int comparisonResult = [self compareDate:self.beginTimeLabel.text withDate:self.endTimeLabel.text];
            if(comparisonResult >= 0){
                //endDate 大
                NSLog(@"上课时间大于等于下课时间");
                
                if (self.class_id != nil) {
                    [self AddTimeURLData];
                }
                
            } else {
                [WProgressHUD showErrorAnimatedText:@"下课时间应小于上课时间"];
                self.beginTimeLabel.text = nil;
                self.endTimeLabel.text   = nil;
                return;
            }
        }
    }
}


- (void)UpdateTimeURLData:(NSDictionary *)dic {
    [WProgressHUD showHUDShowText:@"正在修改中..."];
    [[HttpRequestManager sharedSingleton] POST:UpdateTimeURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
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

- (void)AddTimeURLData {
    [WProgressHUD showHUDShowText:@"数据发送中..."];
    NSDictionary *dic = @{@"key":[UserManager key],@"start":[NSString stringWithFormat:@"%@:00",self.beginTimeLabel.text],@"end":[NSString stringWithFormat:@"%@:00",self.endTimeLabel.text],@"class_id":self.class_id};
    [[HttpRequestManager sharedSingleton] POST:AddTimeURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        [WProgressHUD hideAllHUDAnimated:YES];
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


//比较两个日期的大小
-(int)compareDate:(NSString*)startDate withDate:(NSString*)endDate{

    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *currentDateStr = [dateFormatter stringFromDate:currentDate];

    startDate = [NSString stringWithFormat:@"%@ %@:00",currentDateStr,startDate];
    endDate   = [NSString stringWithFormat:@"%@ %@:00",currentDateStr,endDate];

    int ci = 0;

    NSDateFormatter *df = [[NSDateFormatter alloc]init];

    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    NSDate *dt1 = [[NSDate alloc]init];

    NSDate *dt2 = [[NSDate alloc]init];

    dt1 = [df dateFromString:startDate];

    dt2 = [df dateFromString:endDate];

    NSComparisonResult result = [dt1 compare: dt2];
    
    if (result == NSOrderedSame) {
        //相等
        ci = 0;
    } else if (result == NSOrderedAscending) {
        //结束时间大于开始时间
        ci = 1;
    } else if (result == NSOrderedDescending) {
        //结束时间小于开始时间
        ci = -1;
    }
    
    return ci;
}







@end
