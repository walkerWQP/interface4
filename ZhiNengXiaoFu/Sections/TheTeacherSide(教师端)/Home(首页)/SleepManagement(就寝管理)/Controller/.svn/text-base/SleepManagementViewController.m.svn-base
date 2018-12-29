//
//  SleepManagementViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/8/30.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "SleepManagementViewController.h"
#import "PublishJobModel.h"
#import "YiZhuQinViewController.h"
#import "WeiZhuQinViewController.h"
#import "CircleView.h"
#import "StudentJiuQinModel.h"
@interface SleepManagementViewController ()<WPopupMenuDelegate>

@property (nonatomic, strong) UIButton                *rightBtn;
@property (nonatomic, strong) NSMutableArray          *publishJobArr;
@property (nonatomic, strong) JohnTopTitleView        *titleView;
//班级
@property (nonatomic, strong) UILabel                 *classNameLabel;
//下拉箭头
@property (nonatomic, strong) UIImageView             *jiantouImg;
@property (nonatomic, strong) UILabel                 *timeLabel;
//圆圈
@property (nonatomic, strong) CircleView              *circleV;
@property (nonatomic, strong) UILabel                 *zhuxiaoCount;
@property (nonatomic, strong) UILabel                 *zhuxiaoCountN;
@property (nonatomic, strong) UILabel                 *yidaoLabel;
@property (nonatomic, strong) UILabel                 *weidaoLabel;
@property (nonatomic, strong) UIView                  *yidaoView;
@property (nonatomic, strong) UIView                  *weidaoView;
@property (nonatomic, strong) NSMutableArray          *timeAry;
//区分班级时间状态
@property (nonatomic, assign) int                     qufenClassTime;
@property (nonatomic, copy) NSString                  *classId;
@property (nonatomic, copy) NSString                  *timeN;
@property (nonatomic, strong) NSDictionary            *FourDic;
@property (nonatomic, strong) YiZhuQinViewController  *haveToReplyVC;
@property (nonatomic, strong) WeiZhuQinViewController *didNotReturnVC;
@end


@implementation SleepManagementViewController

- (NSMutableArray *)publishJobArr {
    if (!_publishJobArr) {
        self.publishJobArr = [@[]mutableCopy];
    }
    return _publishJobArr;
}

- (NSMutableArray *)timeAry {
    if (!_timeAry) {
        self.timeAry = [@[]mutableCopy];
    }
    return _timeAry;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"住校生入寝";
    self.rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 90, 30)];
    [self.rightBtn setTitle:@"切换班级" forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = titFont;
    [self.rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
    [self makeConsultingViewControllerUI];
}


- (void)makeConsultingViewControllerUI {
    
    self.classNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 110, 20)];
    self.classNameLabel.textColor = titlColor;
    self.classNameLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:17];
    [self.view addSubview:self.classNameLabel];
    
    self.jiantouImg = [[UIImageView alloc] initWithFrame:CGRectMake(APP_WIDTH - 8 - 15, 26.5, 8, 7)];
    self.jiantouImg.image = [UIImage imageNamed:@"下拉"];
    [self.view addSubview:self.jiantouImg];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(APP_WIDTH - 23 - 10 - 90, 20, 90, 20)];
    self.timeLabel.textColor = titlColor;
    self.timeLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.timeLabel];
    
    UITapGestureRecognizer * timeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(timeTap:)];
    self.timeLabel.userInteractionEnabled = YES;
    [self.timeLabel addGestureRecognizer:timeTap];
    
    if (_circleV) {
        [_circleV removeFromSuperview];
    }
    
    _circleV = [[CircleView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 170) / 2, self.classNameLabel.frame.origin.y + self.classNameLabel.frame.size.height + 20, 170, 170)];
    //进度条宽度
    _circleV.strokelineWidth = 30;
    [self.view addSubview:_circleV];
    
    self.zhuxiaoCount = [[UILabel alloc] initWithFrame:CGRectMake(APP_WIDTH / 2 - 25, self.classNameLabel.frame.origin.y + self.classNameLabel.frame.size.height + 20 + 65, 55, 24)];
    self.zhuxiaoCount.textColor = [UIColor colorWithRed:255 / 255.0 green:105 / 255.0 blue:141 / 255.0 alpha:1];
    self.zhuxiaoCount.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:24];
    self.zhuxiaoCount.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.zhuxiaoCount];
    
    self.zhuxiaoCountN = [[UILabel alloc] initWithFrame:CGRectMake(APP_WIDTH / 2 - 20, self.self.zhuxiaoCount.frame.origin.y + self.self.zhuxiaoCount.frame.size.height + 9, 40, 13)];
    self.zhuxiaoCountN.text = @"住校生";
    self.zhuxiaoCountN.textColor = titlColor;
    self.zhuxiaoCountN.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:self.zhuxiaoCountN];
    
    self.weidaoView = [[UIView alloc] initWithFrame:CGRectMake(APP_WIDTH / 2 + 39,_circleV.frame.origin.y + _circleV.frame.size.height + 15, 12, 12)];
    self.weidaoView.backgroundColor = [UIColor colorWithRed:149/255.0 green:139/255.0  blue:254/255.0  alpha:1];
    [self.view addSubview:self.weidaoView];
    
    self.weidaoLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.weidaoView.frame.size.width + self.weidaoView.frame.origin.x + 10, self.weidaoView.frame.origin.y, 60, 12)];
    self.weidaoLabel.textColor = titlColor;
    self.weidaoLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:12];
    [self.view addSubview:self.weidaoLabel];
    
    self.yidaoLabel = [[UILabel alloc] initWithFrame:CGRectMake(APP_WIDTH / 2 - 35 - 55, self.weidaoView.frame.origin.y, 55, 12)];
    self.yidaoLabel.textColor = titlColor;
    self.yidaoLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:12];
    [self.view addSubview:self.yidaoLabel];
    
    self.yidaoView = [[UIView alloc] initWithFrame:CGRectMake(self.yidaoLabel.frame.origin.x - 10 - 12 ,self.weidaoView.frame.origin.y, 12, 12)];
    self.yidaoView.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:105 / 255.0 blue:141 / 255.0 alpha:1];
    [self.view addSubview:self.yidaoView];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 277, APP_WIDTH, 10)];
    lineView.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [self.view addSubview:lineView];
    
    [self getClassURLData];
    [self getClassURLTime];
    
}

