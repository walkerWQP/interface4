//
//  HomeTViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/10/10.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "HomeTViewController.h"
#import "HomePageJingJiView.h"
#import "WorkCell.h"
#import "WorkTableViewCell.h"
#import "SchoolDongTaiCell.h"
#import "HomePageTongZhiView.h"
#import "OffTheListViewController.h"
#import "NewGuidelinesViewController.h"
#import "PublishJobModel.h"
#import "NewDynamicsViewController.h"
#import "TeacherNotifiedViewController.h"
#import "HomeBannerModel.h"
#import "ConsultingViewController.h"
#import "SchoolDongTaiViewController.h"
#import "SchoolTongZhiViewController.h"
#import "TeacherNotifiedModel.h"
#import "HomeWorkViewController.h"
#import "ActivityManagementViewController.h"
#import "TongZhiDetailsViewController.h"
#import "WorkDetailsViewController.h"
#import "JingJiActivityDetailsViewController.h"
#import "SchoolDongTaiDetailsViewController.h"
#import <JPUSHService.h>
#import "HomePageNumberModel.h"
#import "ClassScheduleViewController.h"

@interface HomeTViewController ()<UITableViewDelegate,UITableViewDataSource, HomePageJingJiViewDelegate,ZXCycleScrollViewDelegate>


@property (nonatomic, strong) NSString            *schoolName;
@property (nonatomic, strong) UITableView         *HomePageJTabelView;
@property (nonatomic, strong) UIImageView         *img;
@property (nonatomic, strong) NSMutableArray      *publishJobArr;
@property (nonatomic, strong) NSString            *classID;
@property (nonatomic, strong) NSString            *className;
@property (nonatomic, strong) NSMutableArray      *bannerArr;
@property (nonatomic, strong) NSMutableArray      *imgArr;
@property (nonatomic, strong) NSMutableArray      *classArr;
@property (nonatomic, strong) NSMutableArray      *activityArr;
@property (nonatomic, strong) NSMutableArray      *tongzhiAry;
@property (nonatomic, strong) NSMutableArray      *jingjiAry;
@property (nonatomic, strong) NSMutableArray      *dongtaiAry;
@property (nonatomic, strong) HomePageTongZhiView *ccspView;
@property (nonatomic, strong) UIImageView         *tongZhiImg;
@property (nonatomic, strong) UIView              *FiveView;
@property (nonatomic, strong) NSMutableArray      *numberAry;
@property (nonatomic,strong) ZXCycleScrollView    *scrollView;





@end

@implementation HomeTViewController



- (NSMutableArray *)numberAry {
    if (!_numberAry) {
        self.numberAry = [@[]mutableCopy];
    }
    return _numberAry;
}

- (NSMutableArray *)activityArr {
    if (!_activityArr) {
        _activityArr = [NSMutableArray array];
    }
    return _activityArr;
}

- (NSMutableArray *)classArr {
    if (!_classArr) {
        _classArr = [NSMutableArray array];
    }
    return _classArr;
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

- (NSMutableArray *)publishJobArr {
    if (!_publishJobArr) {
        _publishJobArr = [NSMutableArray array];
    }
    return _publishJobArr;
}

- (NSMutableArray *)tongzhiAry {
    if (!_tongzhiAry) {
        _tongzhiAry = [NSMutableArray array];
    }
    return _tongzhiAry;
}

- (NSMutableArray *)jingjiAry {
    if (!_jingjiAry) {
        _jingjiAry = [NSMutableArray array];
    }
    return _jingjiAry;
}

- (NSMutableArray *)dongtaiAry {
    if (!_dongtaiAry) {
        _dongtaiAry = [NSMutableArray array];
    }
    return _dongtaiAry;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setUser];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backColor;
    [self.view addSubview:self.HomePageJTabelView];
    self.HomePageJTabelView.backgroundColor = backColor;
    self.HomePageJTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.HomePageJTabelView registerClass:[WorkTableViewCell class] forCellReuseIdentifier:@"WorkTableViewCellId"];
    
    [self.HomePageJTabelView registerNib:[UINib nibWithNibName:@"SchoolDongTaiCell" bundle:nil] forCellReuseIdentifier:@"SchoolDongTaiCellId"];
    //下拉刷新
    self.HomePageJTabelView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
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
        
        NSString * leave = [[NSString alloc] init];
        if (model.leave > 9) {
            leave = @"9+";
        } else {
            leave = [NSString stringWithFormat:@"%ld", model.leave];
        }
        NSString * notice_s = [[NSString alloc] init];
        if (model.notice_s > 9) {
            notice_s = @"9+";
        } else {
            notice_s = [NSString stringWithFormat:@"%ld", model.notice_s];
        }
        
        self.numberAry = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",activity,consult,notice_s,dynamic,leave,@"0" ,nil];
        
        [self.HomePageJTabelView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
        
    }];
}


