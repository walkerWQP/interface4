//
//  SignClassViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/31.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "SignClassViewController.h"
#import "AskLeaveViewController.h"
#import "NotToViewController.h"
#import "HasBeenViewController.h"
#import "TotalNumberViewController.h"
#import "PublishJobModel.h"

@interface SignClassViewController ()<WPopupMenuDelegate>

@property (nonatomic,strong) JohnTopTitleView *titleView;
@property (nonatomic, strong) NSString        *allStr;
@property (nonatomic, strong) NSString        *signStr;
@property (nonatomic, strong) NSString        *no_signStr;
@property (nonatomic, strong) NSString        *leaveStr;
@property (nonatomic, strong) NSMutableArray  *publishJobArr;
@property (nonatomic, strong) NSMutableArray  *classNameArr;
@property (nonatomic, strong) NSMutableArray  *titleArray;
@property (nonatomic, strong) UIButton        *rightBtn;

@end

@implementation SignClassViewController

- (NSMutableArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}

- (NSMutableArray *)classNameArr {
    if (!_classNameArr) {
        _classNameArr = [NSMutableArray array];
    }
    return _classNameArr;
}

- (NSMutableArray *)publishJobArr {
    if (!_publishJobArr) {
        _publishJobArr = [NSMutableArray array];
    }
    return _publishJobArr;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"到校情况";
    self.view.backgroundColor = backColor;
    self.titleView.backgroundColor = backColor;
    self.titleView = [[JohnTopTitleView alloc]initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT)];
    [self.view addSubview:self.titleView];
    self.rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [self.rightBtn setTitle:@"切换班级" forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = titFont;
    [self.rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
    [self getClassURLData];
}


- (void)rightBtn:(UIButton *)sender {
    NSLog(@"点击选择班级");
    [self getClassURLDataForClassID];
}

- (void)getClassConditionURLData:(NSString *)type classID:(NSString *)classID {  //1全部学生
    NSDictionary *dic = @{@"key":[UserManager key],@"class_id":classID,@"type":type};
    [[HttpRequestManager sharedSingleton] POST:classConditionURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            self.allStr = @"";
            self.signStr = @"";
            self.no_signStr = @"";
            self.leaveStr = @"";
            self.allStr = [NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"data"] objectForKey:@"all"]];
            self.signStr = [NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"data"] objectForKey:@"sign"]];
            self.no_signStr = [NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"data"] objectForKey:@"no_sign"]];
            self.leaveStr = [NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"data"] objectForKey:@"leave"]];
            self.titleView.hidden = YES;
            [self.titleArray removeAllObjects];
            [self makeSignClassViewControllerUI];
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

- (void)makeSignClassViewControllerUI {
    
    self.titleView.backgroundColor = backColor;
    self.titleView = [[JohnTopTitleView alloc]initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT)];
    [self.view addSubview:self.titleView];
    
    NSString  *str1 = [NSString stringWithFormat:@"%@%@",@"总数",self.allStr];
    NSString  *str2 = [NSString stringWithFormat:@"%@%@",@"已到",self.signStr];
    NSString  *str3 = [NSString stringWithFormat:@"%@%@",@"未到",self.no_signStr];
    NSString  *str4 = [NSString stringWithFormat:@"%@%@",@"请假",self.leaveStr];
    self.titleArray = [NSMutableArray arrayWithObjects:str1,str2,str3,str4,nil];
    self.titleView.title = self.titleArray;
    if (self.ID == nil) {
        [WProgressHUD showErrorAnimatedText:@"数据不正确,请重试"];
    } else {
        [self.titleView setupViewControllerWithFatherVC:self childVC:[self setChildVC]];
        [self.view addSubview:self.titleView];
    }
   
}

- (NSArray <UIViewController *>*)setChildVC{
    //总数
    TotalNumberViewController *totalNumberVC = [[TotalNumberViewController alloc]init];
    totalNumberVC.ID = self.ID;
    //已到
    HasBeenViewController *hasBeenVC = [[HasBeenViewController alloc]init];
    hasBeenVC.ID = self.ID;
    //未到
    NotToViewController *notToVC = [[NotToViewController alloc]init];
    notToVC.ID = self.ID;
    //请假
    AskLeaveViewController *askLeaveVC = [[AskLeaveViewController alloc]init];
    askLeaveVC.ID = self.ID;
    NSArray *childVC = [NSArray arrayWithObjects:totalNumberVC,hasBeenVC,notToVC,askLeaveVC, nil];
    return childVC;
}

- (JohnTopTitleView *)titleView{
    if (!_titleView) {
        _titleView.backgroundColor = backColor;
        _titleView = [[JohnTopTitleView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    }
    return _titleView;
}

- (void)getClassURLData {
    NSDictionary *dic = @{@"key":[UserManager key]};
    [[HttpRequestManager sharedSingleton] POST:getClassURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            
            self.publishJobArr = [PublishJobModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            NSMutableArray *ary = [@[]mutableCopy];
            for (PublishJobModel *model in self.publishJobArr) {
                [ary addObject:[NSString stringWithFormat:@"%@", model.ID]];
            }
            
            if (self.publishJobArr.count == 0) {
                [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
            } else {
                self.ID = ary[0];
                [self getClassConditionURLData:@"1" classID:self.ID];
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

- (void)getClassURLDataForClassID {
    NSDictionary *dic = @{@"key":[UserManager key]};
    [[HttpRequestManager sharedSingleton] POST:getClassURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            self.classNameArr = [PublishJobModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            NSMutableArray *ary = [@[]mutableCopy];
            for (PublishJobModel *model in self.classNameArr) {
                [ary addObject:[NSString stringWithFormat:@"%@", model.name]];
            }
            if (ary.count == 0) {
                [WProgressHUD showErrorAnimatedText:@"数据不正确,请重试"];
            } else {
                [WPopupMenu showRelyOnView:self.rightBtn titles:ary icons:nil menuWidth:140 delegate:self];
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


#pragma mark - YBPopupMenuDelegate
- (void)WPopupMenuDidSelectedAtIndex:(NSInteger)index WPopupMenu:(WPopupMenu *)WPopupMenu {
        PublishJobModel *model = [self.classNameArr objectAtIndex:index];
        if (model.ID == nil) {
            [WProgressHUD showSuccessfulAnimatedText:@"数据不正确,请重试"];
        } else {
            self.ID = model.ID;
            [self getClassConditionURLData:@"1" classID:self.ID];
        }
}



@end