- (NSArray <UIViewController *>*)setChildVC {
    //已回复
   self.haveToReplyVC  = [[YiZhuQinViewController alloc]init];
    //未回复
    self.didNotReturnVC = [[WeiZhuQinViewController alloc]init];
    NSArray *childVC = [NSArray arrayWithObjects:self.haveToReplyVC,self.didNotReturnVC, nil];
    return childVC;
}

- (JohnTopTitleView *)titleView {
    if (!_titleView) {
        [SingletonHelper manager].biaojiJiuQinColor = 1;
        _titleView = [[JohnTopTitleView alloc]initWithFrame:CGRectMake(0, 287, self.view.frame.size.width, self.view.frame.size.height)];
        _titleView.backgroundColor = backColor;
        _titleView.selcetColor = [UIColor redColor];
        _titleView.unSelcetColor = [UIColor blueColor];
    }
    return _titleView;
}

- (void)viewWillDisappear:(BOOL)animated {
    [SingletonHelper manager].biaojiJiuQinColor = 0;
}



- (void)rightBtn:(UIButton *)sender {
    
    NSLog(@"点击发布");
    NSMutableArray * ary = [@[]mutableCopy];
    for (PublishJobModel * model in self.publishJobArr) {
        [ary addObject:[NSString stringWithFormat:@"%@", model.name]];
    }
    
    if (ary.count == 0) {
        [WProgressHUD showErrorAnimatedText:@"数据不正确,请重试"];
    } else {
        self.qufenClassTime = 1;
        [WPopupMenu showRelyOnView:self.rightBtn titles:ary icons:nil menuWidth:140 delegate:self];
    }
}

- (void)timeTap:(UITapGestureRecognizer *)sender {
    if (self.timeAry.count == 0) {
        [WProgressHUD showErrorAnimatedText:@"暂无数据"];
    } else {
        self.qufenClassTime = 2;
        [WPopupMenu showRelyOnView:self.timeLabel titles:self.timeAry icons:nil menuWidth:140 delegate:self];
    }
}

