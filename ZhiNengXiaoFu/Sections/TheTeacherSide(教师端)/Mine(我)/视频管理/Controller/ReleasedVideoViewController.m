//
//  ReleasedVideoViewController.m
//  ZhiNengXiaoFu
//
//  Created by 独秀科技 on 2018/12/5.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "ReleasedVideoViewController.h"
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetImageGenerator.h>
#import <AVFoundation/AVTime.h>
#import "GradeModel.h"
#import "TypeModel.h"


@interface ReleasedVideoViewController ()<UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,PickerViewResultDelegate>

@property (nonatomic, strong) UIButton       *rightBtn;
@property (nonatomic, strong) UILabel        *typeLabel;
@property (nonatomic, strong) UIView         *typeView;
@property (nonatomic, strong) UILabel        *changLabel;
@property (nonatomic, strong) UIButton       *degreeBtn;
@property (nonatomic, strong) UIButton       *gradeBtn;
@property (nonatomic, strong) UIButton       *subjectsBtn;
@property (nonatomic, strong) UILabel        *nameLabel;
@property (nonatomic, strong) UITextField    *nameTextField;
@property (nonatomic, strong) UILabel        *IntroductionLabel;
@property (nonatomic, strong) WTextView      *IntroductionTextView;
@property (nonatomic, strong) UILabel        *videoLabel;
@property (nonatomic, strong) UIView         *videoView;
@property (nonatomic, strong) NSString       *token;
@property (nonatomic, strong) NSString       *qiniuKey;
@property (nonatomic, strong) NSString       *thumbnailImgStr;
@property (nonatomic, strong) NSString       *sandboxPathStr;
@property (nonatomic, assign) NSInteger      typeID;
@property (nonatomic, strong) NSMutableArray *publishJobArr; //科目
@property (nonatomic, strong) NSString       *courseID;
@property (nonatomic, strong) NSMutableArray *classNameArr;//班级
@property (nonatomic, strong) NSString       *classNameID;
@property (nonatomic, strong) NSMutableArray *gradeArr; //年级
@property (nonatomic, strong) NSString       *gradeID;
@property (nonatomic, strong) UIImageView    *thumbnailImgView;
@property (nonatomic, strong) UIButton       *delegateBtn;

@property (nonatomic, strong) JhDownProgressView *progressView;
@property (nonatomic, strong) JhDownProgressView *proress;


@end

@implementation ReleasedVideoViewController

- (NSMutableArray *)gradeArr {
    if (!_gradeArr) {
        _gradeArr = [NSMutableArray array];
    }
    return _gradeArr;
}

- (NSMutableArray *)classNameArr {
    if (!_classNameArr) {
        _classNameArr = [NSMutableArray array];
    }
    return _classNameArr;
}

