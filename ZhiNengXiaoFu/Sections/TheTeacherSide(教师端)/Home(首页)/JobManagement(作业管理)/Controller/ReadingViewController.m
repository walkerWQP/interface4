//
//  ReadingViewController.m
//  ZhiNengXiaoFu
//
//  Created by 独秀科技 on 2018/12/25.
//  Copyright © 2018 henanduxiu. All rights reserved.
//

#import "ReadingViewController.h"
#import "ReadViewController.h"
#import "UnreadViewController.h"
#import "TotalNumberModel.h"

@interface ReadingViewController ()

@property (nonatomic, strong) JohnTopTitleView *titleView;
@property (nonatomic, strong) NSMutableArray   *readArr;
@property (nonatomic, strong) NSString         *readNumStr;
@property (nonatomic, strong) NSString         *unReadNumStr;

@end

@implementation ReadingViewController

- (NSMutableArray *)readArr {
    if (!_readArr) {
        _readArr = [NSMutableArray array];
    }
    return _readArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"阅读情况";
    NSDictionary *dic = @{@"key":[UserManager key],@"id":self.ID,@"class_id":self.class_id,@"is_read":@"1",@"type":self.type};
    [self getReadURLData:dic];
    
}

- (void)makeConsultingViewControllerUI {
    NSArray *titleArray = [NSArray arrayWithObjects:[NSString stringWithFormat:@"已阅读(%@)",self.readNumStr],[NSString stringWithFormat:@"未阅读(%@)",self.unReadNumStr],nil];
    self.titleView.title = titleArray;
    [self.titleView setupViewControllerWithFatherVC:self childVC:[self setChildVC]];
    [self.view addSubview:self.titleView];
}

- (NSArray <UIViewController *>*)setChildVC {
    //已回复
    ReadViewController *readVC = [[ReadViewController alloc]init];
    readVC.type = self.type;
    readVC.ID   = self.ID;
    readVC.class_id = self.class_id;
    //未回复
    UnreadViewController *unreadVC = [[UnreadViewController alloc]init];
    unreadVC.type = self.type;
    unreadVC.ID   = self.ID;
    unreadVC.class_id = self.class_id;
    NSArray *childVC = [NSArray arrayWithObjects:readVC,unreadVC, nil];
    return childVC;
}

- (JohnTopTitleView *)titleView {
    if (!_titleView) {
        _titleView = [[JohnTopTitleView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    }
    return _titleView;
}

- (void)getReadURLData:(NSDictionary *)dic {
    [[HttpRequestManager sharedSingleton] POST:GetReadURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            
            self.readNumStr = [[responseObject objectForKey:@"data"] objectForKey:@"read_num"];
            self.unReadNumStr = [[responseObject objectForKey:@"data"] objectForKey:@"no_read_num"];
//            [self makeConsultingViewControllerUI];
            
            NSArray *titleArray = [NSArray arrayWithObjects:[NSString stringWithFormat:@"已阅读(%@)",self.readNumStr],[NSString stringWithFormat:@"未阅读(%@)",self.unReadNumStr],nil];
            self.titleView.title = titleArray;
            [self.titleView setupViewControllerWithFatherVC:self childVC:[self setChildVC]];
            [self.view addSubview:self.titleView];
            
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
