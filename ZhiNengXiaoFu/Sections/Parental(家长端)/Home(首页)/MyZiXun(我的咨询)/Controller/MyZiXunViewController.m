//
//  MyZiXunViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/8/3.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "MyZiXunViewController.h"
#import "HQPickerView.h"
#import "UserGetStuTeaModel.h"
@interface MyZiXunViewController ()<UITextViewDelegate, PickerViewResultDelegate>

@property (nonatomic, strong) UITextView         *myZiXunTextView;
@property (nonatomic, strong) UILabel            *chooseTeacherLabel;
@property (nonatomic, strong) NSMutableArray     *courseAry;
@property (nonatomic, strong) UserGetStuTeaModel *userGetStuTeaModel;
@end

@implementation MyZiXunViewController

- (NSMutableArray *)courseAry {
    if (!_courseAry) {
        self.courseAry = [@[]mutableCopy];
    }
    return _courseAry;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的咨询";
    self.view.backgroundColor = COLOR(247, 247, 247, 1);
    
    UILabel *questionLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 70, 20)];
    questionLabel.text = @"问题";
    questionLabel.textColor = COLOR(51, 51, 51, 1);
    questionLabel.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:questionLabel];
    
    self.myZiXunTextView = [[UITextView alloc] initWithFrame:CGRectMake(15, questionLabel.frame.origin.y + questionLabel.frame.size.height + 10, APP_WIDTH - 30, 100)];
    self.myZiXunTextView.text = @" 请输入问题";
    self.myZiXunTextView.font = [UIFont systemFontOfSize:15];
    self.myZiXunTextView.delegate = self;
    self.myZiXunTextView.textColor = COLOR(170, 170, 170, 1);
    self.myZiXunTextView.layer.cornerRadius = 4;
    self.myZiXunTextView.layer.masksToBounds = YES;
    self.myZiXunTextView.layer.borderColor = [UIColor colorWithRed:230 / 255.0 green:230 / 255.0 blue:230 / 255.0 alpha:1].CGColor;
    self.myZiXunTextView.layer.borderWidth = 1;
    [self.view addSubview:self.myZiXunTextView];
    
    UILabel *chooseTeacher = [[UILabel alloc] initWithFrame:CGRectMake(15, self.myZiXunTextView.frame.origin.y + self.myZiXunTextView.frame.size.height + 15, 100, 20)];
    chooseTeacher.text = @"选择老师";
    chooseTeacher.textColor = COLOR(51, 51, 51, 1);
    chooseTeacher.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:chooseTeacher];
    
    self.chooseTeacherLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, chooseTeacher.frame.origin.y + chooseTeacher.frame.size.height + 10, APP_WIDTH - 30, 50)];
    self.chooseTeacherLabel.text = @"  请输入老师名称";
    self.chooseTeacherLabel.font = [UIFont systemFontOfSize:15];
    self.chooseTeacherLabel.textColor = COLOR(170, 170, 170, 1);
    self.chooseTeacherLabel.backgroundColor = [UIColor whiteColor];
    self.chooseTeacherLabel.layer.cornerRadius = 4;
    self.chooseTeacherLabel.layer.masksToBounds = YES;
    self.chooseTeacherLabel.layer.borderColor = [UIColor colorWithRed:230 / 255.0 green:230 / 255.0 blue:230 / 255.0 alpha:1].CGColor;
    self.chooseTeacherLabel.layer.borderWidth = 1;
    [self.view addSubview:self.chooseTeacherLabel];
    
    UIImageView *xialaImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.chooseTeacherLabel.frame.size.width - 8 - 15, 22, 8, 6)];
    xialaImg.image = [UIImage imageNamed:@"下拉"];
    [self.chooseTeacherLabel addSubview:xialaImg];
    
    UITapGestureRecognizer *chooseTeacherTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseTeacherTap:)];
    self.chooseTeacherLabel.userInteractionEnabled = YES;
    [self.chooseTeacherLabel addGestureRecognizer:chooseTeacherTap];
    
    UIButton *submit = [[UIButton alloc] initWithFrame:CGRectMake(APP_WIDTH / 2 - 212 / 2, self.chooseTeacherLabel.frame.origin.y + self.chooseTeacherLabel.frame.size.height + 30, 212, 37)];
//    [submit setBackgroundImage:[UIImage imageNamed:@"提交问题"] forState:UIControlStateNormal];
    submit.layer.masksToBounds = YES;
    submit.layer.cornerRadius  = 5;
    submit.userInteractionEnabled = YES;
    submit.backgroundColor = THEMECOLOR;
    [submit setTitle:@"提交问题" forState:UIControlStateNormal];
    [submit addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:submit];
    
}

- (void)submit:(UIButton *)sender {
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"youkeState"] isEqualToString:@"1"]) {
        [WProgressHUD showErrorAnimatedText:@"游客不能进行此操作"];
        return;
    }
    
    if (![self.myZiXunTextView.text isEqualToString:@" 请输入问题"] && ![self.myZiXunTextView.text isEqualToString:@""]) {
        
        if (self.userGetStuTeaModel.teacher_id != nil) {
            NSDictionary *dic = @{@"teacher_id":self.userGetStuTeaModel.teacher_id, @"teacher_name":self.userGetStuTeaModel.teacher_name, @"course_name":self.userGetStuTeaModel.course_name, @"key":[UserManager key], @"question":self.myZiXunTextView.text};
            [[HttpRequestManager sharedSingleton] POST:ConsultQuestion parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
                if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
                    [WProgressHUD showSuccessfulAnimatedText:[responseObject objectForKey:@"msg"]];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"%@", error);
            }];
        } else {
            [WProgressHUD showErrorAnimatedText:@"老师名称不能为空"];
        }
       
    } else {
        [WProgressHUD showErrorAnimatedText:@"问题不能为空"];
    }
}



- (void)chooseTeacherTap:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
    NSDictionary *dic = @{@"key":[UserManager key]};
    [[HttpRequestManager sharedSingleton] POST:UserGetStudentTeachers parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            
            self.courseAry = [UserGetStuTeaModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            NSMutableArray *ary = [@[]mutableCopy];
            for (UserGetStuTeaModel * model in self.courseAry) {
                [ary addObject:[NSString stringWithFormat:@"%@ (%@)", model.teacher_name, model.course_name]];
            }
            
            PickerView *vi = [[PickerView alloc] init];
            vi.array = ary;
            vi.type = PickerViewTypeHeigh;
            vi.selectComponent = 0;
            vi.delegate = self;
            [[[UIApplication sharedApplication] keyWindow] addSubview:vi];

        } else {
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
    
  
}

-(void)pickerView:(UIView *)pickerView result:(NSString *)string index:(NSInteger)index {
    
    self.chooseTeacherLabel.text = [NSString stringWithFormat:@"  %@", string];
    if (self.courseAry.count == 0) {
        
    } else {
        self.userGetStuTeaModel = [self.courseAry objectAtIndex:index];
    }
}



#pragma mark - UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView {
    if(textView.text.length < 1){
        textView.text = @" 请输入问题";
        textView.textColor = [UIColor grayColor];
    }
}


- (void)textViewDidBeginEditing:(UITextView *)textView {
    if([textView.text isEqualToString:@" 请输入问题"]) {
        textView.text=@"";
        textView.textColor=[UIColor blackColor];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
