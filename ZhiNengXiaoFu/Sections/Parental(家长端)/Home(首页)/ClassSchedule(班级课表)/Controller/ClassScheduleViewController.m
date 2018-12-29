//
//  ClassScheduleViewController.m
//  ZhiNengXiaoFu
//
//  Created by 独秀科技 on 2018/12/17.
//  Copyright © 2018 henanduxiu. All rights reserved.
//

#import "ClassScheduleViewController.h"
#import "PublishJobModel.h"
#import "ClassListViewController.h"
#import "InformationCollectionModel.h"
#import "ClassScheduleModel.h"
#import "PersonInformationModel.h"
#import "LeftCell.h"
#import "RightCell.h"

@interface ClassScheduleViewController ()<WPopupMenuDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UIView                  *titleView;
@property (nonatomic, strong) UIButton                *classBtn;
@property (nonatomic, strong) NSMutableArray          *classNameArr;
@property (nonatomic, strong) UIButton                *rightBtn;
@property (nonatomic, strong) NSArray                 *arr;
@property (nonatomic, strong) NSMutableArray          *classScheduleArr;
//是否是班主任0否1是
@property (nonatomic, assign) NSInteger               is_adviser;
@property (nonatomic, strong) PersonInformationModel  *personInfo;
@property (nonatomic, strong) NSMutableArray          *timeArr;
@property (nonatomic, strong) UIScrollView            *classScheduleScrollView;


@end

@implementation ClassScheduleViewController

- (NSMutableArray *)timeArr {
    if (!_timeArr) {
        _timeArr = [NSMutableArray array];
    }
    return _timeArr;
}

- (NSMutableArray *)classScheduleArr {
    if (!_classScheduleArr) {
        _classScheduleArr = [NSMutableArray array];
    }
    return _classScheduleArr;
}

