//
//  HomePageJViewController.m
//  ZhiNengXiaoFu
//
//  Created by 独秀科技 on 2018/9/28.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "HomePageJViewController.h"
#import "HomePageJingJiView.h"
#import "WorkCell.h"
#import "SchoolDongTaiCell.h"
#import "HomePageTongZhiView.h"
#import "SchoolDongTaiViewController.h"
#import "TongZhiViewController.h"
#import "NewDynamicsViewController.h"
#import "NewGuidelinesViewController.h"
#import "HomeWorkPViewController.h"
#import "ParentXueTangNewViewController.h"
#import "TeacherZaiXianTotalViewController.h"
#import "CompetitiveActivityViewController.h"
#import "HomeBannerModel.h"
#import "TongZhiDetailsViewController.h"
#import "WorkDetailsViewController.h"
#import "JingJiActivityDetailsViewController.h"
#import "SchoolDongTaiDetailsViewController.h"
#import "WenTiZiXunViewController.h"
#import <JPUSHService.h>
#import "TeacherOnlineViewController.h"
#import "HomePageNumberModel.h"
#import "ClassScheduleViewController.h"

@interface HomePageJViewController ()<UITableViewDelegate, UITableViewDataSource, HomePageJingJiViewDelegate, ZXCycleScrollViewDelegate>

@property (nonatomic, strong) NSString           *schoolName;
/**
 *  图片数组
 */
@property (nonatomic, strong) NSMutableArray      *imageArray;
@property (nonatomic, strong) UITableView         *HomePageJTabelView;
@property (nonatomic, strong) UIImageView         *img;
@property (nonatomic, strong) NSMutableArray      *bannerArr;
@property (nonatomic, strong) NSMutableArray      *imgArr;
@property (nonatomic, strong) NSMutableArray      *tongzhiAry;
@property (nonatomic, strong) NSMutableArray      *workAry;
@property (nonatomic, strong) NSMutableArray      *jingJiAry;
@property (nonatomic, strong) NSMutableArray      *dongtaiAry;
@property (nonatomic, strong) HomePageTongZhiView *ccspView;
@property (nonatomic, strong) UIImageView         *tongZhiImg;
@property (nonatomic, strong) UIView              *FiveView;
@property (nonatomic, strong) NSMutableArray      *numberAry;
@property (nonatomic,strong) ZXCycleScrollView    *scrollView;

@end

@implementation HomePageJViewController

- (NSMutableArray *)numberAry {
    if (!_numberAry) {
        self.numberAry = [@[]mutableCopy];
    }
    return _numberAry;
}

- (NSMutableArray *)imgArr {
    if (!_imgArr) {
        _imgArr = [NSMutableArray array];
    }
    return _imgArr;
}

- (NSMutableArray *)bannerArr {
    if (!_bannerArr) {
        _bannerArr = [NSMutableArray array];
    }
    return _bannerArr;
}

- (NSMutableArray *)tongzhiAry {
    if (!_tongzhiAry) {
        _tongzhiAry = [NSMutableArray array];
    }
    return _tongzhiAry;
}

- (NSMutableArray *)workAry {
    if (!_workAry) {
        _workAry = [NSMutableArray array];
    }
    return _workAry;
}

