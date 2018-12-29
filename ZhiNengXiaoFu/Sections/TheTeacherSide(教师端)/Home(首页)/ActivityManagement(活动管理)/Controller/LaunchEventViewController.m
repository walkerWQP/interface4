//
//  LaunchEventViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/28.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "LaunchEventViewController.h"
#import "TeacherNotifiedModel.h"
#import <Photos/Photos.h>
@interface LaunchEventViewController ()<UITextFieldDelegate,LQPhotoPickerViewDelegate,PickerViewResultDelegate,UIScrollViewDelegate,STPickerDateDelegate>


//活动标题
@property (nonatomic, strong) UILabel          *titleLabel;
@property (nonatomic, strong) UITextField      *titleTextField;
//时间
@property (nonatomic, strong) UILabel          *timeLabel;
@property (nonatomic, strong) UIView           *timeView;
@property (nonatomic, strong) UILabel          *changeLabel;
@property (nonatomic, strong) UIButton         *beginTimeBtn;
@property (nonatomic, strong) UIButton         *endTimeBtn;
@property (nonatomic, strong) STPickerDate     *beginDatePicker;
@property (nonatomic, strong) STPickerDate     *endDatePicker;
//班级
@property (nonatomic, strong) UILabel          *classLabel;
@property (nonatomic, strong) UIButton         *classBtn;
//活动简介
@property (nonatomic, strong) UILabel          *introductionLabel;
@property (nonatomic, strong) WTextView        *introductionTextView;
//上传图片
@property (nonatomic, strong) UILabel          *uploadLabel;
//发送班级活动
@property (nonatomic, strong) UIButton         *releaseBtn;
@property (nonatomic, strong) UIView           *myPicture;
@property (nonatomic, strong) NSMutableArray   *jobManagementArr;
@property (nonatomic, strong) UIScrollView     *launchEventScrollView;
@property (nonatomic, strong) NSMutableArray   *imgFiledArr;
@property (nonatomic, strong) NSString         *ID;
@property (nonatomic, assign) NSInteger        timeID;
@property (nonatomic, assign) NSInteger        typeID;

@end

@implementation LaunchEventViewController

- (NSMutableArray *)jobManagementArr {
    if (!_jobManagementArr) {
        _jobManagementArr = [NSMutableArray array];
    }
    return _jobManagementArr;
}

- (NSMutableArray *)imgFiledArr {
    if (!_imgFiledArr) {
        _imgFiledArr = [NSMutableArray array];
    }
    return _imgFiledArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布活动";
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        
    }];
    [self makeLaunchEventViewControllerUI];
}

