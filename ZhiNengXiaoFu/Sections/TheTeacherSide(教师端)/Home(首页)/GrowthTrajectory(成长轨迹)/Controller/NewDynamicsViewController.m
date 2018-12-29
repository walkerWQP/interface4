//
//  NewDynamicsViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/9/5.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "NewDynamicsViewController.h"
#import "NewDynamicsViewController+Delegate.h"
#import "NewDynamicsLayout.h"
#import "DynamicsModel.h"
#import "SDTimeLineRefreshHeader.h"//下拉刷新控件
#import "UploadPhotosViewController.h"
#import "PublishJobModel.h"

@interface NewDynamicsViewController ()<WPopupMenuDelegate>


@property (nonatomic, strong) SDTimeLineRefreshHeader *refreshHeader;
@property (nonatomic, strong) UISegmentedControl      *segment;
@property (nonatomic, strong) UIButton                *rightBtn;
@property (nonatomic, strong) NSMutableArray          *classNameArr;
@property (nonatomic, strong) NSMutableArray          *publishJobArr;
@property (nonatomic, assign) NSInteger               pageID;
@property (nonatomic, strong) UIButton                *classBtn;
@property (nonatomic, strong) NSMutableArray          *praiseArr;
@property (nonatomic, strong) NSString                *userNameStr;
@property (nonatomic, strong) NSMutableArray          *fakeDatasource;
@property (nonatomic, strong) UIImageView             *headImgView;
@property (nonatomic, strong) NSMutableArray          *bannerArr;
@property (nonatomic, strong) UIImageView             *zanwushuju;

@end

@implementation NewDynamicsViewController

- (NSMutableArray *)bannerArr {
    if (!_bannerArr) {
        _bannerArr = [NSMutableArray array];
    }
    return _bannerArr;
}

- (NSMutableArray *)fakeDatasource {
    if (!_fakeDatasource) {
        _fakeDatasource = [NSMutableArray array];
    }
    return _fakeDatasource;
}

