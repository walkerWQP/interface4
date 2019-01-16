//
//  LoginHomePageViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/23.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "LoginHomePageViewController.h"
#import "PrefixHeader.pch"
#import "TotalTabBarController.h"
#import "PersonInformationModel.h"

@interface LoginHomePageViewController ()

//记住登录选择图片
@property (nonatomic, strong) UIButton               *chooseBtn;
//教师选择图片
@property (nonatomic, strong) UIButton               *teacherChooseBtn;
//家长选择图片
@property (nonatomic, strong) UIButton               *parentChooseBtn;
//教师选中状态
@property (nonatomic, assign) NSInteger              teacherChooseState;
//家长选中状态
@property (nonatomic, assign) NSInteger              parentChooseState;
//记住登录状态
@property (nonatomic, assign) NSInteger              jizhuLoginChooseState;
//用户名
@property (nonatomic, strong) UITextField            *zhangHaoTextField;
//密码
@property (nonatomic, strong) UITextField            *miMaTextfield;

@property (nonatomic, strong) PersonInformationModel *personInfoModel;
//游客登录
@property (nonatomic, strong) UIButton               *youkeLogin;
@property (nonatomic, strong)  UILabel               *parentLabel;
@property (nonatomic, strong)  UILabel               *teacherLabel;
@end

@implementation LoginHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    self.view.backgroundColor = backColor;
    UIImageView *backImg  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 275)];
    backImg.image = [UIImage imageNamed:@"背景"];
    [self.view addSubview:backImg];
    
    self.parentChooseState = 0;
    self.teacherChooseState = 1;
    
    //用户名的背景view
    UIView *userName = [[UIView alloc] initWithFrame:CGRectMake(66, backImg.frame.origin.y + backImg.frame.size.height + 62 + 18 + 12, self.view.frame.size.width - 132, 1)];
    userName.backgroundColor = RGB(230, 230, 230);
    [self.view addSubview:userName];
    
    //用户名图片
    UIImageView *userImg  = [[UIImageView alloc] initWithFrame:CGRectMake(userName.frame.origin.x + 5, backImg.frame.origin.y + backImg.frame.size.height + 62, 16, 18)];
    userImg.image = [UIImage imageNamed:@"用户名"];
    [self.view addSubview:userImg];

    //用户名输入框
    self.zhangHaoTextField = [[UITextField alloc] initWithFrame:CGRectMake(userImg.frame.size.width + userImg.frame.origin.x + 10, backImg.frame.origin.y + backImg.frame.size.height + 64, userName.frame.size.width - 45, 18)];
    self.zhangHaoTextField.placeholder = @"手机号/账号";
    [self.zhangHaoTextField setValue:COLOR(119, 119, 119, 1) forKeyPath:@"_placeholderLabel.textColor"];
    [self.zhangHaoTextField setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    [self.view  addSubview:self.zhangHaoTextField];
    
    //密码背景图
    UIView *passWordView = [[UIView alloc] initWithFrame:CGRectMake(66, userName.frame.origin.y + userName.frame.size.height + 56, self.view.frame.size.width - 132, 1)];
    passWordView.backgroundColor = RGB(230, 230, 230);
    [self.view addSubview:passWordView];
    
    //密码图片
    UIImageView *mimaImg  = [[UIImageView alloc] initWithFrame:CGRectMake(passWordView.frame.origin.x + 5, userName.frame.origin.y + userName.frame.size.height + 35, 19, 10)];
    mimaImg.image = [UIImage imageNamed:@"密码"];
    [self.view addSubview:mimaImg];
    
    //密码输入框
    self.miMaTextfield = [[UITextField alloc] initWithFrame:CGRectMake(self.zhangHaoTextField.frame.origin.x, userName.frame.origin.y + userName.frame.size.height + 30, passWordView.frame.size.width - 45, 15)];
    self.miMaTextfield.placeholder = @"密码";
    [self.miMaTextfield setValue:COLOR(119, 119, 119, 1) forKeyPath:@"_placeholderLabel.textColor"];
    [self.miMaTextfield setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:self.miMaTextfield];
    
    //记住登录选择图片
    self.chooseBtn = [[UIButton alloc] initWithFrame:CGRectMake(userName.frame.origin.x, passWordView.frame.origin.y + passWordView.frame.size.height + 16, 13, 13)];
    [self.chooseBtn setBackgroundImage:[UIImage imageNamed:@"圆角矩形"] forState:UIControlStateNormal];
    [self.chooseBtn addTarget:self action:@selector(chooseBtn:) forControlEvents:UIControlEventTouchDown];
    self.chooseBtn.userInteractionEnabled = YES;
    [self.view addSubview:self.chooseBtn];
    
    //记住登录状态
    UILabel *jiZhuLoginState = [[UILabel alloc] initWithFrame:CGRectMake(self.chooseBtn.frame.size.width + self.chooseBtn.frame.origin.x + 5, self.chooseBtn.frame.origin.y, 80, 13)];
    jiZhuLoginState.text = @"记住登录状态";
    jiZhuLoginState.textColor = COLOR(170, 170, 170, 1);
    jiZhuLoginState.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:jiZhuLoginState];
    
    //家长
     self.parentLabel = [[UILabel alloc] initWithFrame:CGRectMake(passWordView.frame.origin.x + passWordView.frame.size.width + 10, self.chooseBtn.frame.origin.y, 28, 13)];
     self.parentLabel.textColor =  COLOR(170, 170, 170, 1);
     self.parentLabel.text = @"家长";
     self.parentLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview: self.parentLabel];
    
    //家长选择
    self.parentChooseBtn = [[UIButton alloc] initWithFrame:CGRectMake( self.parentLabel.frame.origin.x - 20, self.chooseBtn.frame.origin.y, 13, 13)];
    [self.parentChooseBtn setBackgroundImage:[UIImage imageNamed:@"圆角矩形"] forState:UIControlStateNormal];
