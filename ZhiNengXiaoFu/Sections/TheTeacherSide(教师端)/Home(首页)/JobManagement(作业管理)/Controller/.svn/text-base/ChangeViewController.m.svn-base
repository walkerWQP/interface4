//
//  ChangeViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/8/13.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "ChangeViewController.h"

@interface ChangeViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UITextField *titleField;
@property (nonatomic, strong) UILabel     *contentLabel;
@property (nonatomic, strong) WTextView   *contentTextView;
@property (nonatomic, strong) UIButton    *changeBtn;

@end

@implementation ChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeChangeViewControllerUI];
}

- (void)makeChangeViewControllerUI {
    
   if ([self.typeID isEqualToString:@"1"]) {
       self.title = @"修改通知";
   } else {
       self.title = @"修改作业";
   }
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, APP_WIDTH - 40, 30)];
    if ([self.typeID isEqualToString:@"1"]) {
        self.titleLabel.text = @"通知标题";
    } else {
        self.titleLabel.text = @"作业标题";
    }
    
    self.titleLabel.tintColor = titlColor;
    self.titleLabel.font = titFont;
    [self.view addSubview:self.titleLabel];
    
    self.titleField = [[UITextField alloc] initWithFrame:CGRectMake(20, self.titleLabel.frame.size.height + 40, APP_WIDTH - 40, 40)];
    self.titleField.backgroundColor = [UIColor whiteColor];
    self.titleField.layer.masksToBounds = YES;
    self.titleField.layer.cornerRadius = 5;
    self.titleField.layer.borderColor = fengeLineColor.CGColor;
    self.titleField.layer.borderWidth = 1.0f;
    self.titleField.font = contentFont;
    if ([self.typeID isEqualToString:@"1"]) {
        self.titleField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入通知标题" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]}];
    } else {
        self.titleField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入作业标题" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]}];
    }
    
    self.titleField.delegate = self;
    self.titleField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.titleField.text = self.titleStr;
    [self.view addSubview:self.titleField];
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 60 + self.titleField.frame.size.height + self.titleLabel.frame.size.height, APP_WIDTH - 40, 30)];
    if ([self.typeID isEqualToString:@"1"]) {
        self.contentLabel.text = @"通知内容";
    } else {
        self.contentLabel.text = @"作业内容";
    }
    
    self.contentLabel.tintColor = titlColor;
    self.contentLabel.font = titFont;
    [self.view addSubview:self.contentLabel];
    
    self.contentTextView = [[WTextView alloc] initWithFrame:CGRectMake(20, 60 + self.titleField.frame.size.height + self.titleLabel.frame.size.height + self.contentLabel.frame.size.height, APP_WIDTH - 40, APP_HEIGHT * 0.3)];
    self.contentTextView.backgroundColor = [UIColor whiteColor];
    self.contentTextView.layer.masksToBounds = YES;
    self.contentTextView.layer.cornerRadius = 5;
    self.contentTextView.layer.borderColor = fengeLineColor.CGColor;
    self.contentTextView.layer.borderWidth = 1.0f;
    self.contentTextView.font = contentFont;
    if ([self.typeID isEqualToString:@"1"]) {
        self.contentTextView.placeholder = @"请输入通知内容...";
    } else {
        self.contentTextView.placeholder = @"请输入具体的作业...";
    }
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.contentTextView.text = self.content;
    [self.view addSubview:self.contentTextView];
    
    self.changeBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 100 + self.titleField.frame.size.height + self.titleLabel.frame.size.height + self.contentLabel.frame.size.height + self.contentTextView.frame.size.height, APP_WIDTH - 40, 40)];
    self.changeBtn.backgroundColor = THEMECOLOR;
    [self.changeBtn setTitle:@"发布修改" forState:UIControlStateNormal];
    self.changeBtn.layer.masksToBounds = YES;
    self.changeBtn.layer.cornerRadius = 5;
    self.changeBtn.layer.borderColor = fengeLineColor.CGColor;
    self.changeBtn.layer.borderWidth = 1.0f;
    self.changeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.changeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.changeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.changeBtn addTarget:self action:@selector(changeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.changeBtn];
    
}

- (void)changeBtn:(UIButton *)sender {
    NSLog(@"点击发布修改");
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"youkeState"] isEqualToString:@"1"]) {
        [WProgressHUD showErrorAnimatedText:@"游客不能进行此操作"];
        return;
    }
    
    
    if ([self.typeID isEqualToString:@"1"]) {
        if ([self.titleField.text isEqualToString:@""]) {
            [WProgressHUD showErrorAnimatedText:@"请输入通知标题"];
            return;
        }
        
        if ([self.contentTextView.text isEqualToString:@""]) {
            [WProgressHUD showErrorAnimatedText:@"请输入通知内容"];
            return;
        } else {
            NSDictionary *dic = @{@"key":[UserManager key],@"id":self.ID,@"title":self.titleField.text,@"content":self.contentTextView.text};
            [self UpdateNoticeURLData:dic];
        }
        
    } else {
        if ([self.titleField.text isEqualToString:@""]) {
            [WProgressHUD showErrorAnimatedText:@"请输入作业标题"];
            return;
        }
        if ([self.contentTextView.text isEqualToString:@""]) {
            [WProgressHUD showErrorAnimatedText:@"请输入作业内容"];
            return;
        } else {
            NSDictionary *dic = @{@"key":[UserManager key],@"id":self.ID,@"title":self.titleField.text,@"content":self.contentTextView.text};
            [self UpdateHomeWorkData:dic];
        }
    }

}

//修改通知
- (void)UpdateNoticeURLData:(NSDictionary *)dic {
    
    [[HttpRequestManager sharedSingleton] POST:updateNoticeURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
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

//修改作业
- (void)UpdateHomeWorkData:(NSDictionary *)dic {
    
    [[HttpRequestManager sharedSingleton] POST:updateHomeWork parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
      
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


@end
