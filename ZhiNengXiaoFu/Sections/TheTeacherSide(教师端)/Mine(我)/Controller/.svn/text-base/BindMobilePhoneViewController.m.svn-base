//
//  BindMobilePhoneViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/9/4.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "BindMobilePhoneViewController.h"

@interface BindMobilePhoneViewController ()<UITextFieldDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *launchEventScrollView;
@property (nonatomic, strong) UIImageView  *backImgView;
@property (nonatomic, strong) UIImageView  *whiteImgView;
@property (nonatomic, strong) UIImageView  *phoneImgView;
@property (nonatomic, strong) UILabel      *phoneLabel;
@property (nonatomic, strong) UIImageView  *phoneImg;
@property (nonatomic, strong) UITextField  *phoneTextField;
@property (nonatomic, strong) UIImageView  *verImgView;
@property (nonatomic, strong) UILabel      *verLabel;
@property (nonatomic, strong) UIImageView  *verificationImg;
@property (nonatomic, strong) UITextField  *verificationText;
@property (nonatomic, strong) UIButton     *verificationBtn;
@property (nonatomic, strong) UIImageView  *submitImgView;
@property (nonatomic, strong) UIButton     *submitBtn;


@end

@implementation BindMobilePhoneViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:RGB(44, 198, 255)] forBarMetrics:UIBarMetricsDefault];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回白"] style:UIBarButtonItemStyleDone target:self action:@selector(backButnClicked:)];
    self.navigationItem.leftBarButtonItem = back;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self makeBindMobilePhoneViewControllerUI];
}

- (void)backButnClicked:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
}