//    [self.parentChooseBtn addTarget:self action:@selector(parentChooseBtn:) forControlEvents:UIControlEventTouchDown];
    self.parentChooseBtn.userInteractionEnabled = YES;
    [self.view addSubview:self.parentChooseBtn];
    
    UIButton *parentChooseBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.parentLabel.frame.origin.x - 20, self.chooseBtn.frame.origin.y - 3, 40, 25)];
    [parentChooseBtn addTarget:self action:@selector(parentChooseBtn:) forControlEvents:UIControlEventTouchDown];
    parentChooseBtn.userInteractionEnabled = YES;
     [self.view addSubview:parentChooseBtn];
    
    //教师
    self.teacherLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.parentChooseBtn.frame.origin.x - 28 - 15, self.chooseBtn.frame.origin.y, 28, 13)];
    self.teacherLabel.textColor =  RGBA(6, 189, 255, 1);

    self.teacherLabel.text = @"教师";
    self.teacherLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:self.teacherLabel];
    
    //教师选择
    self.teacherChooseBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.teacherLabel.frame.origin.x - 20, self.chooseBtn.frame.origin.y, 13, 13)];
    [self.teacherChooseBtn setBackgroundImage:[UIImage imageNamed:@"对勾"] forState:UIControlStateNormal];