- (NSMutableArray *)praiseArr {
    if (!_praiseArr) {
        _praiseArr = [NSMutableArray array];
    }
    return _praiseArr;
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

- (NSMutableArray *)layoutsArr {
    if (!_layoutsArr) {
        _layoutsArr = [NSMutableArray array];
    }
    return _layoutsArr;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed  = YES;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    self.view.backgroundColor = backColor;
    [self setUser];
    self.pageID = 1;
    //下拉刷新
    self.dynamicsTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    //自动更改透明度
    self.dynamicsTable.mj_header.automaticallyChangeAlpha = YES;
    //进入刷新状态
    [self.dynamicsTable.mj_header beginRefreshing];
    //上拉刷新
    self.dynamicsTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
}

- (void)loadNewTopic {
    self.pageID = 1;
    [self.fakeDatasource removeAllObjects];
    [self.layoutsArr removeAllObjects];
    if ([self.typeStr isEqualToString:@"1"]) {
        NSDictionary  *dic = @{@"key":[UserManager key], @"class_id":@"", @"page":[NSString stringWithFormat:@"%ld",self.pageID]};
        [self getDataFromGetAlbumURL:dic];
    } else {
        NSDictionary  *dic = @{@"key":[UserManager key], @"class_id":self.classID, @"page":[NSString stringWithFormat:@"%ld",self.pageID]};
        [self getDataFromGetAlbumURL:dic];
    }
}

- (void)loadMoreTopic {
    self.pageID += 1;
    if ([self.typeStr isEqualToString:@"1"]) {
        NSDictionary  *dic = @{@"key":[UserManager key], @"class_id":@"", @"page":[NSString stringWithFormat:@"%ld",self.pageID]};
        [self getDataFromGetAlbumURL1:dic];
    } else {
        NSDictionary  *dic = @{@"key":[UserManager key], @"class_id":self.classID, @"page":[NSString stringWithFormat:@"%ld",self.pageID]};
        [self getDataFromGetAlbumURL1:dic];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 取消IQKeyboardManager Toolbar
    [[IQKeyboardManager sharedManager] disableToolbarInViewControllerClass:[NewDynamicsViewController class]];
    
    if ([self.typeStr isEqualToString:@"1"]) {
        self.title = @"班级圈";
    } else {
        self.classBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        self.classBtn.frame=CGRectMake(20, 20, 130, 30);
        [self.classBtn setTitle: self.className forState:UIControlStateNormal];
        [self.classBtn addTarget:self action:@selector(classBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.classBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.navigationItem.titleView = self.classBtn;
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(105, 2, 30, 30)];
        img.image = [UIImage imageNamed:@"向下"];
        [self.classBtn addSubview:img];
    }
    
    self.rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [self.rightBtn setImage:[UIImage imageNamed:@"相机"] forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = titFont;
    [self.rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
    [self setup];
    [self.view addSubview:self.commentInputTF];
    self.zanwushuju = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 105 / 2, 200, 105, 111)];
    self.zanwushuju.image = [UIImage imageNamed:@"暂无数据家长端"];
    self.zanwushuju.alpha = 0;
    [self.dynamicsTable addSubview:self.zanwushuju];
#pragma mark ======= 键盘上边输入框 =======
    //外观代理
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    //修改标题颜色
    NSDictionary * dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    [navigationBar setTitleTextAttributes:dict];

    navigationBar.barTintColor = [UIColor colorWithRed:64.0/255.0 green:64.0/255.0 blue:64.0/255.0 alpha:1.0];
    navigationBar.tintColor = [UIColor whiteColor];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}


- (void)getBannersURLData {
    NSDictionary *dic = @{@"key":[UserManager key],@"t_id":@"3"};
    [[HttpRequestManager sharedSingleton] POST:bannersURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            self.bannerArr = [BannerModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            if (self.bannerArr.count == 0) {
                self.headImgView.image = [UIImage imageNamed:@"教师端活动管理banner"];
            } else {
                BannerModel * model = [self.bannerArr objectAtIndex:0];
                [self.headImgView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"教师端活动管理banner"]];
                [self.dynamicsTable reloadData];
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


#pragma mark ======= 获取列表数据 =======
- (void)getDataFromGetAlbumURL:(NSDictionary *)dic {
    [WProgressHUD showHUDShowText:@"正在加载中..."];
    [[HttpRequestManager sharedSingleton] POST:GetAlbumURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        [WProgressHUD hideAllHUDAnimated:YES];
        
        //结束头部刷新
        [self.dynamicsTable.mj_header endRefreshing];
        //结束尾部刷新
        [self.dynamicsTable.mj_footer endRefreshing];
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            
            NSMutableArray *arr = [responseObject objectForKey:@"data"];
            if (arr.count == 0) {
                NSLog(@"刷新无数据");
                if (self.fakeDatasource.count == 0) {
                    self.zanwushuju.alpha = 1;
                } else {
                    return;
                }
                
            } else {
                
                NSMutableArray *dataArr = [NSMutableArray array];
                for (NSDictionary *dic in [responseObject objectForKey:@"data"]) {
                    [dataArr addObject:dic];
                }
                
                for (NSDictionary *dict in dataArr) {
                    [self.fakeDatasource addObject:dict];
                }
                
                for (NSDictionary  *dict in self.fakeDatasource) {
                    DynamicsModel * model = [DynamicsModel modelWithDictionary:dict];
                    if (model.is_praise == 0){ //不是自己点赞
                        model.isThumb = NO;
                    } else if (model.is_praise == 1) { //是自己点赞
                        model.isThumb = YES;
                    }
                    NSMutableArray *likeArr = [NSMutableArray array];
                    for (NSDictionary *likeDic in model.praise) {
                        DynamicsLikeItemModel *likeModel = [DynamicsLikeItemModel new];
                        [likeModel setValuesForKeysWithDictionary:likeDic];
                        [likeArr addObject:likeModel];
                    }
                    
                    model.likeArr = [likeArr copy];
                    NSMutableArray *tempComments = [NSMutableArray new];
                    for (NSDictionary *dic in model.discuss) {
                            DynamicsCommentItemModel * commentModel = [DynamicsCommentItemModel new];
                            [commentModel setValuesForKeysWithDictionary:dic];
                            [tempComments addObject:commentModel];
                    }
                    model.commentArr = [tempComments copy];
                    NewDynamicsLayout * layout = [[NewDynamicsLayout alloc] initWithModel:model];
                    [self.layoutsArr addObject:layout];
                }
                self.zanwushuju.alpha = 0;
                [self.dynamicsTable reloadData];
            }
            
        } else {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
            }
            [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [WProgressHUD hideAllHUDAnimated:YES];
    }];
}


- (void)getDataFromGetAlbumURL1:(NSDictionary *)dic {
    [WProgressHUD showHUDShowText:@"正在加载中..."];
    [[HttpRequestManager sharedSingleton] POST:GetAlbumURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        [WProgressHUD hideAllHUDAnimated:YES];
        
        //结束头部刷新
        [self.dynamicsTable.mj_header endRefreshing];
        //结束尾部刷新
        [self.dynamicsTable.mj_footer endRefreshing];
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            
            NSMutableArray *arr = [responseObject objectForKey:@"data"];
            if (arr.count == 0) {
                NSLog(@"刷新无数据");
                if (self.fakeDatasource.count == 0) {
                    self.zanwushuju.alpha = 1;
                } else {
                    return;
                }

            } else {
                
                NSMutableArray *dataArr = [NSMutableArray array];
                for (NSDictionary *dic in [responseObject objectForKey:@"data"]) {
                    [dataArr addObject:dic];
                }
                
                for (NSDictionary *dict in dataArr) {
                    [self.fakeDatasource addObject:dict];
                }
                
                NSMutableArray *array = [NSMutableArray array];
                for (NSDictionary *dict in dataArr) {
                    [array addObject:dict];
                }
                
                for (NSDictionary  *dict in array) {
                    DynamicsModel *model = [DynamicsModel modelWithDictionary:dict];
                    if (model.is_praise == 0) { //不是自己点赞
                        model.isThumb = NO;
                    } else if (model.is_praise == 1) { //是自己点赞
                        model.isThumb = YES;
                    }
                    NSMutableArray *likeArr = [NSMutableArray array];
                    for (NSDictionary *likeDic in model.praise) {
                        DynamicsLikeItemModel *likeModel = [DynamicsLikeItemModel new];
                        [likeModel setValuesForKeysWithDictionary:likeDic];
                        [likeArr addObject:likeModel];
                    }
                    
                    model.likeArr = [likeArr copy];
                    NSMutableArray *tempComments = [NSMutableArray new];
                    for (NSDictionary *dic in model.discuss) {
                        DynamicsCommentItemModel * commentModel = [DynamicsCommentItemModel new];
                        [commentModel setValuesForKeysWithDictionary:dic];
                        [tempComments addObject:commentModel];
                        
                    }
                    model.commentArr = [tempComments copy];
                    NewDynamicsLayout *layout = [[NewDynamicsLayout alloc] initWithModel:model];
                    [self.layoutsArr addObject:layout];
                }
                self.zanwushuju.alpha = 0;
                [self.dynamicsTable reloadData];
            }
            
        } else {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
            }
            [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [WProgressHUD hideAllHUDAnimated:YES];
    }];
}


#pragma mark ======= 获取个人信息数据 =======
- (void)setUser {
    NSDictionary * dic = @{@"key":[UserManager key]};
    [[HttpRequestManager sharedSingleton] POST:getUserInfoURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            self.userNameStr = [[responseObject objectForKey:@"data"] objectForKey:@"name"];
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
    
    [JRMenuView dismissAllJRMenu];
    UploadPhotosViewController *uploadPhotosVC = [UploadPhotosViewController new];
    if ([self.typeStr isEqualToString:@"1"]) {
        uploadPhotosVC.typeStr = @"1";
    }
    [self.navigationController pushViewController:uploadPhotosVC animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [JRMenuView dismissAllJRMenu];
}

- (void)classBtn:(UIButton *)sender {
    [JRMenuView dismissAllJRMenu];
    [self getClassURLDataForClassID];
}

#pragma mark ======= 获取班级列表数据 =======
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
        self.pageID = 1;
        [self.classBtn setTitle:model.name forState:UIControlStateNormal];
        [self.fakeDatasource removeAllObjects];
        [self.layoutsArr removeAllObjects];
        
        NSDictionary  *dic = @{@"key":[UserManager key], @"class_id":self.classID, @"page":[NSString stringWithFormat:@"%ld",self.pageID]};
        [self getDataFromGetAlbumURL:dic];
        [self.dynamicsTable reloadData];
    }
}


- (void)keyboardWillHide:(NSNotification *)notification {
    CGRect frame = _commentInputTF.frame;
    frame.origin.y = self.view.frame.size.height;
    _commentInputTF.frame = frame;
}

- (void)keyboardFrameWillChange:(NSNotification *)notification {
    CGRect keyBoardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect frame = _commentInputTF.frame;
    frame.origin.y = keyBoardFrame.origin.y - 45;
    _commentInputTF.frame = frame;
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [JRMenuView dismissAllJRMenu];
}

- (void)setup {
    [self.view addSubview:self.dynamicsTable];
}



#pragma mark - getter
- (UITableView *)dynamicsTable {
    if (!_dynamicsTable) {
        _dynamicsTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_NAVH) style:UITableViewStylePlain];
        _dynamicsTable.dataSource = self;
        _dynamicsTable.delegate = self;
        _dynamicsTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _dynamicsTable.backgroundColor = backColor;
        [_dynamicsTable registerClass:[NewDynamicsTableViewCell class] forCellReuseIdentifier:@"NewDynamicsTableViewCell"];
       
        if ([[[UIDevice currentDevice] systemVersion] compare:@"11.0" options:NSNumericSearch] != NSOrderedAscending) {
            _dynamicsTable.estimatedRowHeight = 0;
        }
        
        UITapGestureRecognizer * tableViewGesture = [[UITapGestureRecognizer alloc] bk_initWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
            [_commentInputTF resignFirstResponder];
        }];
        
        tableViewGesture.cancelsTouchesInView = NO;
        [_dynamicsTable addGestureRecognizer:tableViewGesture];
    }
    return _dynamicsTable;
}



- (UITextField *)commentInputTF {
    if (!_commentInputTF) {
        _commentInputTF = [[UITextField alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 45)];
        _commentInputTF.backgroundColor = [UIColor lightGrayColor];
        _commentInputTF.delegate = self;
        _commentInputTF.textColor = [UIColor whiteColor];
        _commentInputTF.returnKeyType = UIReturnKeySend;

    }
    return _commentInputTF;
}

@end
