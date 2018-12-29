//
//  UploadPhotosViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/9/7.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "UploadPhotosViewController.h"
#import "PublishJobModel.h"
#import <Photos/Photos.h>

@interface UploadPhotosViewController ()<PickerViewResultDelegate,LQPhotoPickerViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UILabel         *nameLabel;
@property (nonatomic, strong) UIButton        *nameBtn;
//上传图片内容
@property (nonatomic, strong) UILabel         *uploadPicturesLabel;
@property (nonatomic, strong) UIView          *myPicture;
@property (nonatomic, strong) UIButton        *releasedBtn;
@property (nonatomic, strong) NSMutableArray  *publishJobArr;
@property (nonatomic, strong) NSMutableArray  *imgFiledArr;
@property (nonatomic, strong) NSString        *courseID;
@property (nonatomic, strong) UIScrollView    *ReleasedAlbumsScrollView;
//输入内容
@property (nonatomic, strong) UILabel         *shuRuNeiRonLabel;
@property (nonatomic, strong) WTextView       *shuRuNeiRonTextView;

@end

@implementation UploadPhotosViewController

- (NSMutableArray *)imgFiledArr {
    if (!_imgFiledArr) {
        _imgFiledArr = [NSMutableArray array];
    }
    return _imgFiledArr;
}

- (NSMutableArray *)publishJobArr {
    if (!_publishJobArr) {
        _publishJobArr = [NSMutableArray array];
    }
    return _publishJobArr;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"发布相册";
    self.view.backgroundColor = backColor;
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        
    }];
    [self makeReleasedAlbumsViewControllerUI];
    
}