//    [self.teacherChooseBtn addTarget:self action:@selector(teacherChooseBtn:) forControlEvents:UIControlEventTouchDown];
    self.teacherChooseBtn.userInteractionEnabled = YES;
    [self.view addSubview:self.teacherChooseBtn];
    
    
    UIButton *teacherChooseBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.teacherLabel.frame.origin.x - 20, self.chooseBtn.frame.origin.y - 3, 40, 25)];
    [teacherChooseBtn addTarget:self action:@selector(teacherChooseBtn:) forControlEvents:UIControlEventTouchDown];
    teacherChooseBtn.userInteractionEnabled = YES;
    [self.view addSubview:teacherChooseBtn];
    
    //登录
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(userName.frame.origin.x, jiZhuLoginState.frame.origin.y + jiZhuLoginState.frame.size.height + 32, APP_WIDTH - 132, 40)];
//    loginBtn.backgroundColor = COLOR(57, 218, 175, 1);
    [loginBtn setTitle:@"立即登录" forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"登录按钮"] forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.cornerRadius  = 20;
    [loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchDown];
    loginBtn.userInteractionEnabled = YES;
    [self.view addSubview:loginBtn];
    
    self.youkeLogin = [[UIButton alloc] initWithFrame:CGRectMake(APP_WIDTH  - 60 - 66, loginBtn.frame.origin.y + loginBtn.frame.size.height + 10, 60, 20)];
    [self.youkeLogin setTitle:@"游客登录" forState:UIControlStateNormal];
    self.youkeLogin.titleLabel.textAlignment = NSTextAlignmentRight;
    [self.youkeLogin addTarget:self action:@selector(youkeLogin:) forControlEvents:UIControlEventTouchDown];
    
    [self.youkeLogin setTitleColor:COLOR(170, 170, 170, 1) forState:UIControlStateNormal];
    self.youkeLogin.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:self.youkeLogin];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"shifouJizhuLogin"] isEqualToString:@"1"]) {
        self.zhangHaoTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"TeacherUserName"];
        self.miMaTextfield.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"TeacherUserMiMa"];
        self.jizhuLoginChooseState = 1;
        [self.chooseBtn setBackgroundImage:[UIImage imageNamed:@"对勾"] forState:UIControlStateNormal];
    } else {
        self.jizhuLoginChooseState = 0;
        [self.chooseBtn setBackgroundImage:[UIImage imageNamed:@"圆角矩形"] forState:UIControlStateNormal];
    }
    NSLog(@"JPUSHServiceIsRegistrationID%@", [JPUSHService registrationID]);
}

//游客登录
- (void)youkeLogin:(UIButton *)sender {
    if (self.teacherChooseState == 1 || self.parentChooseState == 1) {
        
        NSString *chooseLoginState = [[NSString alloc] init];
        if (self.teacherChooseState == 1) {
            chooseLoginState = @"2";
        } else if (self.parentChooseState == 1) {
            chooseLoginState = @"1";
        }
        
        NSDictionary * dic = @{@"identity":chooseLoginState};
        [WProgressHUD showHUDShowText:@"加载中..."];
        
        [[HttpRequestManager sharedSingleton] POST:indexVisitorLogin parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
            [WProgressHUD hideAllHUDAnimated:YES];
            
            if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
                 [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"youkeState"];
                if (self.teacherChooseState == 1) {
                    [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"chooseLoginState"];
                } else if (self.parentChooseState == 1) {
                    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"chooseLoginState"];
                }
                
                self.personInfoModel = [PersonInformationModel mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
                
                //存储学生和家长信息
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.personInfoModel];
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                [user setObject:data forKey:@"personInfo"];
                //同步到本地
                [user synchronize];
                [[NSUserDefaults standardUserDefaults] setObject:self.personInfoModel.key forKey:@"key"];
                [SingletonHelper manager].personInfoModel = self.personInfoModel;
                TotalTabBarController *totalTabBarVC = [[TotalTabBarController alloc] init];
                UIWindow *window = [UIApplication sharedApplication].keyWindow;
                //把自定义标签视图控制器totalTabBarVC 作为window的rootViewController(根视图控制器)
                
                [window.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                window.rootViewController = totalTabBarVC;
                [self.zhangHaoTextField resignFirstResponder];
                [self.miMaTextfield resignFirstResponder];
            } else {
                [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"%@", error);
            [WProgressHUD hideAllHUDAnimated:YES];
        }];
    }
}

//家长选择
- (void)parentChooseBtn:(UIButton *)sender {
    self.parentChooseState = 1;
    self.teacherChooseState = 0;
    [self.parentChooseBtn setBackgroundImage:[UIImage imageNamed:@"对勾"] forState:UIControlStateNormal];
    [self.teacherChooseBtn setBackgroundImage:[UIImage imageNamed:@"圆角矩形"] forState:UIControlStateNormal];
    
    self.parentLabel.textColor = RGBA(6, 189, 255, 1);
    self.teacherLabel.textColor = RGB(170,170,170);
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"ParentUserName"] == nil) {
        self.zhangHaoTextField.text = @"";
        self.miMaTextfield.text = @"";
    } else {
         self.zhangHaoTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"ParentUserName"];
        self.miMaTextfield.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"ParentUserMiMa"];
    }

}

