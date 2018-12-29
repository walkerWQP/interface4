//
//  TeacherOnlineViewController.m
//  ZhiNengXiaoFu
//
//  Created by 独秀科技 on 2018/11/28.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "TeacherOnlineViewController.h"
#import "TypeModel.h"
#import "GradeModel.h"
#import "TeacherOnlineCell.h"
#import "TeacherOnlineModel.h"
#import "TeacherZaiXianDetailsViewController.h"
#import "TeacherZaiXianModel.h"
#import "SearchViewController.h"

@interface TeacherOnlineViewController ()<DKFilterViewDelegate,UITableViewDelegate, UITableViewDataSource,SearchViewControllerDelegate>

@property (nonatomic, strong) UIView          *titleView;
@property (nonatomic, strong) UIButton        *allButton;
@property (nonatomic, strong) UIButton        *primaryBtn;
@property (nonatomic, strong) UIButton        *middleBtn;
@property (nonatomic, strong) UIButton        *highBtn;
@property (nonatomic, strong) UIView          *allView;
@property (nonatomic, strong) UIView          *primaryView;
@property (nonatomic, strong) UIView          *middleView;
@property (nonatomic, strong) UIView          *highView;
@property (nonatomic, strong) UIView          *headView;
@property (nonatomic, strong) GSFilterView    *filterView;
@property (nonatomic, strong) DKFilterModel   *clickModel;
@property (nonatomic, strong) UIButton        *sureBtn;
@property (nonatomic, strong) NSString        *typeStr;
@property (nonatomic, strong) NSMutableArray  *gradeArr;
@property (nonatomic, strong) NSMutableArray  *typeArr;
@property (nonatomic, strong) NSMutableArray  *gradeArr1;
@property (nonatomic, strong) NSMutableArray  *typeArr1;
@property (nonatomic, strong) UITableView     *teacherOnlineTableView;
@property (nonatomic, strong) NSMutableArray  *teacherOnlineArr;
@property (nonatomic, assign) NSInteger       page;
@property (nonatomic, strong) UIImageView     *zanwushuju;
@property (nonatomic, strong) NSString        *grade_id;
@property (nonatomic, strong) NSString        *t_id;
@property (nonatomic, strong) UIView          *backView;

@end

@implementation TeacherOnlineViewController

- (NSMutableArray *)teacherOnlineArr {
    if (!_teacherOnlineArr) {
        _teacherOnlineArr = [NSMutableArray array];
    }
   return _teacherOnlineArr;
}

- (NSMutableArray *)typeArr1 {
    if (!_typeArr1) {
        _typeArr1 = [NSMutableArray array];
    }
    return _typeArr1;
}

- (NSMutableArray *)gradeArr1 {
    if (!_gradeArr1) {
        _gradeArr1 = [NSMutableArray array];
    }
    return _gradeArr1;
}

- (NSMutableArray *)typeArr {
    if (!_typeArr) {
        _typeArr = [NSMutableArray array];
    }
    return _typeArr;
}

- (NSMutableArray *)gradeArr {
    if (!_gradeArr) {
        _gradeArr = [NSMutableArray array];
    }
    return _gradeArr;
}



-(void)viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.filterView.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"名师在线";
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 44, 44);
    [rightBtn setImage:[UIImage imageNamed:@"搜索"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.page = 1;
    [self makeTitleViewUI];
    self.grade_id = @"0";
    self.t_id     = @"0";
    if (@available(iOS 11.0, *)) {
        self.teacherOnlineTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.teacherOnlineTableView];
    self.teacherOnlineTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.teacherOnlineTableView registerClass:[TeacherOnlineCell class] forCellReuseIdentifier:@"TeacherOnlineCellId"];
    
    self.zanwushuju = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 105 / 2, 350, 105, 111)];
    self.zanwushuju.image = [UIImage imageNamed:@"暂无数据家长端"];
    self.zanwushuju.alpha = 0;
    [self.view addSubview:self.zanwushuju];
    self.glt_scrollView = self.teacherOnlineTableView;
    
    //下拉刷新
    self.teacherOnlineTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    //自动更改透明度
    self.teacherOnlineTableView.mj_header.automaticallyChangeAlpha = YES;
    //进入刷新状态
    [self.teacherOnlineTableView.mj_header beginRefreshing];
    //上拉刷新
    self.teacherOnlineTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
    
}

- (void)loadNewTopic {
    self.page = 1;
    [self.teacherOnlineArr removeAllObjects];
    [self setNetWork:self.page];
}