- (void)viewWillAppear:(BOOL)animated {
    [self huoQuNumber];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image1 = [UIImage imageNamed:@"banner"];
    UIImage *image2 = [UIImage imageNamed:@"bannerHelper"];
    UIImage *image3 = [UIImage imageNamed:@"教师端活动管理banner"];
    UIImage *image4 = [UIImage imageNamed:@"banner"];
    UIImage *image5 = [UIImage imageNamed:@"请假列表背景图"];
    self.imageArray = [NSMutableArray arrayWithObjects:image1,image2,image3, image4,image5,nil];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUser];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [self.view addSubview:self.HomePageJTabelView];
    self.HomePageJTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.HomePageJTabelView registerNib:[UINib nibWithNibName:@"WorkCell" bundle:nil] forCellReuseIdentifier:@"WorkCellId"];
    [self.HomePageJTabelView registerNib:[UINib nibWithNibName:@"SchoolDongTaiCell" bundle:nil] forCellReuseIdentifier:@"SchoolDongTaiCellId"];
    
    //下拉刷新
    self.HomePageJTabelView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getIndexURLData)];
    //自动更改透明度
    self.HomePageJTabelView.mj_header.automaticallyChangeAlpha = YES;
    //进入刷新状态
    [self.HomePageJTabelView.mj_header beginRefreshing];
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidSetup:)
                          name:kJPFNetworkDidSetupNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidClose:)
                          name:kJPFNetworkDidCloseNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidRegister:)
                          name:kJPFNetworkDidRegisterNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidLogin:)
                          name:kJPFNetworkDidLoginNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidReceiveMessage:)
                          name:kJPFNetworkDidReceiveMessageNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(serviceError:)
                          name:kJPFServiceErrorNotification
                        object:nil];
    
     [self pushJiGuangId];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(guanbiGunDong:) name:@"guanbiGunDong" object:nil];
}

- (void)guanbiGunDong:(NSNotification *)nofity {
    [self.ccspView removeTimer];
}


- (void)pushJiGuangId {
    
    [self.HomePageJTabelView reloadData];
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        NSDictionary * dic = [NSDictionary dictionary];
        if (registrationID == nil) {
            dic = @{@"push_id":@"", @"system":@"ios", @"key":[UserManager key]};
        } else {
            dic = @{@"push_id":registrationID, @"system":@"ios", @"key":[UserManager key]};
        }
        
        [[HttpRequestManager sharedSingleton] POST:UserSavePushId parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
            if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
                
            } else {
                if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                    [UserManager logoOut];
                    [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
                    
                } else {
                    
                }
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"%@", error);
        }];
    }];
}

- (void)huoQuNumber {
    NSDictionary * dic = @{@"key":[UserManager key]};
    [[HttpRequestManager sharedSingleton] POST:UserGetUnreadNumber parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        HomePageNumberModel * model = [HomePageNumberModel mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
        NSString * activity = [[NSString alloc] init];
        if (model.activity > 9) {
            activity = @"9+";
        } else {
            activity = [NSString stringWithFormat:@"%ld", model.activity];
        }
        
        NSString * consult = [[NSString alloc] init];
        if (model.consult > 9) {
            consult = @"9+";
        } else {
            consult = [NSString stringWithFormat:@"%ld", model.consult];
        }
        
        NSString * dynamic = [[NSString alloc] init];
        if (model.dynamic > 9) {
            dynamic = @"9+";
        } else {
            dynamic = [NSString stringWithFormat:@"%ld", model.dynamic];
        }
        
        NSString * homework = [[NSString alloc] init];
        if (model.homework > 9) {
            homework = @"9+";
        } else {
            homework = [NSString stringWithFormat:@"%ld", model.homework];
        }
        
        NSString * notice = [[NSString alloc] init];
        if (model.notice > 9) {
            notice = @"9+";
        } else {
            notice = [NSString stringWithFormat:@"%ld", model.notice];
        }
        
        self.numberAry = [NSMutableArray arrayWithObjects:notice,homework,@"0",@"0",@"0",consult,activity,dynamic,@"0" ,nil];
        
        [self.HomePageJTabelView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
        
    }];
}


- (void)unObserveAllNotifications {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter removeObserver:self
                             name:kJPFNetworkDidSetupNotification
                           object:nil];
    [defaultCenter removeObserver:self
                             name:kJPFNetworkDidCloseNotification
                           object:nil];
    [defaultCenter removeObserver:self
                             name:kJPFNetworkDidRegisterNotification
                           object:nil];
    [defaultCenter removeObserver:self
                             name:kJPFNetworkDidLoginNotification
                           object:nil];
    [defaultCenter removeObserver:self
                             name:kJPFNetworkDidReceiveMessageNotification
                           object:nil];
    [defaultCenter removeObserver:self
                             name:kJPFServiceErrorNotification
                           object:nil];
}

