//
//  PublishJobViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/28.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "PublishJobViewController.h"
#import "PublishJobModel.h"
#import <Photos/Photos.h>

@interface PublishJobViewController ()<UITextFieldDelegate,PickerViewResultDelegate,LQPhotoPickerViewDelegate>

//科目
@property (nonatomic, strong) UILabel         *subjectsLabel;
@property (nonatomic, strong) UIButton        *subjectsBtn;
//作业名称
@property (nonatomic, strong) UILabel         *jobNameLabel;
@property (nonatomic, strong) UITextField     *jobNameTextField;
//作业内容
@property (nonatomic, strong) UILabel         *jobContentLabel;
@property (nonatomic, strong) WTextView       *jobContentTextView;
//上传图片内容
@property (nonatomic, strong) UILabel         *uploadPicturesLabel;
@property (nonatomic, strong) UIView          *myPicture;
@property (nonatomic, strong) NSMutableArray  *imgFiledArr;
@property (nonatomic, strong) NSMutableArray  *publishJobArr;
@property (nonatomic, strong) NSString        *courseID;

@end

@implementation PublishJobViewController

- (NSMutableArray *)publishJobArr {
    if (!_publishJobArr) {
        _publishJobArr = [NSMutableArray array];
    }
    return _publishJobArr;
}

- (NSMutableArray *)imgFiledArr {
    if (!_imgFiledArr) {
        _imgFiledArr = [NSMutableArray array];
    }
    return _imgFiledArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布作业";
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [button setTitle:@"发布" forState:UIControlStateNormal];
    button.titleLabel.font = titFont;
    [button addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        
    }];
    [self makePublishJobViewControllerUI];
    
}

