//
//  HomeViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/23.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeLunBoCell.h"
#import "HomeItemCell.h"
#import "SchoolDynamicViewController.h"
#import "SchoolNoticeViewController.h"
#import "ConsultingViewController.h"
#import "ActivityManagementViewController.h"
#import "UploadVideoViewController.h"
#import "GrowthAlbumViewController.h"
#import "JobManagementViewController.h"
#import "TeacherNotifiedViewController.h"
#import "TongZhiViewController.h"
#import "PublishJobModel.h"
#import "OffTheListViewController.h"
#import "NewGuidelinesViewController.h"
#import "SleepManagementViewController.h"
#import "HomePageNumberModel.h"
#import "HomePageItemNCell.h"
#import "NewDynamicsViewController.h"


@interface HomeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView           *HomeCollectionView;
@property (nonatomic, retain) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) NSMutableArray             *homePageAry;
@property (nonatomic, strong) NSMutableArray             *publishJobArr;
@property (nonatomic, strong) NSMutableArray             *numberAry;
@property (nonatomic, strong) NSString                   *classID;
@property (nonatomic, strong) NSString                   *className;
@property (nonatomic, strong) NSString                   *schoolName;

@end

@implementation HomeViewController

- (NSMutableArray *)publishJobArr {
    if (!_publishJobArr) {
        _publishJobArr = [NSMutableArray array];
    }
    return _publishJobArr;
}

- (NSMutableArray *)homePageAry {
    if (!_homePageAry) {
        _homePageAry = [NSMutableArray array];
    }
    return _homePageAry;
}

- (NSMutableArray *)numberAry
{
    if (!_numberAry) {
        self.numberAry = [@[]mutableCopy];
    }
    return _numberAry;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUser];
    self.view.backgroundColor = backColor;
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    self.HomeCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_NAVH) collectionViewLayout:self.layout];
    self.HomeCollectionView.backgroundColor = backColor;
    self.HomeCollectionView.delegate = self;
    self.HomeCollectionView.dataSource = self;
    [self.view addSubview:self.HomeCollectionView];
    
    [self.HomeCollectionView registerClass:[HomeLunBoCell class] forCellWithReuseIdentifier:@"HomePageLunBoCellId"];
    
    NSMutableArray * imgAry = [NSMutableArray arrayWithObjects:@"老师通知",@"作业管理",@"成长相册",@"活动管理",@"问题咨询",@"学校通知",@"学校动态1",@"请假列表1",@"新生指南", nil];
    NSMutableArray * TitleAry = [NSMutableArray arrayWithObjects:@"老师通知",@"作业管理",@"班级圈",@"活动管理",@"问题咨询",@"学校通知",@"学校动态",@"请假列表",@"新生指南", nil];
    
    
    for (int i = 0; i < imgAry.count; i++) {
        NSString * img  = [imgAry objectAtIndex:i];
        NSString * title = [TitleAry objectAtIndex:i];
        NSDictionary * dic = @{@"img":img, @"title":title};
        [self.homePageAry addObject:dic];
    }
    
    [self.HomeCollectionView registerNib:[UINib nibWithNibName:@"HomePageItemNCell" bundle:nil] forCellWithReuseIdentifier:@"HomePageItemNCellId"];
    [self pushJiGuangId];
}

- (void)viewWillAppear:(BOOL)animated {
    [self huoQuNumber];
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
        
        [self.HomeCollectionView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
        
    }];
}

