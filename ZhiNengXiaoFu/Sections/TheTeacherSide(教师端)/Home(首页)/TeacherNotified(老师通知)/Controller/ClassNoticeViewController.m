//
//  ClassNoticeViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/8/3.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "ClassNoticeViewController.h"
#import <Photos/Photos.h>

@interface ClassNoticeViewController ()<UITextFieldDelegate,LQPhotoPickerViewDelegate>

//通知名称
@property (nonatomic, strong) UILabel         *noticeNameLabel;
@property (nonatomic, strong) UITextField     *noticeNameTextField;
//通知内容内容
@property (nonatomic, strong) UILabel         *noticeContentLabel;
@property (nonatomic, strong) WTextView       *noticeContentTextView;
//上传图片内容
@property (nonatomic, strong) UILabel         *uploadPicturesLabel;
@property (nonatomic, strong) UIView          *myPicture;
@property (nonatomic, strong) NSMutableArray  *imgFiledArr;

@end

@implementation ClassNoticeViewController

- (NSMutableArray *)imgFiledArr {
    if (!_imgFiledArr) {
        _imgFiledArr = [NSMutableArray array];
    }
    return _imgFiledArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布通知";
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [button setTitle:@"发布" forState:UIControlStateNormal];
    button.titleLabel.font = titFont;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self makeClassNoticeViewControllerUI];
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        
    }];
}

- (void)makeClassNoticeViewControllerUI {
    
    self.view.backgroundColor = backColor;
    self.noticeNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, APP_WIDTH, 30)];
    self.noticeNameLabel.text = @"通知名称";
    self.noticeNameLabel.textColor =titlColor;
    self.noticeNameLabel.font = titFont;
    [self.view addSubview:self.noticeNameLabel];
    
    self.noticeNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, self.noticeNameLabel.frame.size.height + 10, APP_WIDTH - 20, 40)];
    self.noticeNameTextField.backgroundColor = [UIColor whiteColor];
    self.noticeNameTextField.layer.masksToBounds = YES;
    self.noticeNameTextField.layer.cornerRadius = 5;
    self.noticeNameTextField.layer.borderColor = fengeLineColor.CGColor;
    self.noticeNameTextField.layer.borderWidth = 1.0f;
    self.noticeNameTextField.font = contentFont;
    self.noticeNameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入通知标题" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]}];
    self.noticeNameTextField.delegate = self;
    self.noticeNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.noticeNameTextField];

    self.noticeContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.noticeNameLabel.frame.size.height + self.noticeNameTextField.frame.size.height + 30, APP_WIDTH - 20, 30)];
    self.noticeContentLabel.text = @"通知内容";
    self.noticeContentLabel.textColor = titlColor;
    self.noticeContentLabel.font = titFont;
    [self.view addSubview:self.noticeContentLabel];
    
    self.noticeContentTextView = [[WTextView alloc] initWithFrame:CGRectMake(10, self.noticeNameLabel.frame.size.height + self.noticeNameTextField.frame.size.height + self.noticeContentLabel.frame.size.height + 30, APP_WIDTH - 20, APP_HEIGHT * 0.3)];
    self.noticeContentTextView.backgroundColor = [UIColor whiteColor];
    self.noticeContentTextView.layer.masksToBounds = YES;
    self.noticeContentTextView.layer.cornerRadius = 5;
    self.noticeContentTextView.layer.borderColor = fengeLineColor.CGColor;
    self.noticeContentTextView.layer.borderWidth = 1.0f;
    self.noticeContentTextView.font = contentFont;
    self.noticeContentTextView.placeholder = @"请输入通知内容...";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.noticeContentTextView];
    
    self.uploadPicturesLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.noticeNameLabel.frame.size.height + self.noticeNameTextField.frame.size.height + self.noticeContentLabel.frame.size.height + self.noticeContentTextView.frame.size.height + 40, APP_WIDTH - 20, 30)];
    self.uploadPicturesLabel.text = @"上传图片内容(最多只能上传三张)";
    self.uploadPicturesLabel.textColor = titlColor;
    self.uploadPicturesLabel.font = titFont;
    [self.view addSubview:self.uploadPicturesLabel];
    
    self.myPicture = [[UIView alloc] initWithFrame:CGRectMake(10, self.noticeNameLabel.frame.size.height + self.noticeNameTextField.frame.size.height + self.noticeContentLabel.frame.size.height + self.noticeContentTextView.frame.size.height + self.uploadPicturesLabel.frame.size.height + 40, APP_WIDTH - 20, 80)];
    self.myPicture.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.myPicture];
    
    //打开照相机拍照
    if (!self.LQPhotoPicker_superView) {
        self.LQPhotoPicker_superView = self.myPicture;
        self.LQPhotoPicker_imgMaxCount = 3;
        [self LQPhotoPicker_initPickerView];
        self.LQPhotoPicker_delegate = self;
    }
}


- (void)rightBtn : (UIButton *)sender {
    NSLog(@"发送通知");
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"youkeState"] isEqualToString:@"1"]) {
        [WProgressHUD showErrorAnimatedText:@"游客不能进行此操作"];
        return;
    }
    if ([self.noticeNameTextField.text isEqualToString:@""]) {
        NSLog(@"请输入通知标题");
        [WProgressHUD showErrorAnimatedText:@"通知标题不能为空"];
        return;
    }
    if ([self.noticeContentTextView.text isEqualToString:@""]) {
        NSLog(@"请输入通知内容");
        [WProgressHUD showErrorAnimatedText:@"通知内容不能为空"];
        return;
    } else if (self.LQPhotoPicker_smallImageArray.count == 0) {
        NSDictionary *dataDic = [NSDictionary dictionary];
        dataDic = @{@"key":[UserManager key],@"class_id":self.classID,@"title":self.noticeNameTextField.text,@"content":self.noticeContentTextView.text,@"img":@""};
        [self postDataForRelease:dataDic];
    } else {
        [self setShangChuanTupian];
    }
}

- (void)setShangChuanTupian {
    
    [self LQPhotoPicker_getBigImageDataArray];
    NSDictionary *params = @{@"key":[UserManager key],@"upload_type":@"img", @"upload_img_type":@"notice"};
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
                NSData *fData = UIImageJPEGRepresentation(image, 0.5);
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
            dataDic = @{@"key":[UserManager key],@"class_id":self.classID,@"title":self.noticeNameTextField.text,@"content":self.noticeContentTextView.text,@"img":self.imgFiledArr};
            [self postDataForRelease:dataDic];
           
        } else {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
                [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
            } else {
                NSDictionary *dataDic = [NSDictionary dictionary];
                dataDic = @{@"key":[UserManager key],@"class_id":self.classID,@"title":self.noticeNameTextField.text,@"content":self.noticeContentTextView.text,@"img":@""};
                [self postDataForRelease:dataDic];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"%@", error);
         [WProgressHUD hideAllHUDAnimated:YES];
     }];
    
}

#pragma mark ======= 发布 =======
- (void)postDataForRelease:(NSDictionary *)dic{
        [WProgressHUD showHUDShowText:@"加载中..."];
        [[HttpRequestManager sharedSingleton] POST:publishURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
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

- (void)uploadPicturesBtn : (UIButton *)sender {
    NSLog(@"点击添加图片");
}

@end