- (void)unObserveAllNotifications {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter removeObserver:self name:kJPFNetworkDidSetupNotification object:nil];
    [defaultCenter removeObserver:self name:kJPFNetworkDidCloseNotification object:nil];
    [defaultCenter removeObserver:self name:kJPFNetworkDidRegisterNotification object:nil];
    [defaultCenter removeObserver:self name:kJPFNetworkDidLoginNotification object:nil];
    [defaultCenter removeObserver:self name:kJPFNetworkDidReceiveMessageNotification object:nil];
    [defaultCenter removeObserver:self name:kJPFServiceErrorNotification object:nil];
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

- (void)loadNewTopic {
    [self getTIndexURLData];
}

- (UITableView *)HomePageJTabelView {
    if (!_HomePageJTabelView) {
        self.HomePageJTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_NAVH - APP_TABH)];
        self.HomePageJTabelView.delegate = self;
        self.HomePageJTabelView.dataSource = self;
    }
    return _HomePageJTabelView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 3) {
        if (self.classArr.count == 0) {
            return 1;
        } else {
           return self.classArr.count;
        }
    } else if (section == 5) {
        if (self.dongtaiAry.count == 0) {
            return 1;
        } else {
            return self.dongtaiAry.count;
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
        if (self.classArr.count == 0) {
            return 60;
        } else {
           return 71;
        }
    } else if (indexPath.section == 4) {
        if (self.jingjiAry.count == 0) {
            return 60;
        } else {
        return (APP_WIDTH - 40) / 3 * 144 / 235 + 25 - 10;
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else if (indexPath.section == 1) {
        
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
       
        NSMutableArray * imgAry = [NSMutableArray arrayWithObjects:@"请假列表",@"问题咨询1",@"班级圈子",@"老师通知",@"课堂表", nil];
        NSMutableArray * titleAry = [NSMutableArray arrayWithObjects:@"请假列表",@"问题咨询",@"班级圈子",@"老师通知",@"班级课表", nil];
        NSInteger width = (APP_WIDTH - 50 - 40 * 5) / 4;

        self.FiveView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 90)];
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
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 80, APP_WIDTH, 10)];
        lineView.backgroundColor = [UIColor colorWithRed:250 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:1];
        [self.FiveView addSubview:lineView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.section == 2) {
        [self.ccspView removeFromSuperview];
        [self.tongZhiImg removeFromSuperview];
        [self.ccspView removeTimer];
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.tongZhiImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 46, 39)];
        self.tongZhiImg.image = [UIImage imageNamed:@"通知New"];
        [cell addSubview:self.tongZhiImg];
        UITapGestureRecognizer *tongzhiTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tongzhiTap:)];
        self.tongZhiImg.userInteractionEnabled = YES;
        [self.tongZhiImg addGestureRecognizer:tongzhiTap];
        
        if (self.tongzhiAry.count > 0) {
            self.ccspView =[[HomePageTongZhiView alloc] initWithFrame:CGRectMake(46 + 15 + 10, 0, APP_WIDTH, 60)];
            self.ccspView.titleArray = self.tongzhiAry;
            __weak typeof(self)blockSelf = self;
            [self.ccspView setClickLabelBlock:^(NSInteger index, NSString * _Nonnull titleString) {
                [blockSelf setClick:index];
            }];
            [cell.contentView addSubview:self.ccspView];
        }
        return cell;
    } else if (indexPath.section == 3) {
        if (self.classArr.count == 0) {
            static NSString *CellIdentifier = @"TableViewCell8";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
            } else {
                //删除cell中的子对象,刷新覆盖问题。
                while ([cell.contentView.subviews lastObject] != nil) {
                    [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
                }
            }
            
            UILabel * zanwuLabel = [[UILabel alloc] initWithFrame:CGRectMake(APP_WIDTH / 2 -50, 20, 100, 20)];
            zanwuLabel.textColor = RGB(170, 170, 170);
            zanwuLabel.textAlignment = NSTextAlignmentCenter;
            zanwuLabel.text = @"暂无数据";
            zanwuLabel.font = [UIFont systemFontOfSize:13];
            [cell.contentView addSubview:zanwuLabel];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        } else {
            WorkTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WorkTableViewCellId" forIndexPath:indexPath];
            TeacherNotifiedModel *model = self.classArr[indexPath.row];
            [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.head_img] placeholderImage:[UIImage imageNamed:@"user"]];
            cell.titleLabel.text = model.name;
            if (indexPath.row == self.classArr.count - 1) {
                cell.lineView.hidden = YES;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
    } else if (indexPath.section == 4) {
        
        if (self.jingjiAry.count == 0) {
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
            
            UILabel * zanwuLabel = [[UILabel alloc] initWithFrame:CGRectMake(APP_WIDTH / 2 -50, 20, 100, 20)];
            zanwuLabel.textColor = RGB(170, 170, 170);
            zanwuLabel.textAlignment = NSTextAlignmentCenter;
            zanwuLabel.text = @"暂无数据";
            zanwuLabel.font = [UIFont systemFontOfSize:13];
            [cell.contentView addSubview:zanwuLabel];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        } else {
        
            static NSString *CellIdentifier = @"TableViewCell3";
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
            cell.backgroundColor=[UIColor whiteColor];
            NSArray *array=[NSArray arrayWithArray:self.jingjiAry];
            HomePageJingJiView *view=[[HomePageJingJiView alloc] init];
            view.frame=CGRectMake(0,0, APP_WIDTH,  (APP_WIDTH - 40) / 3 * 144 / 235 + 25 - 10);
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
            
            UILabel * zanwuLabel = [[UILabel alloc] initWithFrame:CGRectMake(APP_WIDTH / 2 -50, 20, 100, 20)];
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

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

//有时候tableview的底部视图也会出现此现象对应的修改就好了
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 3 || section == 4 || section == 5) {
        UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 50)];
        header.backgroundColor = [UIColor whiteColor];
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 10)];
        lineView.backgroundColor = [UIColor colorWithRed:250 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:1];
        [header addSubview:lineView];
        
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
        
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.img.frame.origin.x + self.img.frame.size.width + 5, 20, 200, 20)];
        if (section == 3) {
            titleLabel.text = @"作业管理";
        } else if (section == 4) {
            titleLabel.text = @"活动管理";
        } else {
            titleLabel.text = @"学校动态";
        }
        
        titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:17];
        titleLabel.textColor = RGB(51, 51, 51);

        [header addSubview:titleLabel];
        
        if (section != 3) {
            UILabel * moreLabel = [[UILabel alloc] initWithFrame:CGRectMake(APP_WIDTH - 50, 14 + 10, 25, 12)];
            moreLabel.text = @"更多";
            moreLabel.textColor = RGB(170, 170, 170);
            moreLabel.font = [UIFont systemFontOfSize:12];
            [header addSubview:moreLabel];
            
            UIImageView * moreImg = [[UIImageView alloc] initWithFrame:CGRectMake(moreLabel.frame.origin.x + moreLabel.frame.size.width + 4, 14 + 10, 12, 12)];
            moreImg.image = [UIImage imageNamed:@"返回"];
            [header addSubview:moreImg];
            
            UIView * clickView = [[UIView alloc] initWithFrame:CGRectMake(APP_WIDTH - 80, 0, 80, 50)];
            clickView.backgroundColor = [UIColor clearColor];
            [header addSubview:clickView];
            
            UITapGestureRecognizer * headerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerTap:)];
            clickView.userInteractionEnabled = YES;
            clickView.tag = section;
            [clickView addGestureRecognizer:headerTap];
        }
        return header;
    } else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 3 || section == 4 || section == 5) {
        return 50;
    } else {
        return 0;
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

#pragma mark ======= 首页各个点击事件 =======

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            NSLog(@"0");
        }
            break;
        case 1:
        {
            NSLog(@"1");
        }
            break;
        case 2:
        {
            NSLog(@"2");
        }
            break;
        case 3:
        {
            NSLog(@"3");
            if (self.classArr.count != 0) {
                TeacherNotifiedModel *model = self.classArr[indexPath.row];
                NSLog(@"%@",model.name);
                NSLog(@"%@",model.ID);
                HomeWorkViewController *homeWorkVC = [HomeWorkViewController new];
                homeWorkVC.titleStr = model.name;
                homeWorkVC.ID = model.ID;
                [self.navigationController pushViewController:homeWorkVC animated:YES];
            }
           
        }
            break;
        case 4:
        {
            NSLog(@"4");
        }
            break;
        case 5:
        {
            SchoolDongTaiDetailsViewController *schoolDongTaiDetailsVC = [[SchoolDongTaiDetailsViewController alloc] init];
            if (self.dongtaiAry.count != 0) {
                NSDictionary * model = [self.dongtaiAry objectAtIndex:indexPath.row];
                schoolDongTaiDetailsVC.schoolDongTaiId  = [model objectForKey:@"id"];
                [self.navigationController pushViewController:schoolDongTaiDetailsVC animated:YES];

            }
        }
            break;
            
        default:
            break;
    }
}