- (void)loadMoreTopic {
    self.page += 1;
    [self setNetWork:self.page];
}

- (void)searchAction:(UIButton *)sender {
    NSLog(@"点击搜索");
    SearchViewController *SearchVC = [SearchViewController new];
    SearchVC.delegate = self;
    [self.navigationController pushViewController:SearchVC animated:YES];
}

- (void)delegateViewControllerDidClickwithString:(NSString *)string {
    if (string != nil) {
        self.t_id = @"0";
        self.grade_id = @"0";
        self.page = 1;
        [self.teacherOnlineArr removeAllObjects];
        NSDictionary *dic = @{@"key":[UserManager key], @"page":[NSString stringWithFormat:@"%ld",self.page], @"t_id":self.t_id,@"grade_id":self.grade_id,@"title":string};
        [[HttpRequestManager sharedSingleton] POST:VideoListURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
            //结束头部刷新
            [self.teacherOnlineTableView.mj_header endRefreshing];
            //结束尾部刷新
            [self.teacherOnlineTableView.mj_footer endRefreshing];
            if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
                NSMutableArray *arr = [TeacherOnlineModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
                for (TeacherOnlineModel *model in arr) {
                    [self.teacherOnlineArr addObject:model];
                }
                if (self.teacherOnlineArr.count == 0) {
                    self.zanwushuju.alpha = 1;
                } else {
                    self.zanwushuju.alpha = 0;
                }
                [self.teacherOnlineTableView reloadData];
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
    
}

- (void)setNetWork:(NSInteger)page {
    [WProgressHUD showHUDShowText:@"数据请求中..."];
    NSDictionary *dic = @{@"key":[UserManager key], @"page":[NSString stringWithFormat:@"%ld",page], @"t_id":self.t_id,@"grade_id":self.grade_id};
    [[HttpRequestManager sharedSingleton] POST:VideoListURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        [WProgressHUD hideAllHUDAnimated:YES];
        //结束头部刷新
        [self.teacherOnlineTableView.mj_header endRefreshing];
        //结束尾部刷新
        [self.teacherOnlineTableView.mj_footer endRefreshing];
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            NSMutableArray *arr = [TeacherOnlineModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            for (TeacherOnlineModel *model in arr) {
                [self.teacherOnlineArr addObject:model];
            }
            if (self.teacherOnlineArr.count == 0) {
                self.zanwushuju.alpha = 1;
            } else {
                self.zanwushuju.alpha = 0;
            }
            [self.teacherOnlineTableView reloadData];
        } else {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
            } else {
                
            }
            [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
        [WProgressHUD hideAllHUDAnimated:YES];
    }];
}

//根据阶段获取年级、科目列表
- (void)GetTypeListURLData:(NSString *)stage {
    NSDictionary *dic = @{@"key":[UserManager key], @"stage":stage};
    [WProgressHUD showHUDShowText:@"数据加载中..."];
    [[HttpRequestManager sharedSingleton] POST:GetTypeListURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        [WProgressHUD hideAllHUDAnimated:YES];
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            [self.gradeArr1 removeAllObjects];
            [self.typeArr1 removeAllObjects];
            NSDictionary *dataDic = [responseObject objectForKey:@"data"];
            self.gradeArr = [GradeModel mj_objectArrayWithKeyValuesArray:[dataDic objectForKey:@"grade"]];
            self.typeArr  = [TypeModel mj_objectArrayWithKeyValuesArray:[dataDic objectForKey:@"type"]];
            
            for (int i = 0; i < self.gradeArr.count; i ++) {
                GradeModel *model = self.gradeArr[i];
                [self.gradeArr1 addObject:model.grade_name];
            }
            
            for (int i = 0; i < self.typeArr.count; i ++) {
                TypeModel *model = self.typeArr[i];
                [self.typeArr1 addObject:model.t_name];
            }
            
            [self makePopView];
            
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

- (void)makeTitleViewUI {
    self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 40)];
    self.titleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.titleView];
    NSInteger width = (kScreenWidth - 90 - 40 * 4) / 3;
    
    self.allButton = [[UIButton alloc] initWithFrame:CGRectMake(45 + 0 * (40 + width), 5, 40, 30)];
    [self.allButton setTitle:@"全部" forState:UIControlStateNormal];
    [self.allButton setTitleColor:RGB(0, 172, 241) forState:UIControlStateNormal];
    self.allButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.allButton addTarget:self action:@selector(allButtonSelector:) forControlEvents:UIControlEventTouchUpInside];
    self.allButton.tag = 0;
    [self.titleView addSubview:self.allButton];
    
    self.primaryBtn = [[UIButton alloc] initWithFrame:CGRectMake(45 + 1 * (40 + width), 5, 40, 30)];
    [self.primaryBtn setTitle:@"小学" forState:UIControlStateNormal];
    [self.primaryBtn setTitleColor:RGB(170, 170, 170) forState:UIControlStateNormal];
    self.primaryBtn.titleLabel.font = [UIFont systemFontOfSize:15];
   [self.primaryBtn addTarget:self action:@selector(primaryBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    self.primaryBtn.tag = 1;
    [self.titleView addSubview:self.primaryBtn];
    
    self.middleBtn = [[UIButton alloc] initWithFrame:CGRectMake(45 + 2 * (40 + width), 5, 40, 30)];
    [self.middleBtn setTitle:@"中学" forState:UIControlStateNormal];
    [self.middleBtn setTitleColor:RGB(170, 170, 170) forState:UIControlStateNormal];
    self.middleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.middleBtn addTarget:self action:@selector(middleBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    self.middleBtn.tag = 2;
    [self.titleView addSubview:self.middleBtn];
    
    self.highBtn = [[UIButton alloc] initWithFrame:CGRectMake(45 + 3 * (40 + width), 5, 40, 30)];
    [self.highBtn setTitle:@"高中" forState:UIControlStateNormal];
    [self.highBtn setTitleColor:RGB(170, 170, 170) forState:UIControlStateNormal];
    self.highBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.highBtn addTarget:self action:@selector(highBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    self.highBtn.tag = 3;
    [self.titleView addSubview:self.highBtn];
    
    self.allView = [[UIView alloc] initWithFrame:CGRectMake(50 + 0 * (40 + width), 40, 30, 2)];
    self.allView.backgroundColor = RGB(0, 172, 241);
    [self.view addSubview:self.allView];
    
    self.primaryView = [[UIView alloc] initWithFrame:CGRectMake(50 + 1 * (40 + width), 40, 30, 2)];
    self.primaryView.backgroundColor = RGB(0, 172, 241);
    [self.view addSubview:self.primaryView];
    
    self.middleView = [[UIView alloc] initWithFrame:CGRectMake(50 + 2 * (40 + width), 40, 30, 2)];
    self.middleView.backgroundColor = RGB(0, 172, 241);
    [self.view addSubview:self.middleView];
    
    self.highView = [[UIView alloc] initWithFrame:CGRectMake(50 + 3 * (40 + width), 40, 30, 2)];
    self.highView.backgroundColor = RGB(0, 172, 241);
    [self.view addSubview:self.highView];
    
    self.allView.hidden     = NO;
    self.primaryView.hidden = YES;
    self.middleView.hidden  = YES;
    self.highView.hidden    = YES;
    
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT)];
    self.backView.backgroundColor = [UIColor clearColor];
    //[UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:0.8];
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.backView];
    self.backView.hidden = YES;
    
    UITapGestureRecognizer *imgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTap:)];
    self.backView.userInteractionEnabled = YES;
    [self.backView addGestureRecognizer:imgTap];
    
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, APP_WIDTH, 300)];
    self.headView.backgroundColor = [UIColor whiteColor];
    [self.backView addSubview:self.headView];
    self.headView.hidden = YES;
    
}