//教师选择
- (void)teacherChooseBtn:(UIButton *)sender {
    self.teacherChooseState = 1;
    self.parentChooseState = 0;
    [self.teacherChooseBtn setBackgroundImage:[UIImage imageNamed:@"对勾"] forState:UIControlStateNormal];
    [self.parentChooseBtn setBackgroundImage:[UIImage imageNamed:@"圆角矩形"] forState:UIControlStateNormal];
    
    self.parentLabel.textColor = RGB(170,170,170);
    self.teacherLabel.textColor = RGBA(6, 189, 255, 1);
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"TeacherUserName"] == nil) {
        self.zhangHaoTextField.text = @"";
        self.miMaTextfield.text = @"";
    } else {
        self.zhangHaoTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"TeacherUserName"];
        self.miMaTextfield.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"TeacherUserMiMa"];
    }
}

- (void)chooseBtn:(UIButton *)sender {
    if (self.jizhuLoginChooseState == 0) {
        [self.chooseBtn setBackgroundImage:[UIImage imageNamed:@"对勾"] forState:UIControlStateNormal];
        self.jizhuLoginChooseState = 1;
    } else {
        [self.chooseBtn setBackgroundImage:[UIImage imageNamed:@"圆角矩形"] forState:UIControlStateNormal];
        self.jizhuLoginChooseState = 0;
    }
}