#pragma mark  - 点击通知图标
- (void)tongzhiTap:(UITapGestureRecognizer *)sender {
    SchoolTongZhiViewController *schoolTongZhiVC = [[SchoolTongZhiViewController alloc] init];
    schoolTongZhiVC.typeStr = @"1";
    [self.navigationController pushViewController:schoolTongZhiVC animated:YES];
}

- (void)headerTap:(UITapGestureRecognizer *)sender {
    if (sender.view.tag == 3) {
        NSLog(@"作业管理");
        
    } else if (sender.view.tag == 4) {
        NSLog(@"活动管理");
        ActivityManagementViewController *activityManagementVC = [ActivityManagementViewController new];
        [self.navigationController pushViewController:activityManagementVC animated:YES];
        
    } else if (sender.view.tag == 5) {
        SchoolDongTaiViewController * schoolDongTaiVC = [[SchoolDongTaiViewController alloc] init];
        [self.navigationController pushViewController:schoolDongTaiVC animated:YES];
    }
}


#pragma mark ======= 五个图标点击事件 =======
- (void)backBtn:(UIButton *)sender {

    switch (sender.tag) {
        case 0:
        {
            OffTheListViewController *offTheListVC = [OffTheListViewController new];
            [self.navigationController pushViewController:offTheListVC animated:YES];
        }
            break;
            case 1:
        {
            NSLog(@"问题咨询");
            ConsultingViewController *consultingVC = [ConsultingViewController new];
            [self.navigationController pushViewController:consultingVC animated:YES];
        }
            break;
        case 2:
        {
            NSLog(@"班级圈子");
            [self getClassURLData2];
        }
            break;
        case 3:
        {
            NSLog(@"老师通知");
            TeacherNotifiedViewController *teacherNotifiedVC = [TeacherNotifiedViewController new];
            [self.navigationController pushViewController:teacherNotifiedVC animated:YES];
        }
            break;
        case 4:
        {
            NSLog(@"新生指南");
//            NewGuidelinesViewController *newGuidelinesVC = [NewGuidelinesViewController new];
//            [self.navigationController pushViewController:newGuidelinesVC animated:YES];
            [self getClassURLData];
            
        }
            break;
            
        default:
            break;
    }
    
}