- (void)getClassURLTime {
    NSDictionary *dic = @{@"key":[UserManager key]};
    [[HttpRequestManager sharedSingleton] POST:indexDormGetFourDayList parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            
            self.timeAry = [[responseObject objectForKey:@"data"] objectForKey:@"day_list"];
            
            if (self.timeAry.count != 0) {
                self.timeLabel.text = [self.timeAry objectAtIndex:0];
            }
            
            if (self.timeAry.count == 0) {
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

- (void)getClassURLData {
    
    NSDictionary *dic = @{@"key":[UserManager key]};
    [[HttpRequestManager sharedSingleton] POST:indexDormGetAdviserClass parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            
            self.publishJobArr = [PublishJobModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            
            if (self.publishJobArr.count != 0) {
               PublishJobModel * publishJobModel = [self.publishJobArr objectAtIndex:0];
                self.classNameLabel.text = publishJobModel.name;
                self.classId = publishJobModel.ID;
                [self postGetTeacherFour];
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

- (void)postGetTeacherFour {
    NSDictionary *dic = [NSDictionary dictionary];
    if (self.timeN == nil) {
        dic  = @{@"key":[UserManager key], @"class_id":self.classId};

    } else {
        dic  = @{@"key":[UserManager key], @"class_id":self.classId, @"date":self.timeN};
    }
    
    [[HttpRequestManager sharedSingleton] POST:indexDormGetClassDormRecord parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            self.FourDic = [NSDictionary dictionary];
            self.FourDic = [responseObject objectForKey:@"data"];
            
            self.weidaoLabel.text = [NSString stringWithFormat:@"未到%@人", [[self.FourDic objectForKey:@"record"] objectForKey:@"no_sign_num"]];
            self.yidaoLabel.text = [NSString stringWithFormat:@"已到%@人", [[self.FourDic objectForKey:@"record"] objectForKey:@"sign_num"]];
            self.zhuxiaoCount.text =[NSString stringWithFormat:@"%@人", [self.FourDic objectForKey:@"num"]];
            
            [SingletonHelper manager].yidaoAry = [StudentJiuQinModel mj_objectArrayWithKeyValuesArray:[[[responseObject objectForKey:@"data"] objectForKey:@"record"] objectForKey:@"sign_student"]];
            
            [SingletonHelper manager].weidaoAry = [StudentJiuQinModel mj_objectArrayWithKeyValuesArray:[[[responseObject objectForKey:@"data"] objectForKey:@"record"] objectForKey:@"no_sign_student"]];

            [self.titleView removeFromSuperview];
            [self.titleView.titleSegment removeAllSegments];

            self.titleView = nil;
            [self.haveToReplyVC.view removeFromSuperview];
            [self.didNotReturnVC.view removeFromSuperview];

            NSArray *titleArray = [NSArray arrayWithObjects:[NSString stringWithFormat:@"已住寝%@", [[self.FourDic objectForKey:@"record"] objectForKey:@"sign_num"]],[NSString stringWithFormat:@"未住寝%@", [[self.FourDic objectForKey:@"record"] objectForKey:@"no_sign_num"]],nil];
            self.titleView.title = titleArray;

            [self.titleView setupViewControllerWithFatherVC:self childVC:[self setChildVC]];
            [self.view addSubview:self.titleView];
            
            CGFloat num = [[self.FourDic  objectForKey:@"num"] floatValue];
            CGFloat yidao = [[[self.FourDic objectForKey:@"record"] objectForKey:@"sign_num"] floatValue];
            NSInteger bilie =  yidao * 100 / num;
            //设置进度,是否有动画效果
            [_circleV circleWithProgress:bilie andIsAnimate:YES];
            
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

#pragma mark - YBPopupMenuDelegate
- (void)WPopupMenuDidSelectedAtIndex:(NSInteger)index WPopupMenu:(WPopupMenu *)WPopupMenu {
    
    if (self.qufenClassTime == 1) {
        PublishJobModel *model = [self.publishJobArr objectAtIndex:index];
        NSLog(@"%@",model.ID);
        if (model.ID == nil) {
            [WProgressHUD showSuccessfulAnimatedText:@"数据不正确,请重试"];
        } else {
            self.classId = model.ID;
             [self postGetTeacherFour];
        }
    } else {
        if (self.timeAry.count != 0) {
            
            NSString * timeStr = [self.timeAry objectAtIndex:index];
            NSLog(@"%@",timeStr);
            self.timeLabel.text  = timeStr;
            self.timeN = timeStr;
            [self postGetTeacherFour];
        } else {
            [WProgressHUD showSuccessfulAnimatedText:@"暂无数据"];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