//登录
- (void)login:(UIButton *)sender {
    [self.view endEditing:YES];
    if (self.teacherChooseState == 1 || self.parentChooseState == 1) {
        NSString *chooseLoginState = [[NSString alloc] init];
        if (self.teacherChooseState == 1) {
            chooseLoginState = @"2";
        } else if (self.parentChooseState == 1) {
            chooseLoginState = @"1";
        }
        
        if ([self.zhangHaoTextField.text isEqualToString:@""] ) {
            [WProgressHUD showErrorAnimatedText:@"请输入用户名"];
        } else if ([self.miMaTextfield.text isEqualToString:@""]) {
            [WProgressHUD showErrorAnimatedText:@"请输入密码"];
        } else {
        
            NSString *newstr = [Encryption MD5ForLower32Bate:@"iosduxiu2018"];
            NSString *passwordStr = [Encryption MD5ForLower32Bate:self.miMaTextfield.text];
            NSString *system = [[SingletonHelper manager] encode:@"ios"];

            NSDictionary *dic = @{@"usernum":self.zhangHaoTextField.text, @"password":passwordStr, @"identity":chooseLoginState, @"system":system, @"sign":newstr};
            [WProgressHUD showHUDShowText:@"加载中..."];
            [[HttpRequestManager sharedSingleton] POST:LOGIN parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
                [WProgressHUD hideAllHUDAnimated:YES];
                if ([[responseObject objectForKey:@"status"] integerValue] == 200){
                    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"youkeState"];
                    if (self.jizhuLoginChooseState == 1) {
                     
                        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"shifouJizhuLogin"];
                        if (self.teacherChooseState == 1) {
                            [[NSUserDefaults standardUserDefaults] setObject:self.zhangHaoTextField.text forKey:@"TeacherUserName"];
                            [[NSUserDefaults standardUserDefaults] setObject:self.miMaTextfield.text forKey:@"TeacherUserMiMa"];
                        } else if (self.parentChooseState == 1) {
                            [[NSUserDefaults standardUserDefaults] setObject:self.zhangHaoTextField.text forKey:@"ParentUserName"];
                            [[NSUserDefaults standardUserDefaults] setObject:self.miMaTextfield.text forKey:@"ParentUserMiMa"];
                        }
                        
                    } else {
                        
                        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"shifouJizhuLogin"];
                        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"TeacherUserName"];
                        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"TeacherUserMiMa"];
                        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"ParentUserName"];
                        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"ParentUserMiMa"];
                    }
                    
                    
                    if (self.teacherChooseState == 1) {
                        [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"chooseLoginState"];
                    } else if (self.parentChooseState == 1) {
                        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"chooseLoginState"];
                    }
                    
                    self.personInfoModel = [PersonInformationModel mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
                    NSString *location_openStr = [NSString stringWithFormat:@"%ld",self.personInfoModel.location_open];
                    [[NSUserDefaults standardUserDefaults] setObject:location_openStr forKey:@"location_openStr"];
                    NSString *location_urlStr = [NSString stringWithFormat:@"%@",self.personInfoModel.location_url];
                    [[NSUserDefaults standardUserDefaults] setObject:location_urlStr forKey:@"location_urlStr"];
                    
                    NSString *easemob_num = [NSString stringWithFormat:@"%@",self.personInfoModel.easemob_num];
                    [[NSUserDefaults standardUserDefaults] setObject:easemob_num forKey:@"easemob_num"];
                    
                    
                    NSLog(@"%@",[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"easemob_num"]]);
                    
                    
                    if (![self.personInfoModel.easemob_num isEqualToString:@""]) {
                        [self loginWithUsername:[[NSUserDefaults standardUserDefaults] objectForKey:@"easemob_num"] password:@"000000"];
                    } else {
                        NSLog(@"%ld",(long)self.teacherChooseState);
                        if (self.teacherChooseState == 0) { //家长登陆 1
                            NSString *huanXinNum = [NSString stringWithFormat:@"%ld_%@_%@",self.personInfoModel.school_id,self.personInfoModel.ID,@"1"];
                            [self registeredLetter:huanXinNum];
                        } else {
                            NSString *huanXinNum = [NSString stringWithFormat:@"%ld_%@_%@",self.personInfoModel.school_id,self.personInfoModel.ID,@"2"];
                            [self registeredLetter:huanXinNum];
                        }
                    }
                    
                    //设置推送设置
                    [[EMClient sharedClient] setApnsNickname:self.personInfoModel.name];
                    
                    //存储学生和家长信息
                    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.personInfoModel];
                    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                    [user setObject:data forKey:@"personInfo"];
                    //同步到本地
                    [user synchronize];
                    
                    NSString *keyDic = [NSString stringWithFormat:@"%ld:%@:%@:%@", self.personInfoModel.school_id, self.personInfoModel.ID, chooseLoginState, self.personInfoModel.token];
                    NSString *key = [[SingletonHelper manager] encode:keyDic];
                    [[NSUserDefaults standardUserDefaults] setObject:key forKey:@"key"];
                  
                    [SingletonHelper manager].personInfoModel = self.personInfoModel;
                    TotalTabBarController *totalTabBarVC = [[TotalTabBarController alloc] init];
                    UIWindow *window = [UIApplication sharedApplication].keyWindow;
                    //把自定义标签视图控制器totalTabBarVC 作为window的rootViewController(根视图控制器)
                    
                    [window.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                    window.rootViewController = totalTabBarVC;
                    [self.zhangHaoTextField resignFirstResponder];
                    [self.miMaTextfield resignFirstResponder];
                    
//                    [self pushJiGuangId];
                } else {
                    [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
                }
               
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"%@", error);
                [WProgressHUD hideAllHUDAnimated:YES];
            }];
       }

    }
}

//注册环信
- (void)registeredLetter:(NSString *)userID {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = [[EMClient sharedClient] registerWithUsername:userID password:@"000000"];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                [self loginWithUsername:[[NSUserDefaults standardUserDefaults] objectForKey:@"easemob_num"] password:@"000000"];
                NSDictionary *dic = @{@"key":[UserManager key]};
                [[HttpRequestManager sharedSingleton] POST:SaveEasemobNumURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
                    NSLog(@"%@",[responseObject objectForKey:@"msg"]);
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    
                }];
            }else{
                switch (error.code) {
                    case EMErrorServerNotReachable:
                        TTAlertNoTitle(@"连接到服务器失败!");
                        break;
                    case EMErrorUserAlreadyExist:
                        
                    {
                        TTAlertNoTitle(@"您注册的用户已经存在!");
                        NSDictionary *dic = @{@"key":[UserManager key]};
                        [[HttpRequestManager sharedSingleton] POST:SaveEasemobNumURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
                            NSLog(@"%@",[responseObject objectForKey:@"msg"]);
                        } failure:^(NSURLSessionDataTask *task, NSError *error) {
                            
                        }];
                    }
                        break;
                    case EMErrorNetworkUnavailable:
                        TTAlertNoTitle(@"没有网络连接!");
                        break;
                    case EMErrorServerTimeout:
                        TTAlertNoTitle(@"连接到服务器超时!");
                        break;
                    case EMErrorServerServingForbidden:
                        TTAlertNoTitle(@"服务是被禁止的");
                        break;
                    case EMErrorExceedServiceLimit:
                        TTAlertNoTitle(@"超出服务限制");
                        break;
                    default:
                        TTAlertNoTitle(@"注册失败");
                        break;
                }
            }
        });
    });
}