- (void)makeBindMobilePhoneViewControllerUI {
    
    if ([self.typeStr isEqualToString:@"1"]) {
        self.title = @"绑定手机号";
    } else if ([self.typeStr isEqualToString:@"2"]) {
        self.title = @"更换手机号";
    }
    
    self.launchEventScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT)];
    self.launchEventScrollView.backgroundColor = backColor;
    self.launchEventScrollView.contentSize = CGSizeMake(APP_WIDTH, APP_HEIGHT * 1.2);
    self.launchEventScrollView.bounces = YES;
    self.launchEventScrollView.indicatorStyle = UIScrollViewIndicatorStyleDefault;
    self.launchEventScrollView.maximumZoomScale = 2.0;//最多放大到两倍
    self.launchEventScrollView.minimumZoomScale = 0.5;//最多缩小到0.5倍
    self.launchEventScrollView.bouncesZoom = YES; //设置是否允许缩放超出倍数限制，超出后弹回
    self.launchEventScrollView.delegate = self;//设置委托
    [self.view addSubview:self.launchEventScrollView];
    
    self.backImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT * 0.4)];
    self.backImgView.image = [UIImage imageNamed:@"插画"];
    self.backImgView.userInteractionEnabled = YES;
    [self.launchEventScrollView addSubview:self.backImgView];
    
    self.whiteImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, APP_HEIGHT * 0.27, APP_WIDTH - 40, APP_HEIGHT * 0.4)];
    self.whiteImgView.image = [UIImage imageNamed:@"底版"];
    self.whiteImgView.userInteractionEnabled = YES;
    [self.launchEventScrollView addSubview:self.whiteImgView];
    
    self.phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 40, 50, 20)];
    self.phoneLabel.text = @"手机号";
    self.phoneLabel.textColor = titlColor;
    self.phoneLabel.font = titFont;
    [self.whiteImgView addSubview:self.phoneLabel];
    
    self.phoneImg = [[UIImageView alloc] initWithFrame:CGRectMake(40, 50 + self.phoneLabel.frame.size.height, self.whiteImgView.frame.size.width - 80, 30)];
    self.phoneImg.image = [UIImage imageNamed:@"信息框"];
    self.phoneImg.userInteractionEnabled = YES;
    [self.whiteImgView addSubview:self.phoneImg];
    
    self.phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.phoneImg.frame.size.width, 30)];
    self.phoneTextField.backgroundColor = [UIColor clearColor];
    if ([self.typeStr isEqualToString:@"1"]) {
        self.phoneTextField.placeholder = @"请输入手机号";
    } else if ([self.typeStr isEqualToString:@"2"]) {
        self.phoneTextField.placeholder = @"请输入新手机号";
    }
    [self.phoneTextField setValue:COLOR(51, 51, 51, 0.8) forKeyPath:@"_placeholderLabel.textColor"];
    [self.phoneTextField setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    self.phoneTextField.delegate = self;
    self.phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.phoneImg addSubview:self.phoneTextField];
    
    [self.whiteImgView addSubview:self.verImgView];
    
    self.verLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 80 + self.phoneLabel.frame.size.height + self.phoneTextField.frame.size.height, 50, 20)];
    self.verLabel.text = @"验证码";
    self.verLabel.textColor = titlColor;
    self.verLabel.font = titFont;
    [self.whiteImgView addSubview:self.verLabel];
    
    self.verificationImg = [[UIImageView alloc] initWithFrame:CGRectMake(40, 90 + self.phoneLabel.frame.size.height + self.phoneTextField.frame.size.height + self.verLabel.frame.size.height, self.whiteImgView.frame.size.width - 80, 30)];
    self.verificationImg.image = [UIImage imageNamed:@"信息框"];
    self.verificationImg.userInteractionEnabled = YES;
    [self.whiteImgView addSubview:self.verificationImg];
    
    self.verificationText = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.verificationImg.frame.size.width * 0.5, 30)];
    self.verificationText.backgroundColor = [UIColor clearColor];
    self.verificationText.placeholder = @"请输入验证码";
    [self.verificationText setValue:COLOR(51, 51, 51, 0.8) forKeyPath:@"_placeholderLabel.textColor"];
    [self.verificationText setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    self.verificationText.delegate = self;
    self.verificationText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.verificationText.keyboardType = UIKeyboardTypeNumberPad;
    [self.verificationImg addSubview:self.verificationText];
    
    self.verificationBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.verificationText.frame.size.width + 5, 0, self.verificationImg.frame.size.width - 10 - self.verificationText.frame.size.width, 30)];
    [self.verificationBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.verificationBtn setTitleColor:titlColor forState:UIControlStateNormal];
    self.verificationBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.verificationBtn addTarget:self action:@selector(verificationBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.verificationImg addSubview:self.verificationBtn];
    
    self.submitImgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.whiteImgView.frame.size.width - 140) / 2, self.whiteImgView.frame.size.height * 0.83, 140, 50)];
    self.submitImgView.image = [UIImage imageNamed:@"按钮"];
    self.submitImgView.userInteractionEnabled = YES;
    [self.whiteImgView addSubview:self.submitImgView];
    
    self.submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.submitImgView.frame.size.width, 50)];
    if ([self.typeStr isEqualToString:@"1"]) {
        [self.submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    } else if ([self.typeStr isEqualToString:@"2"]) {
        [self.submitBtn setTitle:@"更换" forState:UIControlStateNormal];
    }
    [self.submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.submitBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    self.submitBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.submitBtn addTarget:self action:@selector(submitBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.submitImgView addSubview:self.submitBtn];
    
}

#pragma mark ======= 提交 =======
- (void)submitBtn:(UIButton *)sender {
    if ([self.typeStr isEqualToString:@"1"]) { //绑定手机号码
        if ([self.phoneTextField.text isEqualToString:@""] || self.phoneTextField.text == nil) {
            [WProgressHUD showErrorAnimatedText:@"手机号不能为空,请重新输入"];
        } else if ([self valiMobile:self.phoneTextField.text] == NO) {
            [WProgressHUD showErrorAnimatedText:@"请输入正确的手机号码"];
        } else if ([self.verificationText.text isEqualToString:@""] || self.verificationText.text == nil) {
            [WProgressHUD showErrorAnimatedText:@"验证码不能为空,请重新输入"];
        } else {
            NSDictionary *dic = @{@"key":[UserManager key],@"mobile":self.phoneTextField.text,@"code":self.verificationText.text};
            [self bindMobile:dic];
        }
        
    } else if ([self.typeStr isEqualToString:@"2"]) { //更改绑定手机号码
        if ([self.phoneTextField.text isEqualToString:@""] || self.phoneTextField.text == nil) {
            [WProgressHUD showErrorAnimatedText:@"手机号不能为空,请重新输入"];
        } else if ([self valiMobile:self.phoneTextField.text] == NO) {
            [WProgressHUD showErrorAnimatedText:@"请输入正确的手机号码"];
        } else if ([self.verificationText.text isEqualToString:@""] || self.verificationText.text == nil) {
            [WProgressHUD showErrorAnimatedText:@"验证码不能为空,请重新输入"];
        } else {
            NSDictionary *dic = @{@"key":[UserManager key],@"mobile":self.phoneTextField.text,@"code":self.verificationText.text};
            [self changeMobile:dic];
        }
    }
}

#pragma mark ======= 更改绑定手机号码 =======
- (void)changeMobile:(NSDictionary *)dic {
    [WProgressHUD showHUDShowText:@"加载中..."];
    [[HttpRequestManager sharedSingleton] POST:ChangeMobileURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
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

#pragma mark ======= 绑定手机号 =======
- (void)bindMobile:(NSDictionary *)dic {
    [WProgressHUD showHUDShowText:@"加载中..."];
    [[HttpRequestManager sharedSingleton] POST:BindMobileURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
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

#pragma mark ======= 获取验证码 =======
- (void)verificationBtn:(UIButton *)sender {
    if ([self.phoneTextField.text isEqualToString:@""] || self.phoneTextField.text == nil) {
        [WProgressHUD showErrorAnimatedText:@"手机号不能为空,请重新输入"];
    } else if ([self valiMobile:self.phoneTextField.text] == NO) {
        [WProgressHUD showErrorAnimatedText:@"请输入正确的手机号码"];
    } else {
        NSLog(@"手机号正确");
        [self.verificationBtn startCountDownTime:60 withCountDownBlock:^{
            NSLog(@"开始倒计时");
            NSDictionary *dic = @{@"key":[UserManager key],@"mobile":self.phoneTextField.text};
            [self getSendCodeData:dic];
        }];
    }
}

- (void)getSendCodeData:(NSDictionary *)dic {
    [[HttpRequestManager sharedSingleton] POST:SendCodeURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            [WProgressHUD showSuccessfulAnimatedText:[responseObject objectForKey:@"msg"]];
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


#pragma mark ======= 判断手机号码格式是否正确 =======
- (BOOL)valiMobile:(NSString *)mobile {
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11) {
        return NO;
    } else {
        NSString *CM_NUM = @"1(3[0-9]|4[0-9]|5[0-9]|6[0-9]|7[0-9]|8[0-9]|9[0-9])\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        if (isMatch1) {
            return YES;
        } else {
            return NO;
        }
    }
}

    
#pragma mark - UIScrollViewDelegate
//返回缩放时所使用的UIView对象
- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return scrollView;
}

//开始缩放时调用
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view{
    
}

//结束缩放时调用，告知缩放比例
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    
}

//已经缩放时调用
- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    
}

//确定是否可以滚动到顶部
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{
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