- (void)pushJiGuangId {
    
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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return self.homePageAry.count;
    }
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        HomeLunBoCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomePageLunBoCellId" forIndexPath:indexPath];
        return cell;
    } else {
        HomePageItemNCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomePageItemNCellId" forIndexPath:indexPath];
        if (self.homePageAry.count != 0) {
            NSDictionary * dic = [self.homePageAry objectAtIndex:indexPath.row];
            cell.itemImg.image = [UIImage imageNamed:[dic objectForKey:@"img"]];
            cell.titleLabel.text = [dic objectForKey:@"title"];
        }
        
        if (self.numberAry.count > indexPath.row) {
            NSString* str  = [self.numberAry objectAtIndex:indexPath.row];
            if ([str isEqualToString:@"0"]) {
                cell.NumberLabel.alpha = 0;
            } else {
                cell.NumberLabel.alpha = 1;
                cell.NumberLabel.text = str;
            }
        }
        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (APP_WIDTH == 414) {
            return CGSizeMake(APP_WIDTH, 200);
        } else {
            return CGSizeMake(APP_WIDTH, 170);
        }
    } else {
        return CGSizeMake((APP_WIDTH  - 30 )/ 3, 100);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {

    } else {
        
        switch (indexPath.row) {
            case 0:
            {
                NSLog(@"点击老师通知");
                TeacherNotifiedViewController *teacherNotifiedVC = [[TeacherNotifiedViewController alloc] init];
                [self.navigationController pushViewController:teacherNotifiedVC animated:YES];
            }
                break;
            case 1:
            {
                NSLog(@"点击作业管理");
                JobManagementViewController *jobManagementVC = [[JobManagementViewController alloc] init];
                [self.navigationController pushViewController:jobManagementVC animated:YES];
            }
                break;

            case 2:
            {
                NSLog(@"点击成长轨迹");
                [self getClassURLData2];
                
            }
                break;

            case 3:
            {
                NSLog(@"点击活动管理");
                ActivityManagementViewController *activityManagementVC = [[ActivityManagementViewController alloc] init];
                [self.navigationController pushViewController:activityManagementVC animated:YES];
            }
                break;
            case 4:
            {
                NSLog(@"点击问题咨询");
                ConsultingViewController *consultingVC = [[ConsultingViewController alloc] init];
                [self.navigationController pushViewController:consultingVC animated:YES];
            }
                break;
            case 5:
            {
                NSLog(@"点击学校通知");
                SchoolNoticeViewController *schoolNoticeVC = [[SchoolNoticeViewController alloc] init];
                [self.navigationController pushViewController:schoolNoticeVC animated:YES];
            }
                break;
            case 6:
            {
                NSLog(@"点击学校动态");
                SchoolDynamicViewController *schoolDynamicVC = [[SchoolDynamicViewController alloc] init];
                [self.navigationController pushViewController:schoolDynamicVC animated:YES];
            }
                break;
            case 7:
            {
                NSLog(@"点击请假列表");
                OffTheListViewController *offTheListVC = [OffTheListViewController new];
                [self.navigationController pushViewController:offTheListVC animated:YES];
            }
                break;
                
            case 8:
            {
                NSLog(@"点击新生指南");
                NewGuidelinesViewController *newGuidelinesVC = [NewGuidelinesViewController new];
                [self.navigationController pushViewController:newGuidelinesVC animated:YES];
            }
                break;

            default:
                break;
        }
    }
}

- (void)postDataForGetURL:(NSString *)classID {
    NSDictionary *dic = @{@"key":[UserManager key],@"class_id":classID};
    [[HttpRequestManager sharedSingleton] POST:getURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            NSString *url = [[responseObject objectForKey:@"data"] objectForKey:@"url"];
            GrowthAlbumViewController *growthAlbumVC = [[GrowthAlbumViewController alloc] init];
            if (url == nil) {
                [WProgressHUD showErrorAnimatedText:@"数据不正确,请重试"];
            } else {
                growthAlbumVC.urlStr = url;
                growthAlbumVC.webTitle = @"成长相册";
                [self.navigationController pushViewController:growthAlbumVC animated:YES];
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
    [WProgressHUD showHUDShowText:@"正在加载中..."];
    NSDictionary *dic = @{@"key":[UserManager key]};
    [[HttpRequestManager sharedSingleton] POST:getClassURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        [WProgressHUD hideAllHUDAnimated:YES];
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            self.publishJobArr = [PublishJobModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            NSMutableArray * ary = [@[]mutableCopy];
            for (PublishJobModel * model in self.publishJobArr) {
                [ary addObject:[NSString stringWithFormat:@"%@", model.ID]];
            }
            
            if (ary.count == 0) {
                [WProgressHUD showErrorAnimatedText:@"数据不正确,请重试"];
            } else {
                [self postDataForGetURL:ary[0]];
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


#pragma mark ======= 获取个人信息数据 =======
- (void)setUser {
    NSDictionary * dic = @{@"key":[UserManager key]};
    [[HttpRequestManager sharedSingleton] POST:getUserInfoURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            
            self.schoolName = [[responseObject objectForKey:@"data"] objectForKey:@"school_name"];
            UILabel  *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 200, 44)];
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.font = [UIFont boldSystemFontOfSize:18];
            titleLabel.textColor = [UIColor whiteColor];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.text = self.schoolName; self.navigationItem.titleView = titleLabel;
            
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


@end