- (NSMutableArray *)publishJobArr {
    if (!_publishJobArr) {
        _publishJobArr = [NSMutableArray array];
    }
    return _publishJobArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布视频";
    self.rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [self.rightBtn setTitle:@"发布" forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = titFont;
    [self.rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
    [self makeReleasedVideoViewControllerUI];
}

- (void)makeReleasedVideoViewControllerUI {
    
    self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 58, 28)];
    self.typeLabel.text = @"类型";
    self.typeLabel.font = [UIFont systemFontOfSize:16];
    self.typeLabel.textColor = RGB(51, 51, 51);
    [self.view addSubview:self.typeLabel];
    
    self.typeView = [[UIView alloc] initWithFrame:CGRectMake(10, 15 + self.typeLabel.frame.size.height, APP_WIDTH - 20, 50)];
    self.typeView.backgroundColor = [UIColor whiteColor];
    self.typeView.layer.masksToBounds = YES;
    self.typeView.layer.cornerRadius  = 5;
    [self.view addSubview:self.typeView];
    
    self.changLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 50, 30)];
    self.changLabel.text = @"请选择";
    self.changLabel.textColor = RGB(170, 170, 170);
    self.changLabel.font = [UIFont systemFontOfSize:14];
    [self.typeView addSubview:self.changLabel];
    
    self.degreeBtn = [[UIButton alloc] initWithFrame:CGRectMake(10 + self.changLabel.frame.size.width, 10, 65, 30)];
    [self.degreeBtn setTitle:@"教育程度" forState:UIControlStateNormal];
    [self.degreeBtn setTitleColor:RGB(170, 170, 170) forState:UIControlStateNormal];
    self.degreeBtn.layer.masksToBounds = YES;
    self.degreeBtn.layer.cornerRadius  = 5;
    self.degreeBtn.layer.borderWidth   = 1;
    self.degreeBtn.layer.borderColor = RGB(238, 238, 238).CGColor;
    self.degreeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    self.degreeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.degreeBtn addTarget:self action:@selector(degreeBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    [self.typeView addSubview:self.degreeBtn];
    
    self.gradeBtn = [[UIButton alloc] initWithFrame:CGRectMake(20 + self.changLabel.frame.size.width + self.degreeBtn.frame.size.width, 10, 65, 30)];
    [self.gradeBtn setTitle:@"年级" forState:UIControlStateNormal];
    [self.gradeBtn setTitleColor:RGB(170, 170, 170) forState:UIControlStateNormal];
    self.gradeBtn.layer.masksToBounds = YES;
    self.gradeBtn.layer.cornerRadius  = 5;
    self.gradeBtn.layer.borderWidth   = 1;
    self.gradeBtn.layer.borderColor = RGB(238, 238, 238).CGColor;
    self.gradeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    self.gradeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.gradeBtn addTarget:self action:@selector(gradeBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    [self.typeView addSubview:self.gradeBtn];
    
    self.subjectsBtn = [[UIButton alloc] initWithFrame:CGRectMake(30 + self.changLabel.frame.size.width + self.degreeBtn.frame.size.width + self.gradeBtn.frame.size.width, 10, 80, 30)];
    [self.subjectsBtn setTitle:@"科目" forState:UIControlStateNormal];
    [self.subjectsBtn setTitleColor:RGB(170, 170, 170) forState:UIControlStateNormal];
    self.subjectsBtn.layer.masksToBounds = YES;
    self.subjectsBtn.layer.cornerRadius  = 5;
    self.subjectsBtn.layer.borderWidth   = 1;
    self.subjectsBtn.layer.borderColor = RGB(238, 238, 238).CGColor;
    self.subjectsBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    self.subjectsBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.subjectsBtn addTarget:self action:@selector(subjectsBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    [self.typeView addSubview:self.subjectsBtn];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 25 + self.typeLabel.frame.size.height + self.typeView.frame.size.height, 100, 20)];
    self.nameLabel.text = @"视频名称";
    self.nameLabel.textColor = RGB(51, 51, 51);
    self.nameLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:self.nameLabel];
    
    self.nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 35 + self.typeLabel.frame.size.height + self.typeView.frame.size.height + self.nameLabel.frame.size.height, APP_WIDTH - 20, 40)];
    self.nameTextField.backgroundColor = [UIColor whiteColor];
    self.nameTextField.layer.masksToBounds = YES;
    self.nameTextField.layer.cornerRadius = 5;
    self.nameTextField.layer.borderColor = fengeLineColor.CGColor;
    self.nameTextField.layer.borderWidth = 1.0f;
    self.nameTextField.font = contentFont;
    self.nameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入视频名称" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]}];
    self.nameTextField.delegate = self;
    self.nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.nameTextField];
    
    self.IntroductionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 45 + self.typeLabel.frame.size.height + self.typeView.frame.size.height + self.nameLabel.frame.size.height + self.nameTextField.frame.size.height, 200, 20)];
    self.IntroductionLabel.text = @"视频简介";
    self.IntroductionLabel.textColor = RGB(51, 51, 51);
    self.IntroductionLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:self.IntroductionLabel];
    
    self.IntroductionTextView = [[WTextView alloc] initWithFrame:CGRectMake(10, 55 + self.typeLabel.frame.size.height + self.typeView.frame.size.height + self.nameLabel.frame.size.height + self.nameTextField.frame.size.height + self.IntroductionLabel.frame.size.height, APP_WIDTH - 20, APP_HEIGHT * 0.3)];
    self.IntroductionTextView.backgroundColor = [UIColor whiteColor];
    self.IntroductionTextView.layer.masksToBounds = YES;
    self.IntroductionTextView.layer.cornerRadius = 5;
    self.IntroductionTextView.layer.borderColor = fengeLineColor.CGColor;
    self.IntroductionTextView.layer.borderWidth = 1.0f;
    self.IntroductionTextView.font = contentFont;
    self.IntroductionTextView.placeholder = @"请输入...";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.IntroductionTextView];
    
    self.videoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 65 + self.typeLabel.frame.size.height + self.typeView.frame.size.height + self.nameLabel.frame.size.height + self.nameTextField.frame.size.height + self.IntroductionLabel.frame.size.height + self.IntroductionTextView.frame.size.height, APP_WIDTH - 40, 20)];
    self.videoLabel.text = @"上传视频（视频文件仅支持MP4格式）";
    self.videoLabel.textAlignment = NSTextAlignmentLeft;
    self.videoLabel.textColor = RGB(51, 51, 51);
    self.videoLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:self.videoLabel];
    
    self.videoView = [[UIView alloc] initWithFrame:CGRectMake(10, 75 + self.typeLabel.frame.size.height + self.typeView.frame.size.height + self.nameLabel.frame.size.height + self.nameTextField.frame.size.height + self.IntroductionLabel.frame.size.height + self.IntroductionTextView.frame.size.height + self.videoLabel.frame.size.height, APP_WIDTH - 20, 100)];
    self.videoView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.videoView];
    
    UIButton *upVideoBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 10, 80, 80)];
    [upVideoBtn setImage:[UIImage imageNamed:@"添加视频"] forState:UIControlStateNormal];
    [upVideoBtn addTarget:self action:@selector(upVideoBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    [self.videoView addSubview:upVideoBtn];
    
    self.thumbnailImgView = [[UIImageView alloc] initWithFrame:CGRectMake(90, 10, 80, 80)];
    self.thumbnailImgView.backgroundColor = [UIColor clearColor];
    self.thumbnailImgView.layer.masksToBounds = YES;
    self.thumbnailImgView.layer.cornerRadius  = 5;
    [self.videoView addSubview:self.thumbnailImgView];
    
    self.delegateBtn = [[UIButton alloc] initWithFrame:CGRectMake(160, 0, 30, 30)];
    [self.delegateBtn setBackgroundImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
    self.delegateBtn.layer.masksToBounds = YES;
    self.delegateBtn.layer.cornerRadius  = 15;
    [self.delegateBtn addTarget:self action:@selector(delegateBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    self.delegateBtn.hidden = YES;
    [self.videoView addSubview:self.delegateBtn];
    
    _proress = [JhDownProgressView showWithStyle:JhStyle_percentAndText];
    [self.view addSubview:_proress];
    _progressView = _proress;
    _progressView.hidden = YES;
    _proress.hidden      = YES;
}

- (void)delegateBtnSelector:(UIButton *)sender {
    NSLog(@"点击删除");
    if (self.thumbnailImgStr != nil && self.qiniuKey != nil) {
        [self.thumbnailImgView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@""]];
        self.thumbnailImgView.backgroundColor = [UIColor clearColor];
        self.thumbnailImgStr = nil;
        self.qiniuKey        = nil;
        self.delegateBtn.hidden = YES;
        [WProgressHUD showSuccessfulAnimatedText:@"删除成功, 请重新选择"];
    } else {
        [WProgressHUD showErrorAnimatedText:@"暂无视频可选择"];
    }
}

- (void)upVideoBtnSelector:(UIButton *)sender {
    NSLog(@"点击添加视频");
    [self GetQiniuTokenURLData];
    
    UIImagePickerController *picker=[[UIImagePickerController alloc] init];
    
    picker.delegate=self;
    picker.allowsEditing=NO;
//    picker.videoMaximumDuration = 1.0;//视频最长长度
    picker.videoQuality = UIImagePickerControllerQualityTypeMedium;//视频质量
    
    //媒体类型：@"public.movie" 为视频  @"public.image" 为图片
    //这里只选择展示视频
    picker.mediaTypes = [NSArray arrayWithObjects:@"public.movie", nil];
    
    picker.sourceType= UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    [self presentViewController:picker animated:YES completion:^{
        NSLog(@"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
    }];
}

- (void)subjectsBtnSelector:(UIButton *)sender {
    NSLog(@"点击科目");
    self.typeID = 3;
    if (self.classNameID != nil) {
        NSMutableArray * ary = [@[]mutableCopy];
        for (TypeModel * model in self.publishJobArr) {
            [ary addObject:[NSString stringWithFormat:@"%@", model.t_name]];
        }
        if (ary.count == 0) {
            [WProgressHUD showErrorAnimatedText:@"暂无数据"];
        } else {
            PickerView *vi = [[PickerView alloc] init];
            vi.array = ary;
            vi.type = PickerViewTypeHeigh;
            vi.selectComponent = 0;
            vi.delegate = self;
            [[[UIApplication sharedApplication] keyWindow] addSubview:vi];
        }
    } else {
        [WProgressHUD showErrorAnimatedText:@"请选择年级"];
    }
}

- (void)gradeBtnSelector:(UIButton *)sender {
    NSLog(@"点击年级");
    self.typeID = 2;
    if (self.gradeID != nil) {
        [self GetTypeListURLData:self.gradeID];
    } else {
        [WProgressHUD showErrorAnimatedText:@"请选择教育程度"];
    }
}

- (void)degreeBtnSelector:(UIButton *)sender {
    NSLog(@"点击教育程度");
    self.gradeID = nil;
    [self.gradeArr removeAllObjects];
    [self.degreeBtn setTitle:@"教育程度" forState:UIControlStateNormal];
    
    //年级
    self.classNameID = nil;
    [self.classNameArr removeAllObjects];
    [self.gradeBtn setTitle:@"年级" forState:UIControlStateNormal];
    
    //科目
    self.courseID = nil;
    [self.publishJobArr removeAllObjects];
    [self.subjectsBtn setTitle:@"科目" forState:UIControlStateNormal];
    
    self.typeID = 1;
    self.gradeArr = [NSMutableArray arrayWithObjects:@"小学",@"中学",@"高中", nil];
    PickerView *vi = [[PickerView alloc] init];
    vi.array = self.gradeArr;
    vi.type = PickerViewTypeHeigh;
    vi.selectComponent = 0;
    vi.delegate = self;
    [[[UIApplication sharedApplication] keyWindow] addSubview:vi];
   
}

- (void)rightBtn:(UIButton *)sender {
    NSLog(@"点击发布");
    [self OnlineUploadURLData];
}

- (void)OnlineUploadURLData {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"youkeState"] isEqualToString:@"1"]) {
        [WProgressHUD showErrorAnimatedText:@"游客不能进行此操作"];
    } else {
        if (self.gradeID == nil) {
            [WProgressHUD showErrorAnimatedText:@"请选择教育程度"];
            return;
        } else if (self.classNameID == nil) {
            [WProgressHUD showErrorAnimatedText:@"请选择年级"];
            return;
        } else if (self.courseID == nil) {
            [WProgressHUD showErrorAnimatedText:@"请选择科目"];
            return;
        } else if ([self.nameTextField.text isEqualToString:@""]) {
            [WProgressHUD showErrorAnimatedText:@"请输入课程名称"];
            return;
        } else if ([self.IntroductionTextView.text isEqualToString:@""]) {
            [WProgressHUD showErrorAnimatedText:@"请输入课程简介"];
            return;
        } else if ([self.qiniuKey isEqualToString:@""]) {
            [WProgressHUD showErrorAnimatedText:@"请添加视频"];
            return;
        } else {
            NSDictionary *dic = @{@"key":[UserManager key],@"stage":self.gradeID,@"grade_id":self.classNameID,@"t_id":self.courseID,@"title":self.nameTextField.text,@"content":self.IntroductionTextView.text,@"img":self.thumbnailImgStr,@"video_url":self.qiniuKey};
            [[HttpRequestManager sharedSingleton] POST:OnlineUploadURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
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
        
    }
}


//根据阶段获取年级、科目列表
- (void)GetTypeListURLData:(NSString *)stage {
    NSDictionary *dic = @{@"key":[UserManager key], @"stage":stage};
    [[HttpRequestManager sharedSingleton] POST:GetTypeListURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
           
            NSDictionary *dataDic = [responseObject objectForKey:@"data"];
            self.classNameArr = [GradeModel mj_objectArrayWithKeyValuesArray:[dataDic objectForKey:@"grade"]];
            
            NSMutableArray * ary = [@[]mutableCopy];
            for (GradeModel * model in self.classNameArr) {
                [ary addObject:[NSString stringWithFormat:@"%@", model.grade_name]];
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
            
            if (self.classNameArr.count == 0) {
                [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
            } else {
                
            }
            
            self.publishJobArr  = [TypeModel mj_objectArrayWithKeyValuesArray:[dataDic objectForKey:@"type"]];
            
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
    
    switch (self.typeID) {
        case 1:
            {
                [self.degreeBtn setTitle:string forState:UIControlStateNormal];
                self.gradeID = [NSString stringWithFormat:@"%ld",index + 1];
                NSLog(@"%@",self.gradeID);
            }
            break;
        case 2:
        {
            if (self.classNameArr.count != 0) {
                [self.gradeBtn setTitle:string forState:UIControlStateNormal];
                GradeModel *model = [self.classNameArr objectAtIndex:index];
                self.classNameID = model.grade_id;
            }
        }
            break;
        case 3:
        {
            if (self.publishJobArr.count != 0) {
                [self.subjectsBtn setTitle:string forState:UIControlStateNormal];
                TypeModel *model = [self.publishJobArr objectAtIndex:index];
                if (model.t_id == nil) {
                    [WProgressHUD showErrorAnimatedText:@"数据不正确,请重试"];
                } else {
                    self.courseID = model.t_id;
                }
            }
        }
            break;
            
        default:
            break;
    }
}




//视频缩略图上传
- (void)postImgForVideo:(UIImage *)thumbnailImg {
    NSDictionary * params = @{@"key":[UserManager key],@"upload_type":@"img", @"upload_img_type":@"online",@"student_id":@""};
//    [WProgressHUD showHUDShowText:@"加载中..."];
    [[HttpRequestManager sharedSingleton].sessionManger POST:WENJIANSHANGCHUANJIEKOU parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData  *imageData = UIImageJPEGRepresentation(thumbnailImg,1);
        float length = [imageData length]/1000;
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *imageFileName = [NSString stringWithFormat:@"%@.jpeg", str];
        if (length > 1280) {
            NSData *fData = UIImageJPEGRepresentation(thumbnailImg, 0.5);
            [formData appendPartWithFileData:fData name:[NSString stringWithFormat:@"file"] fileName:imageFileName mimeType:@"image/jpeg"];
        } else {
            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"file"] fileName:imageFileName mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
//            [WProgressHUD showSuccessfulAnimatedText:[responseObject objectForKey:@"msg"]];
//            [WProgressHUD hideAllHUDAnimated:YES];
            NSArray *arr = [[responseObject objectForKey:@"data"] objectForKey:@"url"];
            self.thumbnailImgStr = arr[0];
            NSString *str = [NSString stringWithFormat:@"%@%@",YUMING,self.thumbnailImgStr];
            [self.thumbnailImgView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"tu"]];
            self.delegateBtn.hidden = NO;
            [self uploadImageToQNFilePath:self.sandboxPathStr];
            
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



- (void)uploadImageToQNFilePath:(NSString *)filePath {
    _progressView.hidden = NO;
    _proress.hidden     = NO;
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
//    [WProgressHUD showHUDShowText:@"视频上传中..."];
    QNUploadOption *uploadOption = [[QNUploadOption alloc] initWithMime:nil progressHandler:^(NSString *key, float percent) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"percent == %.2f", percent);
            
            self.progressView.progress += percent;
            if (percent >= 1) {
                NSLog(@"下载完成");
                _progressView.hidden = YES;
                _proress.hidden     = YES;
            }
        });
        
    } params:nil checkCrc:NO cancellationSignal:nil];
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    int num = (arc4random() % 10000);
    NSString  *randomNumber = [NSString stringWithFormat:@"%.4d", num];
    
    NSString *keyStr = [NSString stringWithFormat:@"online/video/%@%@.mp4",timeString,randomNumber];
    
    [upManager putFile:filePath key:keyStr token:self.token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
//        [WProgressHUD showSuccessfulAnimatedText:@"上传成功"];
//        [WProgressHUD hideAllHUDAnimated:YES];
        NSLog(@"info ===== %@", info);
        NSLog(@"resp ===== %@", resp);
        NSLog(@"%@",[resp objectForKey:@"key"]);
        self.qiniuKey = [resp objectForKey:@"key"];
        
    }
     option:uploadOption];
}



#pragma mark - 当用户取消时，调用该方法

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    NSLog(@"用户取消的拍摄！");
    // 隐藏UIImagePickerController
    [self dismissViewControllerAnimated:YES completion:nil];

}


#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:@"public.movie"]){
        //如果是视频
        NSURL *url = info[UIImagePickerControllerMediaURL];//获得视频的URL
        //保存至沙盒路径
        NSString *fileFolder = [[CWFileManager cachesDir] stringByAppendingString:@"/online/video"];
        if (![CWFileManager isExistsAtPath:fileFolder]) {
            [CWFileManager createDirectoryAtPath:fileFolder];
        }
        NSString *originalPath = [url.absoluteString stringByReplacingOccurrencesOfString:@"file://" withString:@""];
        NSString *videoName = [NSString stringWithFormat:@"%@.mp4", [CWFileStreamSeparation fileKeyMD5WithPath:originalPath]];
        NSString *sandboxPath = [fileFolder stringByAppendingPathComponent:videoName];
        [CWFileManager moveItemAtPath:originalPath toPath:sandboxPath overwrite:YES error:nil];
        NSLog(@"url %@",url);
        NSLog(@"sandboxPath %@",sandboxPath);
        self.sandboxPathStr = sandboxPath;
        UIImage *img = [self getScreenShotImageFromVideoPath:self.sandboxPathStr];
        [self postImgForVideo:img];
        
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}


/**
 *  获取视频的缩略图方法
 *
 *  @param filePath 视频的本地路径
 *
 *  @return 视频截图
 */
- (UIImage *)getScreenShotImageFromVideoPath:(NSString *)filePath{
    
    UIImage *shotImage;
    //视频路径URL
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:fileURL options:nil];
    
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    gen.appliesPreferredTrackTransform = YES;
    
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    
    NSError *error = nil;
    
    CMTime actualTime;
    
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    
    shotImage = [[UIImage alloc] initWithCGImage:image];
    
    
    
    CGImageRelease(image);
    
    return shotImage;
    
}





//获取当前时间戳
- (NSString *)currentTimeStr{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}


//获取七牛云上传token
- (void)GetQiniuTokenURLData {
    NSDictionary *dic = @{@"key":[UserManager key]};
    [[HttpRequestManager sharedSingleton] POST:GetQiniuTokenURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            NSLog(@"%@",[[responseObject objectForKey:@"data"] objectForKey:@"token"]);
            self.token = [[responseObject objectForKey:@"data"] objectForKey:@"token"];
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

@end
