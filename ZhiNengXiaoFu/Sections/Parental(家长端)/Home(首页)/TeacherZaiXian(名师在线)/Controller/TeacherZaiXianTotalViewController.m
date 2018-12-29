//
//  TeacherZaiXianTotalViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/8/15.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "TeacherZaiXianTotalViewController.h"
#import "TeacherZaiXianViewController.h"
#import "LTHeaderView.h"
#import "PrefixHeader.pch"

@interface TeacherZaiXianTotalViewController ()<LTAdvancedScrollViewDelegate>

@property(copy, nonatomic) NSArray <UIViewController *> *viewControllers;
@property(copy, nonatomic) NSArray <NSString *>         *titles;
@property(strong, nonatomic) LTLayout                   *layout;
@property(strong, nonatomic) LTAdvancedManager          *managerView;
@property(strong, nonatomic) LTHeaderView               *headerView;
@property (nonatomic, strong) NSMutableArray            *bannerArr;
@property (nonatomic, strong) NSMutableArray            *nameAry;
@property (nonatomic, strong) NSMutableArray            *IdNameAry;

@end

@implementation TeacherZaiXianTotalViewController

- (NSMutableArray *)nameAry {
    if (!_nameAry) {
        self.nameAry = [@[]mutableCopy];
    }
    return _nameAry;
}


- (NSMutableArray *)IdNameAry {
    if (!_IdNameAry) {
        self.IdNameAry = [@[]mutableCopy];
    }
    return _IdNameAry;
}

- (NSMutableArray *)bannerArr {
    if (!_bannerArr) {
        _bannerArr = [NSMutableArray array];
    }
    return _bannerArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"名师在线";
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回白"] style:UIBarButtonItemStyleDone target:self action:@selector(backButnClicked:)];
    self.navigationItem.leftBarButtonItem = back;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = RGB(138,201,237);
    
    //获取视频类型列表
    [self getLieBiao];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
}


- (void)getLieBiao {
    NSDictionary *dic = @{@"key":[UserManager key]};
    [[HttpRequestManager sharedSingleton] POST:indexOnlineVideoTypeList parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            NSMutableArray *ary = [responseObject objectForKey:@"data"];
            NSDictionary *dic1 = @{@"id":@0,@"t_name":@"全部"};
            [self.IdNameAry addObject:dic1];
            [self.nameAry addObject:@"全部"];
            for (NSDictionary *dic in ary) {
                [self.nameAry addObject:[dic objectForKey:@"t_name"]];
                [self.IdNameAry addObject:dic];
            }
            [self setupSubViews];
            [self getBannersURLData];
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

-(void)setupSubViews {
    [self.view addSubview:self.managerView];
    __block TeacherZaiXianTotalViewController *BlockSelf = self;
    [self.managerView setAdvancedDidSelectIndexHandle:^(NSInteger index) {
       [SingletonHelper manager].teacherZaiXianId = [[[BlockSelf.IdNameAry objectAtIndex:index] objectForKey:@"id"] integerValue];
    }];
}


#pragma mark - 获取轮播图
- (void)getBannersURLData {
    NSDictionary *dic = @{@"key":[UserManager key],@"t_id":@"8"};
    [[HttpRequestManager sharedSingleton] POST:bannersURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            self.bannerArr = [BannerModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            if (self.bannerArr.count == 0) {
                self.headerView.back.image = [UIImage imageNamed:@"banner"];
            } else {
                BannerModel * model = [self.bannerArr objectAtIndex:0];
                [self.headerView.back sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"banner"]];
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


-(LTAdvancedManager *)managerView {
    if (!_managerView) {
        CGFloat Y = 0;
        CGFloat H = kIPhoneX ? (self.view.bounds.size.height - Y - 34) : self.view.bounds.size.height - Y;        
        _managerView = [[LTAdvancedManager alloc] initWithFrame:CGRectMake(0, Y, self.view.bounds.size.width, H) viewControllers:self.viewControllers titles:self.titles currentViewController:self layout:self.layout titleView:nil headerViewHandle:^UIView * _Nonnull{
             return [self setupHeaderView];
        }];
        
        /* 设置代理 监听滚动 */
        _managerView.delegate = self;
        
        /* 设置悬停位置 */
        //        _managerView.hoverY = 64;
        
        /* 点击切换滚动过程动画 */
        //        _managerView.isClickScrollAnimation = YES;
        
        /* 代码设置滚动到第几个位置 */
        //        [_managerView scrollToIndexWithIndex:self.viewControllers.count - 1];
    }
    return _managerView;
}

-(void)glt_scrollViewOffsetY:(CGFloat)offsetY {
    NSLog(@"---> %lf", offsetY);
}

- (LTHeaderView *)setupHeaderView {
    self.headerView = [[LTHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 180.0)];
    return _headerView;
}

- (LTLayout *)layout {
    if (!_layout) {
        _layout = [[LTLayout alloc] init];
        _layout.bottomLineHeight = 3;
        _layout.bottomLineCornerRadius = 2.0;
        _layout.bottomLineColor = THEMECOLOR;
        _layout.titleSelectColor = THEMECOLOR;
        _layout.titleColor = RGB(170, 170, 170);
//        _layout.bottomLineHeight = 1;
        _layout.titleViewBgColor = [UIColor whiteColor];
        _layout.titleMargin = 40;
        _layout.lrMargin = 15;
        _layout.titleFont = [UIFont systemFontOfSize:14];
    }
    return _layout;
}


- (NSArray <NSString *> *)titles {
    if (!_titles) {
        _titles = self.nameAry;
    }
    return _titles;
}


-(NSArray <UIViewController *> *)viewControllers {
    if (!_viewControllers) {
        _viewControllers = [self setupViewControllers];
    }
    return _viewControllers;
}

- (void)viewWillDisappear:(BOOL)animated {
     [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
}

-(NSArray <UIViewController *> *)setupViewControllers {
    NSMutableArray <UIViewController *> *testVCS = [NSMutableArray arrayWithCapacity:0];
    [self.titles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger index, BOOL * _Nonnull stop) {
        TeacherZaiXianViewController *testVC = [[TeacherZaiXianViewController alloc] init];
        [testVCS addObject:testVC];
    }];
    return testVCS.copy;
}

-(void)backButnClicked:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [SingletonHelper manager].teacherZaiXianId  = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