- (NSMutableArray *)classNameArr {
    if (!_classNameArr) {
        _classNameArr = [NSMutableArray array];
    }
    return _classNameArr;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    if (self.titleStr != nil) {
        self.title = self.titleStr;
        NSDictionary *dic = @{@"key":[UserManager key]};
        [self GetCourseListURLData:dic];
    } else {
        NSLog(@"教师进入");
        self.classBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        self.classBtn.frame=CGRectMake(20, 20, 130, 30);
        [self.classBtn setTitle: self.className forState:UIControlStateNormal];
        [self.classBtn addTarget:self action:@selector(classBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.classBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.navigationItem.titleView = self.classBtn;
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(105, 2, 30, 30)];
        img.image = [UIImage imageNamed:@"向下"];
        [self.classBtn addSubview:img];
        
        if ([self.typeStr isEqualToString:@"1"]) {
            NSLog(@"1");
            
            self.rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
            [self.rightBtn setImage:[UIImage imageNamed:@"加号"] forState:UIControlStateNormal];
            self.rightBtn.titleLabel.font = titFont;
            [self.rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
            
            UIImage *image = [UIImage imageNamed:@"课节"];
            YCMenuAction *action = [YCMenuAction actionWithTitle:@"添加课节" image:image handler:^(YCMenuAction *action) {
                ClassListViewController *classListVC = [ClassListViewController new];
                classListVC.class_id = self.classID;
                [self.navigationController pushViewController:classListVC animated:YES];
            }];
            self.arr = @[action];
            //            [self setUser];
            NSDictionary * dic = @{@"key":[UserManager key]};
            [[HttpRequestManager sharedSingleton] POST:getUserInfoURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
                if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
                    
                    self.personInfo = [PersonInformationModel mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
                    if (self.personInfo.is_adviser == 1) {
                        NSDictionary *dic = @{@"key":[UserManager key],@"class_id":self.classID,@"is_adviser":[NSString stringWithFormat:@"%ld",self.personInfo.is_adviser]};
                        [self GetCourseListURLData:dic];
                    } else if (self.classID != nil) {
                        NSDictionary *dic = @{@"key":[UserManager key],@"class_id":self.classID};
                        [self GetCourseListURLData:dic];
                    }
                } else {
                    if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                        [UserManager logoOut];
                    } else {
                        
                    }
                    [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
                }
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"%@", error);
            }];
            
        } else {
            NSDictionary *dic = @{@"key":[UserManager key],@"class_id":self.classID};
            [self GetCourseListURLData:dic];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)GetCourseListURLData:(NSDictionary *)dic {
    [[HttpRequestManager sharedSingleton] POST:GetCourseListURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            [self.classScheduleArr removeAllObjects];
            [self.timeArr removeAllObjects];
            [self.classScheduleArr removeAllObjects];
            for (NSDictionary *dic in [responseObject objectForKey:@"data"]) {
                ClassScheduleModel *model = [[ClassScheduleModel alloc] init];
                model.start = [dic objectForKey:@"start"];
                model.end   = [dic objectForKey:@"end"];
                [self.timeArr addObject:model];

                NSMutableArray *courseArr = [dic objectForKey:@"course"];
                for (ClassScheduleModel *model1 in courseArr) {
                    [self.classScheduleArr addObject:model1];
                }
            }
            
           [self makeClassScheduleViewControllerUI];
            
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



- (void)rightBtn:(UIButton *)sender {
    NSLog(@"添加");
    YCMenuView *view = [YCMenuView menuWithActions:self.arr width:140 relyonView:sender];
    view.maxDisplayCount = 10;
    [view show];
}



- (void)classBtn:(UIButton *)sender {
    NSLog(@"点击班级按钮");
    if ([self.typeStr isEqualToString:@"1"]) {
        NSLog(@"%@",self.typeStr);
        [self getClassURLDataForClassID1];
    } else {
        NSLog(@"%@",self.typeStr);
        [self getClassURLDataForClassID];
    }
    
}

#pragma mark ======= 教师获取自己管理的班级（是班主任的班级） =======
- (void)getClassURLDataForClassID1 {
    NSDictionary *dic = @{@"key":[UserManager key]};
    [[HttpRequestManager sharedSingleton] POST:GetAdviserClassURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            self.classNameArr = [InformationCollectionModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            NSMutableArray *ary = [@[]mutableCopy];
            for (InformationCollectionModel *model in self.classNameArr) {
                [ary addObject:[NSString stringWithFormat:@"%@", model.name]];
            }
            if (ary.count == 0) {
                [WProgressHUD showErrorAnimatedText:@"数据不正确,请重试"];
            } else {
                [WPopupMenu showRelyOnView:self.classBtn titles:ary icons:nil menuWidth:140 delegate:self];
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


#pragma mark ======= 获取教师班级列表数据 =======
- (void)getClassURLDataForClassID {
    [WProgressHUD showHUDShowText:@"正在加载中..."];
    NSDictionary *dic = @{@"key":[UserManager key]};
    [[HttpRequestManager sharedSingleton] POST:getClassURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            [WProgressHUD hideAllHUDAnimated:YES];
            self.classNameArr = [PublishJobModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            NSMutableArray * ary = [@[]mutableCopy];
            for (PublishJobModel * model in self.classNameArr) {
                [ary addObject:[NSString stringWithFormat:@"%@", model.name]];
            }
            if (ary.count == 0) {
                [WProgressHUD showErrorAnimatedText:@"数据不正确,请重试"];
            } else {
                [WPopupMenu showRelyOnView:self.classBtn titles:ary icons:nil menuWidth:140 delegate:self];
            }
            
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

#pragma mark - YBPopupMenuDelegate
- (void)WPopupMenuDidSelectedAtIndex:(NSInteger)index WPopupMenu:(WPopupMenu *)WPopupMenu {
    PublishJobModel *model = [self.classNameArr objectAtIndex:index];
    if (model.ID == nil || model.name == nil) {
        [WProgressHUD showSuccessfulAnimatedText:@"数据不正确,请重试"];
    } else {
        self.classID = model.ID;
        
        [self.classBtn setTitle:model.name forState:UIControlStateNormal];
        
        if (self.personInfo.is_adviser == 1) {
            NSDictionary *dic = @{@"key":[UserManager key],@"class_id":self.classID,@"is_adviser":[NSString stringWithFormat:@"%ld",self.personInfo.is_adviser]};
            [self GetCourseListURLData:dic];
        } else if (self.classID != nil) {
            NSDictionary *dic = @{@"key":[UserManager key],@"class_id":self.classID};
            [self GetCourseListURLData:dic];
        }
        
    }
}


- (void)makeClassScheduleViewControllerUI {
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:date];
    NSLog(@"%@",[weekdays objectAtIndex:theComponents.weekday]);
    
    self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 40)];
    self.titleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.titleView];
    
    for (int i = 0; i < 7; i ++) {
        UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(60 + i * (APP_WIDTH - 100) / 7  + (i + 1) * 5 , 5, (APP_WIDTH - 100) / 7, 30)];
        switch (i) {
            case 0:
                numLabel.text = @"周一";
                break;
            case 1:
                numLabel.text = @"周二";
                break;
            case 2:
                numLabel.text = @"周三";
                break;
            case 3:
                numLabel.text = @"周四";
                break;
            case 4:
                numLabel.text = @"周五";
                break;
            case 5:
                numLabel.text = @"周六";
                break;
            case 6:
                numLabel.text = @"周日";
                break;
                
            default:
                break;
        }
        
        if ([[weekdays objectAtIndex:theComponents.weekday] isEqualToString:numLabel.text]) {
            numLabel.textColor = RGB(0, 186, 255);
        } else {
            numLabel.textColor = RGB(51, 51, 51);
        }
        numLabel.backgroundColor = [UIColor whiteColor];
        numLabel.textAlignment = NSTextAlignmentCenter;
        numLabel.font = [UIFont systemFontOfSize:14];
        
        [self.titleView addSubview:numLabel];
    }
    
    self.classScheduleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, APP_WIDTH, APP_HEIGHT - APP_NAVH - 40)];
    self.classScheduleScrollView.backgroundColor = backColor;
    self.classScheduleScrollView.contentSize = CGSizeMake(APP_WIDTH, APP_HEIGHT * 1.9);
    self.classScheduleScrollView.bounces = YES;
    self.classScheduleScrollView.indicatorStyle = UIScrollViewIndicatorStyleDefault;
    self.classScheduleScrollView.maximumZoomScale = 2.5;//最多放大到两倍
    self.classScheduleScrollView.minimumZoomScale = 0.5;//最多缩小到0.5倍
    //设置是否允许缩放超出倍数限制，超出后弹回
    self.classScheduleScrollView.bouncesZoom = YES;
    //设置委托
    self.classScheduleScrollView.delegate = self;
    [self.view addSubview:self.classScheduleScrollView];
    
    if (self.timeArr.count > 0) {
        for (int i = 0; i < self.timeArr.count; i ++) {
            UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(2, i * 60 + 5 * i, 40, 60)];
            titleView.backgroundColor = backColor;
            [self.classScheduleScrollView addSubview:titleView];
            
            ClassScheduleModel *model = [self.timeArr objectAtIndex:i];
            
            UILabel *begintLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 40, 20)];
            begintLabel.text = model.start;
            begintLabel.font = [UIFont systemFontOfSize:10];
            begintLabel.textAlignment = NSTextAlignmentCenter;
            begintLabel.textColor = RGB(51, 51, 51);
            [titleView addSubview:begintLabel];
            
            UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, 40, 20)];
            numLabel.text = [NSString stringWithFormat:@"%d",i+1];
            numLabel.font = [UIFont systemFontOfSize:10];
            numLabel.textAlignment = NSTextAlignmentCenter;
            numLabel.textColor = RGB(110, 213, 240);
            [titleView addSubview:numLabel];
            
            UILabel *endLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 40, 20)];
            endLabel.text = model.end;
            endLabel.font = [UIFont systemFontOfSize:10];
            endLabel.textAlignment = NSTextAlignmentCenter;
            endLabel.textColor = RGB(51, 51, 51);
            [titleView addSubview:endLabel];
            
        }
    }
    
    if (self.classScheduleArr.count > 0) {
        for (int i = 0; i < 7; i ++) {
            for (int j = 0; j < self.classScheduleArr.count / 7; j ++) {
                UIView *classView = [[UIView alloc] initWithFrame:CGRectMake(60 +  (APP_WIDTH - 100) / 7 * i + (i + 1) * 5, j * 60 + 5 * j, (APP_WIDTH - 100) / 7, 60)];
                //(60 + i * (APP_WIDTH - 100) / 7  + (i + 1) * 5 , 5, (APP_WIDTH - 100) / 7, 30)];
                classView.layer.masksToBounds = YES;
                classView.layer.cornerRadius = 5;
                switch (i) {
                    case 0:
                        {
                            classView.backgroundColor = RGB(204, 130, 246);
                        }
                        break;
                    case 1:
                    {
                        classView.backgroundColor = RGB(54, 162, 251);
                    }
                        break;
                    case 2:
                    {
                        classView.backgroundColor = RGB(255, 156, 93);
                    }
                        break;
                    case 3:
                    {
                        classView.backgroundColor = RGB(96, 113, 248);
                    }
                        break;
                    case 4:
                    {
                        classView.backgroundColor = RGB(53, 203, 236);
                    }
                        break;
                    case 5:
                    {
                        classView.backgroundColor = RGB(255, 89, 140);
                    }
                        break;
                    case 6:
                    {
                        classView.backgroundColor = RGB(253, 109, 71);
                    }
                        break;
                        
                    default:
                        break;
                }
                [self.classScheduleScrollView addSubview:classView];
                
                UIButton *classButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 0, classView.frame.size.width - 10, classView.frame.size.height)];
                [classButton addTarget:self action:@selector(classButton:) forControlEvents:UIControlEventTouchDown];
                classButton.tag = i + j * 7;
                [classButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                classButton.titleLabel.textAlignment = NSTextAlignmentCenter;
                classButton.titleLabel.numberOfLines = 0;
                classButton.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
                NSDictionary *dic = [self.classScheduleArr objectAtIndex:classButton.tag];
                [classButton setTitle:[dic objectForKey:@"name"] forState:UIControlStateNormal];
               
                classButton.titleLabel.font = [UIFont systemFontOfSize:12];
                [classView addSubview:classButton];
                
            }
        }
    }
}

