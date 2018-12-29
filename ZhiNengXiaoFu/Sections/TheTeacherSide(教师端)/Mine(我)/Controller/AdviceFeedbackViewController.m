//
//  AdviceFeedbackViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/31.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "AdviceFeedbackViewController.h"

@interface AdviceFeedbackViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) WTextView     *contentTextView;
@property (nonatomic, strong) UIButton      *submitBtn;

@end

@implementation AdviceFeedbackViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"建议与反馈";
    [self makeAdviceFeedbackViewControllerUI];
}

- (void)makeAdviceFeedbackViewControllerUI {
    
    self.view.backgroundColor = backColor;
    self.contentTextView = [[WTextView alloc] initWithFrame:CGRectMake(20, 40, APP_WIDTH - 40, APP_HEIGHT * 0.3)];
    self.contentTextView.backgroundColor = [UIColor whiteColor];
    self.contentTextView.font = contentFont;
    self.contentTextView.placeholder = @"请输入反馈内容...";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.contentTextView];
    
    self.submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, self.contentTextView.frame.size.height + 80, APP_WIDTH - 80, 40)];
    self.submitBtn.backgroundColor = THEMECOLOR;
    [self.submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    self.submitBtn.layer.masksToBounds = YES;
    self.submitBtn.layer.cornerRadius  = 5;
    self.submitBtn.layer.borderColor   = fengeLineColor.CGColor;
    self.submitBtn.layer.borderWidth   = 1.0f;
    self.submitBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.submitBtn addTarget:self action:@selector(submitBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.submitBtn];
    
}

- (void)submitBtn : (UIButton *)sender {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"youkeState"] isEqualToString:@"1"]) {
        [WProgressHUD showErrorAnimatedText:@"游客不能进行此操作"];
    } else {
        if ([self.contentTextView.text isEqualToString:@""]) {
            [WProgressHUD showErrorAnimatedText:@"反馈内容不能为空"];
            return;
        } else {
            NSDictionary *dic = @{@"key":[UserManager key],@"content":self.contentTextView.text};
            [self postDataForSuggestURL:dic];
        }
    }
}

- (void)postDataForSuggestURL:(NSDictionary *)dic {
    [WProgressHUD showHUDShowText:@"加载中..."];
    [[HttpRequestManager sharedSingleton] POST:suggestURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
