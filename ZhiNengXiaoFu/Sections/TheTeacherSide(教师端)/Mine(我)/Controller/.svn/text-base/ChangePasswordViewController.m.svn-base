//
//  ChangePasswordViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/31.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView   *oldPasswordImgView;
@property (nonatomic, strong) UITextField   *oldPasswordText;
@property (nonatomic, strong) UIImageView   *ImgView;
@property (nonatomic, strong) UITextField   *passwordText;
@property (nonatomic, strong) UIImageView   *ImgView1;
@property (nonatomic, strong) UITextField   *againText;
@property (nonatomic, strong) UIButton      *submitBtn;
@property (nonatomic, strong) UIView        *lineView;
@property (nonatomic, strong) UIView        *lineView1;
@property (nonatomic, strong) UIView        *lineView2;

@end

@implementation ChangePasswordViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    [self makeChangePasswordViewControllerUI];
}

- (void)makeChangePasswordViewControllerUI {
    
    self.view.backgroundColor = backColor;
    self.oldPasswordText = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, APP_WIDTH - 60, 30)];
    self.oldPasswordText.font = titFont;
    self.oldPasswordText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入旧密码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]}];
    self.oldPasswordText.delegate = self;
    self.oldPasswordText.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.oldPasswordText];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(20, self.oldPasswordText.frame.size.height + 105, APP_WIDTH - 40, 1)];
    self.lineView.backgroundColor = fengeLineColor;
    [self.view addSubview:self.lineView];
    
    self.passwordText = [[UITextField alloc] initWithFrame:CGRectMake(20, self.oldPasswordText.frame.size.height + 120, self.oldPasswordText.frame.size.width, 30)];
    self.passwordText.font = titFont;
    self.passwordText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入新密码(6-18位字符)" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]}];
    self.passwordText.delegate = self;
    self.passwordText.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.passwordText];
    
    self.lineView1 = [[UIView alloc] initWithFrame:CGRectMake(20, self.oldPasswordText.frame.size.height + self.passwordText.frame.size.height + 125, APP_WIDTH - 40, 1)];
    self.lineView1.backgroundColor = fengeLineColor;
    [self.view addSubview:self.lineView1];
    
    self.againText = [[UITextField alloc] initWithFrame:CGRectMake(20, self.oldPasswordText.frame.size.height + self.passwordText.frame.size.height + 140, APP_WIDTH - 60, 30)];
    self.againText.font = titFont;
    self.againText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"确认新密码(6-18位字符)" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]}];
    self.againText.delegate = self;
    self.againText.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.againText];
    
    self.lineView2 = [[UIView alloc] initWithFrame:CGRectMake(20, self.oldPasswordText.frame.size.height + self.passwordText.frame.size.height + self.againText.frame.size.height + 145, APP_WIDTH - 40, 1)];
    self.lineView2.backgroundColor = fengeLineColor;
    [self.view addSubview:self.lineView2];
    
    self.submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, self.oldPasswordText.frame.size.height + self.passwordText.frame.size.height + self.againText.frame.size.height + 185, APP_WIDTH - 80, 40)];
    self.submitBtn.backgroundColor = THEMECOLOR;
    [self.submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    self.submitBtn.layer.masksToBounds = YES;
    self.submitBtn.layer.cornerRadius = 5;
    self.submitBtn.layer.borderColor = fengeLineColor.CGColor;
    self.submitBtn.layer.borderWidth = 1.0f;
    self.submitBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.submitBtn addTarget:self action:@selector(submitBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.submitBtn];

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSCharacterSet *characterSet = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFJHIGKLMNOPQRSTUVWXYZ1234567890"] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:characterSet] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}

- (void)submitBtn : (UIButton *)sender {
    NSLog(@"提交");
    
    if ([self.oldPasswordText.text isEqualToString:@""]) {
        [WProgressHUD showErrorAnimatedText:@"请输入旧密码"];
        return;
    }
    
    if ([self.passwordText.text isEqualToString:@""]) {
        [WProgressHUD showErrorAnimatedText:@"请输入新密码"];
        return;
    }
    
    if (self.passwordText.text.length < 6) {
        [WProgressHUD showErrorAnimatedText:@"请输入最少6位密码"];
        return;
    }
    
    if ([self.againText.text isEqualToString:@""]) {
        [WProgressHUD showErrorAnimatedText:@"请再次输入新密码"];
        return;
    }
    
    if (self.againText.text.length < 6) {
        [WProgressHUD showErrorAnimatedText:@"请输入最少6位密码"];
        return;
    }
    
    if (self.passwordText.text != self.againText.text) {
        [WProgressHUD showErrorAnimatedText:@"两次密码输入不一致"];
        return;
    } else {
        NSString *oldPasswordStr = [Encryption MD5ForLower32Bate:self.oldPasswordText.text];
        NSString *newPasswordStr = [Encryption MD5ForLower32Bate:self.againText.text];
        NSDictionary *dic = @{@"key":[UserManager key],@"old_password":oldPasswordStr,@"new_password":newPasswordStr};
        [self updatePasswordURLForData:dic];
    }
}

- (void)updatePasswordURLForData:(NSDictionary *)dic {
    [[HttpRequestManager sharedSingleton] POST:updatePasswordURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            [WProgressHUD showSuccessfulAnimatedText:[responseObject objectForKey:@"msg"]];
            [UserManager logoOut];
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