- (void)makeReleasedAlbumsViewControllerUI {
    
    self.ReleasedAlbumsScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT)];
    self.ReleasedAlbumsScrollView.backgroundColor = backColor;
    self.ReleasedAlbumsScrollView.contentSize = CGSizeMake(APP_WIDTH, APP_HEIGHT * 1.5);
    self.ReleasedAlbumsScrollView.bounces = YES;
    self.ReleasedAlbumsScrollView.indicatorStyle = UIScrollViewIndicatorStyleDefault;
    
    self.ReleasedAlbumsScrollView.maximumZoomScale = 1.2;//最多放大到两倍
    self.ReleasedAlbumsScrollView.minimumZoomScale = 0.5;//最多缩小到0.5倍
    //设置是否允许缩放超出倍数限制，超出后弹回
    self.ReleasedAlbumsScrollView.bouncesZoom = YES;
    //设置委托
    self.ReleasedAlbumsScrollView.delegate = self;
    [self.view addSubview:self.ReleasedAlbumsScrollView];
    if ([self.typeStr isEqualToString:@"1"]) {
        self.shuRuNeiRonLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, APP_WIDTH - 20, 20)];
        self.shuRuNeiRonLabel.text = @"请输入内容";
        self.shuRuNeiRonLabel.textColor = titlColor;
        self.shuRuNeiRonLabel.font = titFont;
        [self.ReleasedAlbumsScrollView addSubview:self.shuRuNeiRonLabel];

        self.shuRuNeiRonTextView = [[WTextView alloc] initWithFrame:CGRectMake(10, self.shuRuNeiRonLabel.frame.origin.y + self.shuRuNeiRonLabel.frame.size.height + 15, APP_WIDTH - 20, 100)];
        self.shuRuNeiRonTextView.placeholder = @"请输入内容...";
        self.shuRuNeiRonTextView.textColor = titlColor;
        self.shuRuNeiRonTextView.layer.masksToBounds = YES;
        self.shuRuNeiRonTextView.layer.cornerRadius = 5;
        self.shuRuNeiRonTextView.layer.borderColor = fengeLineColor.CGColor;
        self.shuRuNeiRonTextView.layer.borderWidth = 1.0f;
        [self.ReleasedAlbumsScrollView addSubview:self.shuRuNeiRonTextView];
        
        self.uploadPicturesLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.shuRuNeiRonTextView.frame.size.height + self.shuRuNeiRonTextView.frame.origin.y + 15, APP_WIDTH - 20, 30)];
        self.uploadPicturesLabel.text = @"上传图片内容(最多只能上传九张)";
        self.uploadPicturesLabel.textColor = titlColor;
        self.uploadPicturesLabel.font = titFont;
        [self.ReleasedAlbumsScrollView addSubview:self.uploadPicturesLabel];
        
        self.myPicture = [[UIView alloc] initWithFrame:CGRectMake(0, self.uploadPicturesLabel.frame.size.height + self.uploadPicturesLabel.frame.origin.y + 15, APP_WIDTH - 20, 240)];
        self.myPicture.backgroundColor = [UIColor whiteColor];
        [self.ReleasedAlbumsScrollView addSubview:self.myPicture];
        
        if (!self.LQPhotoPicker_superView) {
            self.LQPhotoPicker_superView = self.myPicture;
            self.LQPhotoPicker_imgMaxCount = 9;
            [self LQPhotoPicker_initPickerView];
            self.LQPhotoPicker_delegate = self;
        }
    } else {
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, APP_WIDTH - 40, 30)];
        self.nameLabel.text = @"请选择班级";
        self.nameLabel.textColor = titlColor;
        self.nameLabel.font = titFont;
        [self.ReleasedAlbumsScrollView addSubview:self.nameLabel];
        
        self.nameBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, self.nameLabel.frame.size.height + self.nameLabel.frame.origin.y + 15, APP_WIDTH - 20, 40)];
        self.nameBtn.backgroundColor = [UIColor whiteColor];
        [self.nameBtn setTitle:@"请选择班级" forState:UIControlStateNormal];
        self.nameBtn.layer.masksToBounds = YES;
        self.nameBtn.layer.cornerRadius = 5;
        self.nameBtn.layer.borderColor = fengeLineColor.CGColor;
        self.nameBtn.layer.borderWidth = 1.0f;
        self.nameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.nameBtn setTitleColor:backTitleColor forState:UIControlStateNormal];
        self.nameBtn.titleLabel.font = contentFont;
        [self.nameBtn addTarget:self action:@selector(nameBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.ReleasedAlbumsScrollView addSubview:self.nameBtn];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.nameBtn.frame.size.width - 30, 15, 10, 10)];
        imgView.image = [UIImage imageNamed:@"下拉"];
        [self.nameBtn addSubview:imgView];
        
        self.shuRuNeiRonLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.nameBtn.frame.origin.y + self.nameBtn.frame.size.height + 15, APP_WIDTH - 20, 20)];
        self.shuRuNeiRonLabel.text = @"请输入内容";
        self.shuRuNeiRonLabel.textColor = titlColor;
        self.shuRuNeiRonLabel.font = titFont;
        [self.ReleasedAlbumsScrollView addSubview:self.shuRuNeiRonLabel];
        
        self.shuRuNeiRonTextView = [[WTextView alloc] initWithFrame:CGRectMake(10, self.shuRuNeiRonLabel.frame.origin.y + self.shuRuNeiRonLabel.frame.size.height + 15, APP_WIDTH - 20, 100)];
        self.shuRuNeiRonTextView.placeholder = @"请输入内容...";
        self.shuRuNeiRonTextView.textColor = titlColor;
        self.shuRuNeiRonTextView.layer.masksToBounds = YES;
        self.shuRuNeiRonTextView.layer.cornerRadius = 5;
        self.shuRuNeiRonTextView.layer.borderColor = fengeLineColor.CGColor;
        self.shuRuNeiRonTextView.layer.borderWidth = 1.0f;
        [self.ReleasedAlbumsScrollView addSubview:self.shuRuNeiRonTextView];
        
        self.uploadPicturesLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.shuRuNeiRonTextView.frame.size.height + self.shuRuNeiRonTextView.frame.origin.y + 15, APP_WIDTH - 20, 30)];
        self.uploadPicturesLabel.text = @"上传图片内容(最多只能上传九张)";
        self.uploadPicturesLabel.textColor = titlColor;
        self.uploadPicturesLabel.font = titFont;
        [self.ReleasedAlbumsScrollView addSubview:self.uploadPicturesLabel];

        self.myPicture = [[UIView alloc] initWithFrame:CGRectMake(0, self.uploadPicturesLabel.frame.size.height + self.uploadPicturesLabel.frame.origin.y + 15, APP_WIDTH - 20, 240)];
        self.myPicture.backgroundColor = [UIColor whiteColor];

        [self.ReleasedAlbumsScrollView addSubview:self.myPicture];
        
        if (!self.LQPhotoPicker_superView) {
            self.LQPhotoPicker_superView = self.myPicture;
            self.LQPhotoPicker_imgMaxCount = 9;
            [self LQPhotoPicker_initPickerView];
            self.LQPhotoPicker_delegate = self;
        }
    }
    
    self.releasedBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [self.releasedBtn setTitle:@"发布" forState:UIControlStateNormal];
    self.releasedBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.releasedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.releasedBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.releasedBtn addTarget:self action:@selector(releasedBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.releasedBtn];
    
}