- (void)networkDidSetup:(NSNotification *)notification {
    NSLog(@"已连接");
}

- (void)networkDidClose:(NSNotification *)notification {
    NSLog(@"未连接");
}

- (void)networkDidRegister:(NSNotification *)notification {
    NSLog(@"%@", [notification userInfo]);
    NSLog(@"已注册");
}

- (void)networkDidLogin:(NSNotification *)notification {
    
    NSLog(@"已登录");
    if ([JPUSHService registrationID]) {
        NSLog(@"get RegistrationID");
    }
}

- (void)networkDidReceiveMessage:(NSNotification *)notification {
    
}



#pragma mark ======= 获取首页数据 =======

- (void)getIndexURLData {
    NSDictionary *dic = @{@"key":[UserManager key]};
    [[HttpRequestManager sharedSingleton] POST:indexURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            [self.bannerArr removeAllObjects];
            [self.imgArr removeAllObjects];
            NSDictionary *dataDic = [responseObject objectForKey:@"data"];
            self.bannerArr = [HomeBannerModel mj_objectArrayWithKeyValuesArray:[dataDic objectForKey:@"banner"]];
            for (NSDictionary *bannerDict in [dataDic objectForKey:@"banner"]) {
                HomeBannerModel *model = [[HomeBannerModel alloc] init];
                model.img = [bannerDict objectForKey:@"img"];
                [self.imgArr addObject:model.img];
            }
            
            self.tongzhiAry = [dataDic objectForKey:@"notice"];
            self.workAry    = [dataDic objectForKey:@"homework"];
            self.jingJiAry  = [dataDic objectForKey:@"activity"];
            self.dongtaiAry = [dataDic objectForKey:@"dynamic"];
            
            if (self.imgArr.count == 0) {
                UIImage *image1 = [UIImage imageNamed:@"banner"];
                UIImage *image2 = [UIImage imageNamed:@"bannerHelper"];
                UIImage *image3 = [UIImage imageNamed:@"教师端活动管理banner"];
                UIImage *image4 = [UIImage imageNamed:@"banner"];
                UIImage *image5 = [UIImage imageNamed:@"请假列表背景图"];
                self.imgArr = [NSMutableArray arrayWithObjects:image1,image2,image3, image4,image5,nil];
            }
            [self.HomePageJTabelView reloadData];
            [self.HomePageJTabelView.mj_header endRefreshing];
        } else {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
            } else {
                
            }
            [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
             [self.HomePageJTabelView.mj_header endRefreshing];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (UITableView *)HomePageJTabelView {
    if (!_HomePageJTabelView) {
        self.HomePageJTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - APP_NAVH - APP_TABH)];
        self.HomePageJTabelView.delegate = self;
        self.HomePageJTabelView.dataSource = self;
    }
    return _HomePageJTabelView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 5 ) {
        if (self.dongtaiAry.count == 0) {
            return 1;
        } else {
        return self.dongtaiAry.count;
        }
    } else if (section == 3) {
        if (self.workAry.count == 0) {
            return 1;
        } else {
            return self.workAry.count;
        }
    } else {
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 155;
    } else if (indexPath.section == 1) {
        return 90;
    } else if (indexPath.section == 2) {
        return 75 - 10;
    } else if (indexPath.section == 3) {
         if (self.workAry.count == 0) {
             return 60;
         } else {
              return 80;
         }
    } else if (indexPath.section == 4) {
        if (self.jingJiAry.count == 0) {
            return 60;
        } else {
           return (kScreenWidth - 40) / 3 * 144 / 235 + 25 - 10;
        }
    } else {
        if (self.dongtaiAry.count == 0) {
            return 60;
        } else {
            return 104;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"TableViewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        } else {
            //删除cell中的子对象,刷新覆盖问题。
            while ([cell.contentView.subviews lastObject] != nil) {
                [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
            }
        }
        
        self.automaticallyAdjustsScrollViewInsets = NO;
        
        [self.scrollView removeAllSubviews];
        self.scrollView = [ZXCycleScrollView  initWithFrame:CGRectMake(0, 0, APP_WIDTH, 150) withMargnPadding:10 withImgWidth:APP_WIDTH - 40 dataArray:self.imgArr];
        self.scrollView.delegate = self;
        [cell addSubview:self.scrollView];
        self.scrollView.otherPageControlColor = [UIColor blueColor];
        self.scrollView.curPageControlColor = [UIColor whiteColor];
        self.scrollView.sourceDataArr = self.imgArr;
        self.scrollView.autoScroll = YES;
        
        [cell addSubview:self.scrollView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else  if (indexPath.section == 1) {
        
        [self.FiveView removeFromSuperview];
        static NSString *CellIdentifier = @"TableViewCell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        } else {
            //删除cell中的子对象,刷新覆盖问题。
            while ([cell.contentView.subviews lastObject] != nil) {
                [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
            }
        }
        
        NSMutableArray * imgAry = [NSMutableArray arrayWithObjects:@"名师在线",@"班级课表",@"家长学堂",@"问题咨询",@"成长手册", nil];
        NSMutableArray * titleAry = [NSMutableArray arrayWithObjects:@"名师在线",@"班级课表",@"家长学堂",@"问题咨询",@"班级圈子", nil];
        NSInteger width = (kScreenWidth - 50 - 40 * 5) / 4;
        
        self.FiveView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 90)];
        self.FiveView.backgroundColor = [UIColor whiteColor];
        self.FiveView.userInteractionEnabled  = YES;
        [cell addSubview:self.FiveView];
        for (int i = 0; i < 5; i++) {
            
            UIButton * back = [[UIButton alloc] initWithFrame:CGRectMake(25 + i * (40 + width), 10, 40, 40)];
            [back setBackgroundImage:[UIImage imageNamed:[imgAry objectAtIndex:i]] forState:UIControlStateNormal];
            [back addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchDown];
            back.tag = i;
            [self.FiveView addSubview:back];
            
            UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(back.frame.origin.x - 5, back.frame.origin.y + back.frame.size.height + 5, 50, 15)];
            titleLabel.text = [titleAry objectAtIndex:i];
            titleLabel.font = [UIFont systemFontOfSize:12];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.textColor = RGB(119, 119, 119);
            [self.FiveView addSubview:titleLabel];
        }
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 80, kScreenWidth, 10)];
        lineView.backgroundColor = [UIColor colorWithRed:250 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:1];
        [self.FiveView addSubview:lineView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.section == 2) {
        [self.ccspView removeFromSuperview];
        [self.tongZhiImg removeFromSuperview];
        [ self.ccspView removeTimer];
        static NSString *CellIdentifier = @"Cell";
        // 通过唯一标识创建cell实例
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        // 判断为空进行初始化  --（当拉动页面显示超过主页面内容的时候就会重用之前的cell，而不会再次初始化）
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        } else { //当页面拉动的时候 当cell存在并且最后一个存在 把它进行删除就出来一个独特的cell我们在进行数据配置即可避免
            while ([cell.contentView.subviews lastObject] != nil) {
                [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
            }
        }
        
        if (self.tongzhiAry.count > 0) {
            self.tongZhiImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 46, 39)];
            self.tongZhiImg.image = [UIImage imageNamed:@"通知New"];
            [cell addSubview:self.tongZhiImg];
            
            UITapGestureRecognizer * tongzhiTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tongzhiTap:)];
            self.tongZhiImg.userInteractionEnabled = YES;
            [self.tongZhiImg addGestureRecognizer:tongzhiTap];
            
            self.ccspView  =[[HomePageTongZhiView alloc] initWithFrame:CGRectMake(46 + 15 + 10, 0, kScreenWidth, 60)];
            self.ccspView.titleArray = self.tongzhiAry;
            
            __weak typeof(self)blockSelf = self;
            [ self.ccspView setClickLabelBlock:^(NSInteger index, NSString * _Nonnull titleString)
             {
                 [blockSelf setClick:index];
             }];
            [cell.contentView addSubview: self.ccspView];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.section == 3) {

        if (self.workAry.count == 0) {
            static NSString *CellIdentifier = @"TableViewCell4";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
            } else {
                //删除cell中的子对象,刷新覆盖问题。
                while ([cell.contentView.subviews lastObject] != nil) {
                    [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
                }
            }
            
            UILabel * zanwuLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth / 2 -50, 20, 100, 20)];
            zanwuLabel.textColor = RGB(170, 170, 170);
            zanwuLabel.textAlignment = NSTextAlignmentCenter;
            zanwuLabel.text = @"暂无数据";
            zanwuLabel.font = [UIFont systemFontOfSize:13];
            [cell.contentView addSubview:zanwuLabel];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        } else {
            
            WorkCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WorkCellId" forIndexPath:indexPath];
            NSDictionary * dic = [self.workAry objectAtIndex:indexPath.row];
            [cell.WorkImg sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"head_img"]] placeholderImage:[UIImage imageNamed:@"user"]];
            cell.WorkTitleLabel.text = [dic objectForKey:@"title"];
            cell.WorkConnectLabel.text = [dic objectForKey:@"course_name"];
            cell.WorkTimeLabel.text = [dic objectForKey:@"create_time"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        }
        
    } else if (indexPath.section == 4) {
        if (self.jingJiAry.count == 0) {
            static NSString *CellIdentifier = @"TableViewCell7";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
            } else {
                //删除cell中的子对象,刷新覆盖问题。
                while ([cell.contentView.subviews lastObject] != nil) {
                    [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
                }
            }
            
            UILabel * zanwuLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth / 2 -50, 20, 100, 20)];
            zanwuLabel.textColor = RGB(170, 170, 170);
            zanwuLabel.textAlignment = NSTextAlignmentCenter;
            zanwuLabel.text = @"暂无数据";
            zanwuLabel.font = [UIFont systemFontOfSize:13];
            [cell.contentView addSubview:zanwuLabel];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        } else {
            
            static NSString *CellIdentifier = @"TableViewCell6";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
            } else {
                //删除cell中的子对象,刷新覆盖问题。
                while ([cell.contentView.subviews lastObject] != nil) {
                    [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
                }
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.userInteractionEnabled = YES;
            NSArray *array=[NSArray arrayWithArray:self.jingJiAry];
            HomePageJingJiView *view=[[HomePageJingJiView alloc] init];
            view.frame=CGRectMake(0,0, kScreenWidth,  (kScreenWidth - 40) / 3 * 144 / 235 + 25 - 10);
            view.HomePageJingJiViewDelegate = self;
            [view setDetail:array];
            [cell.contentView addSubview:view];
            return cell;
        }
       
    } else {
        
        if (self.dongtaiAry.count == 0) {
            static NSString *CellIdentifier = @"TableViewCell5";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
            } else {
                //删除cell中的子对象,刷新覆盖问题。
                while ([cell.contentView.subviews lastObject] != nil) {
                    [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
                }
            }
            
            UILabel * zanwuLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth / 2 -50, 20, 100, 20)];
            zanwuLabel.textColor = RGB(170, 170, 170);
            zanwuLabel.textAlignment = NSTextAlignmentCenter;
            zanwuLabel.text = @"暂无数据";
            zanwuLabel.font = [UIFont systemFontOfSize:13];
            [cell.contentView addSubview:zanwuLabel];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        } else {
            
            SchoolDongTaiCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SchoolDongTaiCellId" forIndexPath:indexPath];
            NSDictionary * dic = [self.dongtaiAry objectAtIndex:indexPath.row];
            [cell.SchoolDongTaiImg sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"img"]]];
            cell.SchoolDongTaiTitleLabel.text = [dic objectForKey:@"title"];
            cell.SchoolDongTaiConnectLabel.text = [dic objectForKey:@"content"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 3 || section == 4 || section == 5) {
        UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        header.backgroundColor = [UIColor whiteColor];
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
        lineView.backgroundColor = [UIColor colorWithRed:250 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:1];
        [header addSubview:lineView];
        
        header.userInteractionEnabled = YES;
        if (section == 3) {
            self.img = [[UIImageView alloc] initWithFrame:CGRectMake(15, 14 + 10, 15, 12)];
            self.img.image = [UIImage imageNamed:@"查看作业"];
        } else if (section == 4) {
            self.img = [[UIImageView alloc] initWithFrame:CGRectMake(15, 12.5 + 10, 15, 15)];
            self.img.image = [UIImage imageNamed:@"竞技活动头"];
        } else {
            self.img = [[UIImageView alloc] initWithFrame:CGRectMake(15, 12 + 10, 14, 16)];
            self.img.image = [UIImage imageNamed:@"学校动态头"];
        }
       
        [header addSubview:self.img];
        
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.img.frame.origin.x + self.img.frame.size.width + 5, 10 + 10, 200, 20)];
        if (section == 3) {
            titleLabel.text = @"查看作业";
        } else if (section == 4) {
            titleLabel.text = @"竞技活动";
        } else {
            titleLabel.text = @"学校动态";
        }
        
        titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:17];
        titleLabel.textColor = RGB(51, 51, 51);
        [header addSubview:titleLabel];
        
        UILabel * moreLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 55, 14 + 10, 25, 12)];
        moreLabel.text = @"更多";
        moreLabel.textColor = RGB(170, 170, 170);
        moreLabel.font = [UIFont systemFontOfSize:12];
        [header addSubview:moreLabel];
        
        UIImageView * moreImg = [[UIImageView alloc] initWithFrame:CGRectMake(moreLabel.frame.origin.x + moreLabel.frame.size.width + 4, 14 + 10, 12, 12)];
        moreImg.image = [UIImage imageNamed:@"返回"];
        [header addSubview:moreImg];
        
        UIView * clickView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth - 80, 0, 80, 50)];
        clickView.backgroundColor = [UIColor clearColor];
        [header addSubview:clickView];
        
        UITapGestureRecognizer * headerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerTap:)];
        clickView.userInteractionEnabled = YES;
        clickView.tag = section;
        [clickView addGestureRecognizer:headerTap];
        return header;
        
    } else {
        return nil;
    }
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