- (void)makeLaunchEventViewControllerUI {
    
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
    [self.timeView addSubview:self.endTimeBtn];
    
    self.classLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.titleLabel.frame.size.height + self.titleTextField.frame.size.height + self.timeLabel.frame.size.height + self.timeView.frame.size.height + 30, APP_WIDTH - 20, 30)];
    self.classLabel.text = @"班级";
    self.classLabel.textColor = titlColor;
    self.classLabel.font = contentFont;
    [self.launchEventScrollView addSubview:self.classLabel];
    
    self.classBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, self.titleLabel.frame.size.height + self.titleTextField.frame.size.height + self.timeLabel.frame.size.height + self.timeView.frame.size.height + self.classLabel.frame.size.height + 30, APP_WIDTH - 20, 40)];
    self.classBtn.backgroundColor = [UIColor whiteColor];
    self.classBtn.layer.masksToBounds = YES;
    self.classBtn.layer.cornerRadius = 5;
    self.classBtn.layer.borderColor = fengeLineColor.CGColor;
    self.classBtn.layer.borderWidth = 1.0f;
    [self.classBtn setTitle:@"请选择班级" forState:UIControlStateNormal];
    self.classBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.classBtn.titleLabel.font = contentFont;
    [self.classBtn setTitleColor:backTitleColor forState:UIControlStateNormal];
    [self.classBtn addTarget:self action:@selector(classBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.launchEventScrollView addSubview:self.classBtn];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.classBtn.frame.size.width - 30, 15, 10, 10)];
    imgView.image = [UIImage imageNamed:@"下拉"];
    [self.classBtn addSubview:imgView];
    
    self.introductionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.titleLabel.frame.size.height + self.titleTextField.frame.size.height + self.timeLabel.frame.size.height + self.timeView.frame.size.height + self.classLabel.frame.size.height + self.classBtn.frame.size.height + 40, APP_WIDTH - 20, 30)];
    self.introductionLabel.text = @"活动简介";
    self.introductionLabel.textColor = titlColor;
    self.introductionLabel.font = contentFont;
    [self.launchEventScrollView addSubview:self.introductionLabel];
    
    self.introductionTextView = [[WTextView alloc] initWithFrame:CGRectMake(10, self.titleLabel.frame.size.height + self.titleTextField.frame.size.height + self.timeLabel.frame.size.height + self.timeView.frame.size.height + self.classLabel.frame.size.height + self.classBtn.frame.size.height + self.introductionLabel.frame.size.height + 40, APP_WIDTH - 20, 100)];
    self.introductionTextView.backgroundColor = [UIColor whiteColor];
    self.introductionTextView.layer.masksToBounds = YES;
    self.introductionTextView.layer.cornerRadius = 5;
    self.introductionTextView.layer.borderColor = fengeLineColor.CGColor;
    self.introductionTextView.layer.borderWidth = 1.0f;
    self.introductionTextView.font = contentFont;
    self.introductionTextView.placeholder = @"请输入活动内容...";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.launchEventScrollView addSubview:self.introductionTextView];
    
    self.uploadLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.titleLabel.frame.size.height + self.titleTextField.frame.size.height + self.timeLabel.frame.size.height + self.timeView.frame.size.height + self.classLabel.frame.size.height + self.classBtn.frame.size.height + self.introductionLabel.frame.size.height + self.introductionTextView.frame.size.height + 50, APP_WIDTH - 20, 30)];
    self.uploadLabel.text = @"上传活动宣传图(最多只能上传一张)";
    self.uploadLabel.textColor = titlColor;
    self.uploadLabel.font = contentFont;
    [self.launchEventScrollView addSubview:self.uploadLabel];
    
    self.myPicture = [[UIView alloc] initWithFrame:CGRectMake(10, self.titleLabel.frame.size.height + self.titleTextField.frame.size.height + self.timeLabel.frame.size.height + self.timeView.frame.size.height + self.classLabel.frame.size.height + self.classBtn.frame.size.height + self.introductionLabel.frame.size.height + self.introductionTextView.frame.size.height + self.uploadLabel.frame.size.height + 50, APP_WIDTH - 20, 80)];
    self.myPicture.backgroundColor = [UIColor redColor];
    [self.launchEventScrollView addSubview:self.myPicture];
    
    if (!self.LQPhotoPicker_superView) {
        self.LQPhotoPicker_superView = self.myPicture;
        self.LQPhotoPicker_imgMaxCount = 1;
        [self LQPhotoPicker_initPickerView];
        self.LQPhotoPicker_delegate = self;
    }
    
    self.releaseBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, self.titleLabel.frame.size.height + self.titleTextField.frame.size.height + self.timeLabel.frame.size.height + self.timeView.frame.size.height + self.classLabel.frame.size.height + self.classBtn.frame.size.height + self.introductionLabel.frame.size.height + self.introductionTextView.frame.size.height + self.myPicture.frame.size.height + self.myPicture.frame.size.height + 70, APP_WIDTH - 40, 40)];
    self.releaseBtn.backgroundColor = THEMECOLOR;
    [self.releaseBtn setTitle:@"发布班级活动" forState:UIControlStateNormal];
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

- (void)releaseBtn : (UIButton *)sender {
    [self.view endEditing:YES];
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
    
    if ([self.classBtn.titleLabel.text isEqualToString:@"请选择班级"]) {
        [WProgressHUD showErrorAnimatedText:@"请选择班级"];
        return;
    }
    
    if ([self.introductionTextView.text isEqualToString:@""]) {
        [WProgressHUD showErrorAnimatedText:@"请输入活动内容"];
        return;
    } else {
        [self LQPhotoPicker_getBigImageDataArray];
        [self setShangChuanTupian];
    }

}

- (void)postDataForActivityPublish:(NSDictionary *)dic {
        [WProgressHUD showHUDShowText:@"加载中..."];
        [[HttpRequestManager sharedSingleton] POST:activityPublish parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
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
            [WProgressHUD hideAllHUDAnimated:YES];
        }];
}