- (void)makePopView {
    [self.filterView removeAllSubviews];
    self.filterView.hidden = YES;
    self.filterView = [[GSFilterView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, self.headView.frame.size.height - 40)];
    self.filterView.delegate = self;
    
    if (self.gradeArr1.count > 0 || self.typeArr1.count > 0) {
        DKFilterModel *radioModel = [[DKFilterModel alloc] initElement:self.gradeArr1 ofType:DK_SELECTION_SINGLE];
        radioModel.title = @"年级";
        radioModel.style = DKFilterViewDefault;
        
        DKFilterModel *checkModel = [[DKFilterModel alloc] initElement:self.typeArr1 ofType:DK_SELECTION_SINGLE];
        checkModel.title = @"学科";
        checkModel.style = DKFilterViewDefault;
        
        [self.filterView setFilterModels:@[radioModel,checkModel]];
        [self.headView addSubview:self.filterView];
    }
    
    self.sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(APP_WIDTH - 100, self.filterView.frame.size.height + 10, 70, 22)];
    self.sureBtn.backgroundColor = [UIColor whiteColor];
    [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.sureBtn addTarget:self action:@selector(sureBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    self.sureBtn.backgroundColor = RGB(0,172,241);
    self.sureBtn.layer.masksToBounds = YES;
    self.sureBtn.layer.cornerRadius  = 5;
    [self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.headView addSubview:self.sureBtn];
    
//    UIButton *packBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, self.filterView.frame.size.height + 10, 70, 22)];
//    packBtn.backgroundColor = [UIColor whiteColor];
//    [packBtn setTitle:@"取消" forState:UIControlStateNormal];
//    [packBtn addTarget:self action:@selector(packBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
//    packBtn.backgroundColor = RGB(0,172,241);
//    packBtn.layer.masksToBounds = YES;
//    packBtn.layer.cornerRadius  = 5;
//    [packBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [self.headView addSubview:packBtn];
    
}

- (void)sureBtnSelector:(UIButton *)sender {
    self.t_id = @"0";
    self.grade_id = @"0";
    for (DKFilterModel *model in self.filterView.filterModels) {
        if(model == self.clickModel) {
            continue;
        }
        
        if (self.gradeArr.count == 0 || self.typeArr.count == 0) {
            [WProgressHUD showErrorAnimatedText:@"暂无数据"];
            self.backView.hidden = YES;
            self.headView.hidden = YES;
            [self.filterView removeAllSubviews];
            self.filterView.hidden = YES;
            return;
        } else {
            NSArray *array = [model getFilterResult];
            for (NSString *str in array) {
                for (int i = 0; i < self.gradeArr1.count; i ++) {
                    GradeModel *gradeModel = self.gradeArr[i];
                    if ([str isEqualToString:gradeModel.grade_name]) {
                        NSLog(@"%@",gradeModel.grade_id);
                        self.grade_id = gradeModel.grade_id;
                    }
                }
                
                for (int i = 0; i < self.typeArr1.count; i ++) {
                    TypeModel *typeModel = self.typeArr[i];
                    if ([str isEqualToString:typeModel.t_name]) {
                        NSLog(@"%@",typeModel.t_id);
                        self.t_id = typeModel.t_id;
                    }
                }
            }
            if (![self.grade_id isEqualToString:@"0"] && ![self.t_id isEqualToString:@"0"]) {
                self.backView.hidden = YES;
                self.headView.hidden = YES;
                [self.filterView removeAllSubviews];
                self.filterView.hidden = YES;
                self.page = 1;
                [self.teacherOnlineArr removeAllObjects];
                [self setNetWork:self.page];
            } else {
                if ([self.t_id isEqualToString:@"0"] && [self.grade_id isEqualToString:@"0"]) {
                    [WProgressHUD showErrorAnimatedText:@"请选择年级和学科"];
                }
            }
        }
    }
}


- (void)allButtonSelector:(UIButton *)sender {
    NSLog(@"点击全部");
    [sender setTitleColor:RGB(0, 172, 241) forState:UIControlStateNormal];
    [self.primaryBtn setTitleColor:RGB(170, 170, 170) forState:UIControlStateNormal];
    [self.middleBtn setTitleColor:RGB(170, 170, 170) forState:UIControlStateNormal];
    [self.highBtn setTitleColor:RGB(170, 170, 170) forState:UIControlStateNormal];
    self.allView.hidden     = NO;
    self.primaryView.hidden = YES;
    self.middleView.hidden  = YES;
    self.highView.hidden    = YES;
    self.headView.hidden    = YES;
    self.backView.hidden    = YES;
    self.t_id = @"0";
    self.grade_id = @"0";
    self.page = 1;
    [self.teacherOnlineArr removeAllObjects];
    [self setNetWork:self.page];
    
}

- (void)primaryBtnSelector:(UIButton *)sender {
    NSLog(@"点击小学");
//    NSIndexPath *topRow = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.teacherOnlineTableView scrollToRowAtIndexPath:topRow atScrollPosition:UITableViewScrollPositionTop animated:YES];
    [sender setTitleColor:RGB(0, 172, 241) forState:UIControlStateNormal];
    [self.allButton setTitleColor:RGB(170, 170, 170) forState:UIControlStateNormal];
    [self.middleBtn setTitleColor:RGB(170, 170, 170) forState:UIControlStateNormal];
    [self.highBtn setTitleColor:RGB(170, 170, 170) forState:UIControlStateNormal];
    self.allView.hidden     = YES;
    self.primaryView.hidden = NO;
    self.middleView.hidden  = YES;
    self.highView.hidden    = YES;
    self.headView.hidden    = NO;
    self.backView.hidden    = NO;
    self.typeStr = @"1";
    [self GetTypeListURLData:self.typeStr];
}

- (void)middleBtnSelector:(UIButton *)sender {
    NSLog(@"点击中学");
//    NSIndexPath *topRow = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.teacherOnlineTableView scrollToRowAtIndexPath:topRow atScrollPosition:UITableViewScrollPositionTop animated:YES];
    [sender setTitleColor:RGB(0, 172, 241) forState:UIControlStateNormal];
    [self.allButton setTitleColor:RGB(170, 170, 170) forState:UIControlStateNormal];
    [self.primaryBtn setTitleColor:RGB(170, 170, 170) forState:UIControlStateNormal];
    [self.highBtn setTitleColor:RGB(170, 170, 170) forState:UIControlStateNormal];
    self.allView.hidden     = YES;
    self.primaryView.hidden = YES;
    self.middleView.hidden  = NO;
    self.highView.hidden    = YES;
    self.headView.hidden    = NO;
    self.backView.hidden    = NO;
    self.typeStr = @"2";
    [self GetTypeListURLData:self.typeStr];
    
}

- (void)highBtnSelector:(UIButton *)sender {
    NSLog(@"点击高中");
//    NSIndexPath *topRow = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.teacherOnlineTableView scrollToRowAtIndexPath:topRow atScrollPosition:UITableViewScrollPositionTop animated:YES];
    [sender setTitleColor:RGB(0, 172, 241) forState:UIControlStateNormal];
    [self.allButton setTitleColor:RGB(170, 170, 170) forState:UIControlStateNormal];
    [self.primaryBtn setTitleColor:RGB(170, 170, 170) forState:UIControlStateNormal];
    [self.middleBtn setTitleColor:RGB(170, 170, 170) forState:UIControlStateNormal];
    self.allView.hidden     = YES;
    self.primaryView.hidden = YES;
    self.middleView.hidden  = YES;
    self.highView.hidden    = NO;
    self.headView.hidden    = NO;
    self.backView.hidden    = NO;
    self.typeStr = @"3";
    [self GetTypeListURLData:self.typeStr];
    
}



- (UITableView *)teacherOnlineTableView {
    if (!_teacherOnlineTableView) {
        self.teacherOnlineTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 42, APP_WIDTH, APP_HEIGHT - APP_NAVH - 40)];
        self.teacherOnlineTableView.backgroundColor = backColor;
        self.teacherOnlineTableView.delegate = self;
        self.teacherOnlineTableView.dataSource = self;
    }
    return _teacherOnlineTableView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