//登录环信
- (void)loginHuanXin:(NSString *)huanXinID {
    __weak typeof(self) weakself = self;
    [[EMClient sharedClient] loginWithUsername:huanXinID token:@"000000" completion:^(NSString *aUsername, EMError *aError) {
        [weakself hideHud];
        if (!aError) {
            //保存最近一次登录用户名
            [weakself saveLastLoginUsername];
            //发送自动登陆状态通知
            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:[NSNumber numberWithBool:YES]];
            
        } else {
            TTAlertNoTitle(@"登录失败");
        }
    }];
}


//点击登陆后的操作
- (void)loginWithUsername:(NSString *)username password:(NSString *)password
{
    [self showHudInView:self.view hint:@"正在登录中..."];
    //异步登陆账号
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = [[EMClient sharedClient] loginWithUsername:username password:password];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakself hideHud];
            if (!error) {
                //设置是否自动登录
                [[EMClient sharedClient].options setIsAutoLogin:YES];
                
                //保存最近一次登录用户名
                [weakself saveLastLoginUsername];
                //发送自动登陆状态通知
                [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:[NSNumber numberWithBool:YES]];
                
            } else {
                switch (error.code)
                {
                    case EMErrorUserNotFound:
                        TTAlertNoTitle(@"用户不存在!");
                        break;
                    case EMErrorNetworkUnavailable:
                        TTAlertNoTitle(@"没有网络连接!");
                        break;
                    case EMErrorServerNotReachable:
                        TTAlertNoTitle(@"连接到服务器失败!");
                        break;
                    case EMErrorUserAuthenticationFailed:
                        TTAlertNoTitle(error.errorDescription);
                        break;
                    case EMErrorServerTimeout:
                        TTAlertNoTitle(@"连接到服务器超时!");
                        break;
                    case EMErrorServerServingForbidden:
                        TTAlertNoTitle(@"服务是被禁止的");
                        break;
                    case EMErrorUserLoginTooManyDevices:
                        TTAlertNoTitle(@"登录太多设备");
                        break;
                    default:
                        TTAlertNoTitle(@"登录失败");
                        break;
                }
            }
        });
    });
}



- (void)saveLastLoginUsername
{
    NSString *username = [[EMClient sharedClient] currentUsername];
    if (username && username.length > 0) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:username forKey:[NSString stringWithFormat:@"em_lastLogin_username"]];
        [ud synchronize];
    }
}

- (NSString*)lastLoginUsername
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *username = [ud objectForKey:[NSString stringWithFormat:@"em_lastLogin_username"]];
    if (username && username.length > 0) {
        return username;
    }
    return nil;
}

//- (void)pushJiGuangId
//{
//    if ([JPUSHService registrationID] == nil) {
//
//    }else
//    {
//
//        NSDictionary * dic = @{@"push_id":[JPUSHService registrationID], @"system":@"ios"};
//
//        [[HttpRequestManager sharedSingleton] POST:UserSavePushId parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
//            NSLog(@"%@", responseObject);
//
//            if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
//            }else
//            {
//                if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
//                    [UserManager logoOut];
//                }else
//                {
//
//                }
//                [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
//
//            }
//        } failure:^(NSURLSessionDataTask *task, NSError *error) {
//            NSLog(@"%@", error);
//        }];
//    }
//
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)backItem:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