- (void)setShangChuanTupian {
    NSDictionary * params = @{@"key":[UserManager key],@"upload_type":@"img", @"upload_img_type":@"activity"};
    [WProgressHUD showHUDShowText:@"加载中..."];
    [[HttpRequestManager sharedSingleton].sessionManger POST:WENJIANSHANGCHUANJIEKOU parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i < self.LQPhotoPicker_bigImageArray.count; i++) {
            UIImage *image = self.LQPhotoPicker_bigImageArray[i];
            NSData  *imageData = UIImageJPEGRepresentation(image,1);
            float length=[imageData length]/1000;
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *imageFileName = [NSString stringWithFormat:@"%@.jpeg", str];
    
            if (length > 1280) {
                NSData *fData = UIImageJPEGRepresentation(image, 0.5);
                [formData appendPartWithFileData:fData name:[NSString stringWithFormat:@"file[%d]",i] fileName:imageFileName mimeType:@"image/jpeg"];
            } else {
                [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"file[%d]",i] fileName:imageFileName mimeType:@"image/jpeg"];
            }
            
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            [WProgressHUD hideAllHUDAnimated:YES];
            
            NSDictionary *dic = [responseObject objectForKey:@"data"];
            NSMutableArray *arr = [dic objectForKey:@"url"];
            for (int i = 0; i < arr.count; i ++) {
                [self.imgFiledArr addObject:arr[i]];
            }
            
            if (self.imgFiledArr.count != 0) {
                NSString *str = [NSString stringWithFormat:@"%@",self.imgFiledArr[0]];
                NSDictionary *dic  = @{@"key":[UserManager key],@"title":self.titleTextField.text,@"start":self.beginTimeBtn.titleLabel.text,@"end":self.endTimeBtn.titleLabel.text,@"class_id":self.ID,@"introduction":self.introductionTextView.text,@"img":str};
                [self postDataForActivityPublish:dic];
            } else {
                [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
                return;
            }
            
        } else {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
            } else {
            }
            [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"%@", error);
         [WProgressHUD hideAllHUDAnimated:YES];
     }];
    
}

- (void)compareDate:(NSString*)aDate withDate:(NSString*)bDate {
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:@"yyyy-MM-dd"];
    NSDate *dta = [[NSDate alloc] init];
    NSDate *dtb = [[NSDate alloc] init];
    
    dta = [dateformater dateFromString:aDate];
    dtb = [dateformater dateFromString:bDate];
    NSComparisonResult result = [dta compare:dtb];
    if (result == NSOrderedSame) {
        NSLog(@"相等");
        self.timeID = 0;
        return;
    }else if (result == NSOrderedAscending) {
        //bDate比aDate大
        NSLog(@"第二个比第一个大");
        self.timeID = 0;
        return;
    }else if (result == NSOrderedDescending) {
        //bDate比aDate小
        NSLog(@"第二个比第一个小");
        [WProgressHUD showErrorAnimatedText:@"开始时间不能小于结束时间"];
        [self.beginTimeBtn setTitle:@"开始时间" forState:UIControlStateNormal];
        [self.endTimeBtn setTitle:@"结束时间" forState:UIControlStateNormal];
        self.timeID = 1;
        return;
    }
   
}

- (void)classBtn : (UIButton *)sender {
    NSLog(@"请选择");
    [self.view endEditing:YES];
    [self getClassData];
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
    
//    [self.view endEditing:YES];
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


-(void)pickerView:(UIView *)pickerView result:(NSString *)string index:(NSInteger)index {
    [self.classBtn setTitle:string forState:UIControlStateNormal];
    [self.classBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    TeacherNotifiedModel *model = [self.jobManagementArr objectAtIndex:index];
    if (model.ID == nil) {
        [WProgressHUD showErrorAnimatedText:@"数据不正确,请重试"];
    } else {
        self.ID = model.ID;
    }
    
}



- (void)getClassData {
    NSDictionary *dic = @{@"key":[UserManager key]};
    [[HttpRequestManager sharedSingleton] POST:getClassURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            self.jobManagementArr = [TeacherNotifiedModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            NSMutableArray *ary = [@[]mutableCopy];
            for (TeacherNotifiedModel *model in self.jobManagementArr) {
                [ary addObject:[NSString stringWithFormat:@"%@", model.name]];
            }
            if (ary.count == 0) {
                [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
            } else {
                PickerView *vi = [[PickerView alloc] init];
                vi.array = ary;
                vi.type = PickerViewTypeHeigh;
                vi.selectComponent = 0;
                vi.delegate = self;
                [[[UIApplication sharedApplication] keyWindow] addSubview:vi];
            }
            
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



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    
}

#pragma mark - UIScrollViewDelegate
//返回缩放时所使用的UIView对象
- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return scrollView;
}

//开始缩放时调用
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    
}

//结束缩放时调用，告知缩放比例
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    
}

//已经缩放时调用
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
}

//确定是否可以滚动到顶部
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    return YES;
}

//滚动到顶部时调用
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
    
}

//已经滚动时调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

//开始进行拖动时调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
}

//抬起手指停止拖动时调用，布尔值确定滚动到最后位置时是否需要减速
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
}

//如果上面的方法决定需要减速继续滚动，则调用该方法，可以读取contentOffset属性，判断用户抬手位置（不是最终停止位置）
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
}

//减速完毕停止滚动时调用，这里的读取contentOffset属性就是最终停止位置
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
}

@end