- (void)releasedBtn:(UIButton *)sender {
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"youkeState"] isEqualToString:@"1"]) {
        [WProgressHUD showErrorAnimatedText:@"游客不能进行此操作"];
        return;
    }
    
    if ([self.typeStr isEqualToString:@"1"]) {
         if ([self.shuRuNeiRonTextView.text isEqualToString:@""] && self.LQPhotoPicker_smallImageArray.count == 0) {
            [WProgressHUD showErrorAnimatedText:@"请输入内容或添加图片"];
            return;
        } else if (self.LQPhotoPicker_smallImageArray.count == 0) {
            NSDictionary *dataDic = [NSDictionary dictionary];
            dataDic = @{@"key":[UserManager key],@"img":self.imgFiledArr, @"content":self.shuRuNeiRonTextView.text};
            [self postDataForUploadURL:dataDic];
        } else if ([self.shuRuNeiRonTextView.text isEqualToString:@""]) {
            [self setShangChuanTupian];
        } else {
            [self setShangChuanTupian];
        }
        
    } else {
        if (self.courseID == nil) {
            [WProgressHUD showErrorAnimatedText:@"请选择班级"];
            return;
        } if ([self.shuRuNeiRonTextView.text isEqualToString:@""] && self.LQPhotoPicker_smallImageArray.count == 0) {
            [WProgressHUD showErrorAnimatedText:@"请输入内容或添加图片"];
            return;
        } else if (self.LQPhotoPicker_smallImageArray.count == 0) {
            NSDictionary *dataDic = [NSDictionary dictionary];
            dataDic = @{@"key":[UserManager key],@"class_id":self.courseID,@"img":self.imgFiledArr, @"content":self.shuRuNeiRonTextView.text};
            [self postDataForUploadURL:dataDic];
        } else if ([self.shuRuNeiRonTextView.text isEqualToString:@""]) {
            [self setShangChuanTupian];
        } else {
            [self setShangChuanTupian];
        }
    }

}

- (void)nameBtn:(UIButton *)sender {
    [self getClassURLData];
}

- (void)setShangChuanTupian {
    
    [self LQPhotoPicker_getBigImageDataArray];
    NSDictionary * params = @{@"key":[UserManager key],@"upload_type":@"img", @"upload_img_type":@"album"};
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
            
            if (length>1280) {
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
        
            if ([self.typeStr isEqualToString:@"1"]) {
                dataDic = @{@"key":[UserManager key],@"img":self.imgFiledArr, @"content":self.shuRuNeiRonTextView.text};
            } else {
                dataDic = @{@"key":[UserManager key],@"class_id":self.courseID,@"img":self.imgFiledArr, @"content":self.shuRuNeiRonTextView.text};
            }
            
            [self postDataForUploadURL:dataDic];
            
        } else {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
            } else {
                
            }
            [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [WProgressHUD hideAllHUDAnimated:YES];
    }];
    
}

- (void)postDataForUploadURL:(NSDictionary *)dic {
    [WProgressHUD showHUDShowText:@"加载中..."];
    [[HttpRequestManager sharedSingleton] POST:indexAlbumAddAlbum parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            
            [WProgressHUD showSuccessfulAnimatedText:[responseObject objectForKey:@"msg"]];
            [self.navigationController popViewControllerAnimated:YES];
            
        } else {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
            }
            [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [WProgressHUD hideAllHUDAnimated:YES];
    }];
}

- (void)getClassURLData {
    NSDictionary *dic = @{@"key":[UserManager key]};
    [[HttpRequestManager sharedSingleton] POST:getClassURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            self.publishJobArr = [PublishJobModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            NSMutableArray * ary = [@[]mutableCopy];
            for (PublishJobModel * model in self.publishJobArr) {
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

-(void)pickerView:(UIView *)pickerView result:(NSString *)string index:(NSInteger)index {
    if (self.publishJobArr.count != 0) {
        [self.nameBtn setTitle:string forState:UIControlStateNormal];
        PublishJobModel *model = [self.publishJobArr objectAtIndex:index];
        self.courseID = model.ID;
    }
}


@end