- (void)classButton:(UIButton *)sender {
    NSLog(@"%ld",(long)sender.tag);
    if ([self.typeStr isEqualToString:@"1"]) {
        if (self.classScheduleArr.count > 0) {
            NSDictionary *dic = [self.classScheduleArr objectAtIndex:sender.tag];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"科目名称" preferredStyle:UIAlertControllerStyleAlert];
            
            //增加取消按钮
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            
            //增加确定按钮
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UITextField *userNameTextField = alertController.textFields.firstObject;
                
                if (userNameTextField.text.length <= 4) {
                    [sender setTitle:userNameTextField.text forState:UIControlStateNormal];
                    if ([userNameTextField.text isEqualToString:@""]) {
                        userNameTextField.text = @"";
                    }
                    NSDictionary *dic1 = @{@"key":[UserManager key],@"id":[dic objectForKey:@"id"],@"course":userNameTextField.text,@"day":[dic objectForKey:@"day"]};
                    [self UpdateTimeURLData:dic1];
                } else {
                    [WProgressHUD showErrorAnimatedText:@"限制四个字"];
                }
                
            }]];
            [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.placeholder = @"请输入科目名称";
            }];
            [self presentViewController:alertController animated:true completion:nil];
        }
    }
}

//
- (void)UpdateTimeURLData:(NSDictionary *)dic {
    [[HttpRequestManager sharedSingleton] POST:UpdateTimeURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
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


- (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    NSLog(@"%@",[weekdays objectAtIndex:theComponents.weekday]);
    return [weekdays objectAtIndex:theComponents.weekday];
    
}


#pragma mark ======= 获取个人信息数据 =======
- (void)setUser {
    NSDictionary * dic = @{@"key":[UserManager key]};
    [[HttpRequestManager sharedSingleton] POST:getUserInfoURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            
            self.personInfo = [PersonInformationModel mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
            
        } else {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
            } else {
                
            }
            [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - UIScrollViewDelegate
//返回缩放时所使用的UIView对象
- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return scrollView;
}

//开始缩放时调用
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    
}

//结束缩放时调用，告知缩放比例
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    
}

//已经缩放时调用
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
}

//确定是否可以滚动到顶部
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
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