//有时候tableview的底部视图也会出现此现象对应的修改就好了
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 3) {
        WorkDetailsViewController * workDetailsVC = [[WorkDetailsViewController alloc] init];
        if (self.workAry.count != 0) {
            NSDictionary * model = [self.workAry objectAtIndex:indexPath.row];
            workDetailsVC.workId = [model objectForKey:@"id"];
            [self.navigationController pushViewController:workDetailsVC animated:YES];
        }
    } else if (indexPath.section == 5) {
        SchoolDongTaiDetailsViewController *schoolDongTaiDetailsVC = [[SchoolDongTaiDetailsViewController alloc] init];
        if (self.dongtaiAry.count != 0) {
            NSDictionary * model = [self.dongtaiAry objectAtIndex:indexPath.row];
             schoolDongTaiDetailsVC.schoolDongTaiId  = [model objectForKey:@"id"];
            [self.navigationController pushViewController:schoolDongTaiDetailsVC animated:YES];
        }
    }
}

- (void)headerTap:(UITapGestureRecognizer *)sender {
    if (sender.view.tag == 3) {
        HomeWorkPViewController * homeWorkVC = [[HomeWorkPViewController alloc] init];
        [self.navigationController pushViewController:homeWorkVC animated:YES];
    } else if (sender.view.tag == 4) {
        CompetitiveActivityViewController * comeptitiveActivityVC = [[CompetitiveActivityViewController alloc] init];
        [self.navigationController pushViewController:comeptitiveActivityVC animated:YES];
    } else if (sender.view.tag == 5) {
        SchoolDongTaiViewController * schoolDongTaiVC = [[SchoolDongTaiViewController alloc] init];
        [self.navigationController pushViewController:schoolDongTaiVC animated:YES];
    }
}

