//
//  ReplyViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/30.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "ReplyViewController.h"

@interface ReplyViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView        *bgView;
@property (nonatomic, strong) UIImageView   *headImgView;
@property (nonatomic, strong) UILabel       *problemLabel;
@property (nonatomic, strong) UILabel       *problemContentLabel;
@property (nonatomic, strong) UIView        *lineView;
@property (nonatomic, strong) WTextView     *replyTextField;
@property (nonatomic, strong) UIButton      *replyBtn;



@end

@implementation ReplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发表回复";
    [self makeReplyViewControllerUI];
}

- (void)makeReplyViewControllerUI {
    
    self.view.backgroundColor = backColor;
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, APP_WIDTH - 20, APP_HEIGHT * 0.3)];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bgView];
    self.headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 60, 60)];
    self.headImgView.layer.masksToBounds = YES;
    self.headImgView.layer.cornerRadius = 30;
    if ([self.headImg isEqualToString:@""]) {
        self.headImgView.image = [UIImage imageNamed:@"user"];
    } else {
        [self.headImgView sd_setImageWithURL:[NSURL URLWithString:self.headImg] placeholderImage:[UIImage imageNamed:@"user"]];
    }
    
    [self.bgView addSubview:self.headImgView];
    self.problemLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 + self.headImgView.frame.size.width, 10, self.bgView.frame.size.width - self.headImgView.frame.size.width - 30, 30)];
    self.problemLabel.textColor = titlColor;
    self.problemLabel.font = titFont;
    self.problemLabel.text = self.nameStr;
    [self.bgView addSubview:self.problemLabel];
    
    self.problemContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 + self.headImgView.frame.size.height, self.bgView.frame.size.width - 20, 30)];
    self.problemContentLabel.textColor = titlColor;
    self.problemContentLabel.font = titFont;
    self.problemContentLabel.text = self.problemStr;
    [self.bgView addSubview:self.problemContentLabel];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(10,self.headImgView.frame.size.height + self.problemContentLabel.frame.size.height + 15, self.bgView.frame.size.width - 20, 1)];
    self.lineView.backgroundColor = fengeLineColor;
    [self.bgView addSubview:self.lineView];
    
    self.replyTextField = [[WTextView alloc] initWithFrame:CGRectMake(10, self.headImgView.frame.size.height + self.problemContentLabel.frame.size.height + 30, self.bgView.frame.size.width - 20, 110)];
    self.replyTextField.backgroundColor = [UIColor whiteColor];
    self.replyTextField.layer.masksToBounds = YES;
    self.replyTextField.layer.cornerRadius = 5;
    self.replyTextField.layer.borderColor = fengeLineColor.CGColor;
    self.replyTextField.layer.borderWidth = 1.0f;
    self.replyTextField.font = contentFont;
    self.replyTextField.placeholder = @"请回复...";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.bgView addSubview:self.replyTextField];
    
    self.replyBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, self.bgView.frame.size.height + 60, APP_WIDTH - 40, 40)];
    self.replyBtn.backgroundColor = THEMECOLOR;
    [self.replyBtn setTitle:@"提交回复" forState:UIControlStateNormal];
    self.replyBtn.layer.masksToBounds = YES;
    self.replyBtn.layer.cornerRadius = 5;
    self.replyBtn.layer.borderColor = fengeLineColor.CGColor;
    self.replyBtn.layer.borderWidth = 1.0f;
    self.replyBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.replyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.replyBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.replyBtn addTarget:self action:@selector(replyBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.replyBtn];
}

- (void)replyBtn : (UIButton *)sender {
    NSLog(@"点击提交回复");  
    [self postDataForTeacherAnswerURL];
}

- (void)postDataForTeacherAnswerURL {
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"youkeState"] isEqualToString:@"1"]) {
        [WProgressHUD showErrorAnimatedText:@"游客不能进行此操作"];
        return;
    }else if ([self.replyTextField.text isEqualToString:@""]) {
        [WProgressHUD showErrorAnimatedText:@"回复不能为空"];
        return;
    } else {
        NSDictionary * dic = @{@"key":[UserManager key], @"id":self.ID,@"answer":self.replyTextField.text};
        [[HttpRequestManager sharedSingleton] POST:teacherAnswerURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
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


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    
}

@end