#pragma mark ======= 获取首页数据 =======

- (void)getTIndexURLData {
    NSDictionary *dic = @{@"key":[UserManager key]};
    [[HttpRequestManager sharedSingleton] POST:indexURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.HomePageJTabelView.mj_header endRefreshing];
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
            if (self.imgArr.count == 0) {
                UIImage *image1 = [UIImage imageNamed:@"banner"];
                UIImage *image2 = [UIImage imageNamed:@"bannerHelper"];
                UIImage *image3 = [UIImage imageNamed:@"教师端活动管理banner"];
                UIImage *image4 = [UIImage imageNamed:@"banner"];
                UIImage *image5 = [UIImage imageNamed:@"请假列表背景图"];
                self.imgArr = [NSMutableArray arrayWithObjects:image1,image2,image3, image4,image5,nil];
            }
            
            self.classArr = [TeacherNotifiedModel mj_objectArrayWithKeyValuesArray:[dataDic objectForKey:@"homework"]];
            self.tongzhiAry = [dataDic objectForKey:@"notice"];
            self.dongtaiAry = [dataDic objectForKey:@"dynamic"];
            self.jingjiAry = [dataDic objectForKey:@"activity"];
            [self.HomePageJTabelView reloadData];
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


#pragma mark ======= 获取个人信息数据 =======
- (void)setUser {
    NSDictionary * dic = @{@"key":[UserManager key]};
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

- (void)getClassURLData {
    [WProgressHUD showHUDShowText:@"正在加载中..."];
    NSDictionary *dic = @{@"key":[UserManager key]};
    [[HttpRequestManager sharedSingleton] POST:getClassURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        [WProgressHUD hideAllHUDAnimated:YES];
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            self.publishJobArr = [PublishJobModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            NSMutableArray *ary = [@[]mutableCopy];
            for (PublishJobModel * model in self.publishJobArr) {
                [ary addObject:[NSString stringWithFormat:@"%@", model.ID]];
            }
            NSMutableArray *ary1 = [@[]mutableCopy];
            for (PublishJobModel * model in self.publishJobArr) {
                [ary1 addObject:[NSString stringWithFormat:@"%@", model.name]];
            }
            if (ary.count == 0 || ary1.count == 0) {
                [WProgressHUD showErrorAnimatedText:@"数据不正确,请重试"];
            } else {
                self.className = ary1[0];
                self.classID = ary[0];
                ClassScheduleViewController *classScheduleVC = [ClassScheduleViewController new];
                classScheduleVC.className = self.className;
                classScheduleVC.classID   = self.classID;
                [self.navigationController pushViewController:classScheduleVC animated:YES];
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

- (void)getClassURLData2 {
    [WProgressHUD showHUDShowText:@"正在加载中..."];
    NSDictionary *dic = @{@"key":[UserManager key]};
    [[HttpRequestManager sharedSingleton] POST:getClassURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        [WProgressHUD hideAllHUDAnimated:YES];
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            self.publishJobArr = [PublishJobModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            NSMutableArray *ary = [@[]mutableCopy];
            for (PublishJobModel * model in self.publishJobArr) {
                [ary addObject:[NSString stringWithFormat:@"%@", model.ID]];
            }
            NSMutableArray *ary1 = [@[]mutableCopy];
            for (PublishJobModel * model in self.publishJobArr) {
                [ary1 addObject:[NSString stringWithFormat:@"%@", model.name]];
            }
            if (ary.count == 0 || ary1.count == 0) {
                [WProgressHUD showErrorAnimatedText:@"数据不正确,请重试"];
            } else {
                self.className = ary1[0];
                self.classID = ary[0];
                NewDynamicsViewController *newDynamicsVC = [NewDynamicsViewController new];
                newDynamicsVC.classID = self.classID;
                newDynamicsVC.className = self.className;
                [self.navigationController pushViewController:newDynamicsVC animated:YES];
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