- (void)jumpToAnswerHomePageJingJi:(NSString *)answerStr weizhi:(NSString *)weizhi {
    JingJiActivityDetailsViewController *jingJiActivityDetailsVC = [JingJiActivityDetailsViewController new];
    jingJiActivityDetailsVC.JingJiActivityDetailsId = answerStr;
    [self.navigationController pushViewController:jingJiActivityDetailsVC animated:YES];
}

- (void)setClick:(NSInteger)index {
    TongZhiDetailsViewController * tongZhiDetails  = [[TongZhiDetailsViewController alloc] init];
    tongZhiDetails.tongZhiId = [NSString stringWithFormat:@"%ld", index];
    [self.navigationController pushViewController:tongZhiDetails animated:YES];
}

#pragma mark  - 点击通知图标
- (void)tongzhiTap:(UITapGestureRecognizer *)sender {
    TongZhiViewController * teacherTongZhiVC = [[TongZhiViewController alloc] init];
    [self.navigationController pushViewController:teacherTongZhiVC animated:YES];
}

- (void)backBtn:(UIButton *)sender {
    switch (sender.tag) {
        case 0:
        {
            TeacherOnlineViewController *teacherZaiXianVC = [[TeacherOnlineViewController alloc] init];
            [self.navigationController pushViewController:teacherZaiXianVC animated:YES];
        }
            break;
        case 1:
        {
            NSLog(@"班级课表");
//            NewGuidelinesViewController *newGuidelinesVC = [NewGuidelinesViewController new];
//            [self.navigationController pushViewController:newGuidelinesVC animated:YES];
            ClassScheduleViewController *classScheduleVC = [ClassScheduleViewController new];
            classScheduleVC.titleStr = @"课程表";
            [self.navigationController pushViewController:classScheduleVC animated:YES];
        }
            break;
        case 2:
        {
            NSLog(@"家长学堂");
            ParentXueTangNewViewController * parentX = [[ParentXueTangNewViewController alloc] init];
            [self.navigationController pushViewController:parentX animated:YES];
        }
            break;
        case 3:
        {
            NSLog(@"问题咨询");
            WenTiZiXunViewController * wenTiZiXunVC = [[WenTiZiXunViewController alloc] init];
            [self.navigationController pushViewController:wenTiZiXunVC animated:YES];
        }
            break;
        case 4:
        {
            NSLog(@"班级圈子");
            NewDynamicsViewController *newDynamicsVC = [NewDynamicsViewController new];
            newDynamicsVC.typeStr = @"1";
            [self.navigationController pushViewController:newDynamicsVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
     if (section == 3 || section == 4 || section == 5) {
         return 50;
     } else {
         return 0;
     }
}







#pragma mark ======= 获取个人信息数据 =======
- (void)setUser {
    NSDictionary *dic = @{@"key":[UserManager key]};
    [[HttpRequestManager sharedSingleton] POST:getUserInfoURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            self.schoolName = [[responseObject objectForKey:@"data"] objectForKey:@"school_name"];
            UILabel  *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 200, 44)];
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.font = [UIFont boldSystemFontOfSize:18];
            titleLabel.textColor = [UIColor blackColor];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.text = self.schoolName;
            self.navigationItem.titleView = titleLabel;
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


-(void)zxCycleScrollView:(ZXCycleScrollView *)scrollView didSelectItemAtIndex:(NSInteger)index {
    if (self.bannerArr.count > 0) {
        HomeBannerModel *model = [self.bannerArr objectAtIndex:index];
        if (![model.url isEqualToString:@""]) {
            TGWebViewController *web = [[TGWebViewController alloc] init];
            web.url = [NSString stringWithFormat:@"%@",model.url];
            web.webTitle = @"定位器";
            [self.navigationController pushViewController:web animated:YES];
        }
    }
}


@end