- (void)makePublishJobViewControllerUI {
    
    self.view.backgroundColor = backColor;
    self.subjectsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, APP_WIDTH, 30)];
    self.subjectsLabel.text = @"科目";
    self.subjectsLabel.textColor =titlColor;
    self.subjectsLabel.font = titFont;
    [self.view addSubview:self.subjectsLabel];
    
    self.subjectsBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, self.subjectsLabel.frame.size.height + 10, APP_WIDTH - 20, 40)];
    self.subjectsBtn.backgroundColor = [UIColor whiteColor];
    [self.subjectsBtn setTitle:@"请选择科目类型" forState:UIControlStateNormal];
    self.subjectsBtn.layer.masksToBounds = YES;
    self.subjectsBtn.layer.cornerRadius = 5;
    self.subjectsBtn.layer.borderColor = fengeLineColor.CGColor;
    self.subjectsBtn.layer.borderWidth = 1.0f;
    self.subjectsBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.subjectsBtn setTitleColor:backTitleColor forState:UIControlStateNormal];
    self.subjectsBtn.titleLabel.font = contentFont;
    [self.subjectsBtn addTarget:self action:@selector(subjectsBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.subjectsBtn];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.subjectsBtn.frame.size.width - 30, 15, 10, 10)];
    imgView.image = [UIImage imageNamed:@"下拉"];
    [self.subjectsBtn addSubview:imgView];
    
    self.jobNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.subjectsLabel.frame.size.height + self.subjectsBtn.frame.size.height + 20, APP_WIDTH - 20, 30)];
    self.jobNameLabel.text = @"作业名称";
    self.jobNameLabel.textColor = titlColor;
    self.jobNameLabel.font = titFont;
    [self.view addSubview:self.jobNameLabel];
    
    self.jobNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, self.subjectsLabel.frame.size.height + self.subjectsBtn.frame.size.height + self.jobNameLabel.frame.size.height + 20, APP_WIDTH - 20, 40)];
    self.jobNameTextField.backgroundColor = [UIColor whiteColor];
    self.jobNameTextField.layer.masksToBounds = YES;
    self.jobNameTextField.layer.cornerRadius = 5;
    self.jobNameTextField.layer.borderColor = fengeLineColor.CGColor;
    self.jobNameTextField.layer.borderWidth = 1.0f;
    self.jobNameTextField.font = contentFont;
    self.jobNameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入作业名称" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]}];
    self.jobNameTextField.delegate = self;
    self.jobNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.jobNameTextField];
    
    self.jobContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.subjectsLabel.frame.size.height + self.subjectsBtn.frame.size.height + self.jobNameLabel.frame.size.height + self.jobNameTextField.frame.size.height + 30, APP_WIDTH - 20, 30)];
    self.jobContentLabel.text = @"作业内容";
    self.jobContentLabel.textColor = titlColor;
    self.jobContentLabel.font = titFont;
    [self.view addSubview:self.jobContentLabel];
    
    self.jobContentTextView = [[WTextView alloc] initWithFrame:CGRectMake(10, self.subjectsLabel.frame.size.height + self.subjectsBtn.frame.size.height + self.jobNameLabel.frame.size.height + self.jobNameTextField.frame.size.height + self.jobContentLabel.frame.size.height + 30, APP_WIDTH - 20, APP_HEIGHT * 0.3)];
    self.jobContentTextView.backgroundColor = [UIColor whiteColor];
    self.jobContentTextView.layer.masksToBounds = YES;
    self.jobContentTextView.layer.cornerRadius = 5;
    self.jobContentTextView.layer.borderColor = fengeLineColor.CGColor;
    self.jobContentTextView.layer.borderWidth = 1.0f;
    self.jobContentTextView.font = contentFont;
    self.jobContentTextView.placeholder = @"请输入具体的作业...";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.jobContentTextView];
    
    self.uploadPicturesLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.subjectsLabel.frame.size.height + self.subjectsBtn.frame.size.height + self.jobNameLabel.frame.size.height + self.jobNameTextField.frame.size.height + self.jobContentLabel.frame.size.height + self.jobContentTextView.frame.size.height + 40, APP_WIDTH - 20, 30)];
    self.uploadPicturesLabel.text = @"上传图片内容(最多只能上传三张)";
    self.uploadPicturesLabel.textColor = titlColor;
    self.uploadPicturesLabel.font = titFont;
    [self.view addSubview:self.uploadPicturesLabel];
    
    self.myPicture = [[UIView alloc] initWithFrame:CGRectMake(10, self.subjectsLabel.frame.size.height + self.subjectsBtn.frame.size.height + self.jobNameLabel.frame.size.height + self.jobNameTextField.frame.size.height + self.jobContentLabel.frame.size.height + self.jobContentTextView.frame.size.height + self.uploadPicturesLabel.frame.size.height + 40, APP_WIDTH - 20, 80)];
    self.myPicture.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.myPicture];
    
    if (!self.LQPhotoPicker_superView) {
        self.LQPhotoPicker_superView = self.myPicture;
        self.LQPhotoPicker_imgMaxCount = 3;
        [self LQPhotoPicker_initPickerView];
        self.LQPhotoPicker_delegate = self;
    }
    
}


- (void)subjectsBtn : (UIButton *)sender {
    NSLog(@"点击科目类型");
    [self.view endEditing:YES];
    [self getUserGetCourse];
}

- (void)rightBtn : (UIButton *)sender {
    NSLog(@"点击发布");
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"youkeState"] isEqualToString:@"1"]) {
        [WProgressHUD showErrorAnimatedText:@"游客不能进行此操作"];
        return;
    }
    
    if ([self.subjectsBtn.titleLabel.text isEqualToString:@"请选择科目类型"]) {
        [WProgressHUD showErrorAnimatedText:@"请选择科目类型"];
        return;
    }
    
    if ([self.jobNameTextField.text isEqualToString:@""]) {
        [WProgressHUD showErrorAnimatedText:@"请输入作业名称"];
        return;
    }
    
    if ([self.jobContentTextView.text isEqualToString:@""]) {
        [WProgressHUD showErrorAnimatedText:@"请输入作业内容"];
        return;
    } else if (self.LQPhotoPicker_smallImageArray.count == 0) {
        NSDictionary *dataDic = [NSDictionary dictionary];
        dataDic = @{@"key":[UserManager key],@"class_id":self.classID,@"title":self.jobNameTextField.text,@"content":self.jobContentTextView.text,@"course_id":self.courseID,@"img":@""};
        [self PostWorkPusblishData:dataDic];
    } else {
        [self setShangChuanTupian];
    }
    
}