//有时候tableview的底部视图也会出现此现象对应的修改就好了
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.teacherOnlineArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TeacherOnlineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TeacherOnlineCellId" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.teacherOnlineArr.count != 0) {
        TeacherOnlineModel *model = [self.teacherOnlineArr objectAtIndex:indexPath.row];
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"tu"]];
        cell.titleLabel.text = model.title;
        cell.subjectsLabel.text = [NSString stringWithFormat:@"年级:%@  科目%@",model.grade_name,model.t_name];
        cell.nameLabel.text = model.name;
        if (model.view > 9999) {
            CGFloat num = model.view / 10000;
            cell.numLabel.text = [NSString stringWithFormat:@"%.1f万次播放", num];
        } else {
            cell.numLabel.text = [NSString stringWithFormat:@"%ld次播放", model.view];
        }
        
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.teacherOnlineArr.count != 0) {
        TeacherZaiXianDetailsViewController * teacherZaiXianDetailsVC = [[TeacherZaiXianDetailsViewController alloc] init];
        TeacherZaiXianModel *model = [self.teacherOnlineArr objectAtIndex:indexPath.row];
        teacherZaiXianDetailsVC.teacherZaiXianDetailsId = model.ID;
        [self.navigationController pushViewController:teacherZaiXianDetailsVC animated:YES];
    }
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    self.headView.hidden = YES;
    self.backView.hidden = YES;
    [self.filterView.tableView reloadData];
}

- (void)imgTap:(UITapGestureRecognizer *)sender {
    self.headView.hidden = YES;
    self.backView.hidden = YES;
    [self.filterView.tableView reloadData];
}

- (void)packBtnSelector:(UIButton *)sender {
    self.headView.hidden = YES;
    self.backView.hidden = YES;
    [self.filterView removeAllSubviews];
    self.filterView.hidden = YES;
}


@end