- (void)setShangChuanTupian {
    [self LQPhotoPicker_getBigImageDataArray];
    NSDictionary * params = @{@"key":[UserManager key],@"upload_type":@"img", @"upload_img_type":@"work"};
    [WProgressHUD showHUDShowText:@"加载中..."];
    [[HttpRequestManager sharedSingleton].sessionManger POST:WENJIANSHANGCHUANJIEKOU parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i < self.LQPhotoPicker_bigImageArray.count; i++) {
            UIImage *image = self.LQPhotoPicker_bigImageArray[i];
            NSData *imageData = UIImageJPEGRepresentation(image,1);
            float length=[imageData length]/1000;
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *imageFileName = [NSString stringWithFormat:@"%@.jpeg", str];
            
            if (length > 1280) {
                NSData *fData = UIImageJPEGRepresentation(image, 0.3);
                [formData appendPartWithFileData:fData name:[NSString stringWithFormat:@"file[%d]",i] fileName:imageFileName mimeType:@"image/jpeg"];
            } else {
                [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"file[%d]",i] fileName:imageFileName mimeType:@"image/jpeg"];
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [WProgressHUD hideAllHUDAnimated:YES];
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            NSDictionary *dic = [responseObject objectForKey:@"data"];
            NSMutableArray *arr = [dic objectForKey:@"url"];
            for (int i = 0; i < arr.count; i ++) {
                [self.imgFiledArr addObject:arr[i]];
            }
            NSDictionary *dataDic = [NSDictionary dictionary];
            dataDic = @{@"key":[UserManager key],@"class_id":self.classID,@"title":self.jobNameTextField.text,@"content":self.jobContentTextView.text,@"course_id":self.courseID,@"img":self.imgFiledArr};
            [self PostWorkPusblishData:dataDic];
        } else {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
                [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
            } else {
                [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        [WProgressHUD hideAllHUDAnimated:YES];
    }];
}


- (void)PostWorkPusblishData:(NSDictionary *)dic {
    
        [WProgressHUD showHUDShowText:@"加载中..."];
        [[HttpRequestManager sharedSingleton] POST:workPusblish parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
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


- (void)getUserGetCourse {
    NSDictionary *dic = @{@"key":[UserManager key]};
    [[HttpRequestManager sharedSingleton] POST:userGetCourse parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            
            self.publishJobArr = [PublishJobModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            NSMutableArray * ary = [@[]mutableCopy];
            for (PublishJobModel * model in self.publishJobArr) {
                [ary addObject:[NSString stringWithFormat:@"%@", model.name]];
            }
            PickerView *vi = [[PickerView alloc] init];
            vi.array = ary;
            vi.type = PickerViewTypeHeigh;
            vi.selectComponent = 0;
            vi.delegate = self;
            [[[UIApplication sharedApplication] keyWindow] addSubview:vi];
            
            if (self.publishJobArr.count == 0) {
                [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
            } else {
                
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

-(void)pickerView:(UIView *)pickerView result:(NSString *)string index:(NSInteger)index{
    if (self.publishJobArr.count != 0) {
        [self.subjectsBtn setTitle:string forState:UIControlStateNormal];
        PublishJobModel *model = [self.publishJobArr objectAtIndex:index];
        if (model.ID == nil) {
            [WProgressHUD showErrorAnimatedText:@"数据不正确,请重试"];
        } else {
            self.courseID = model.ID;
        }
    }
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
