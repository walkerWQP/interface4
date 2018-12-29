//
//  JobManagementViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/26.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "JobManagementViewController.h"
#import "TeacherNotifiedCell.h"
#import "HomeWorkViewController.h"
#import "TeacherNotifiedModel.h"

@interface JobManagementViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIImageView    *zanwushuju;
@property (nonatomic, strong) NSMutableArray *bannerArr;

@end

@implementation JobManagementViewController

- (NSMutableArray *)bannerArr {
    if (!_bannerArr) {
        _bannerArr = [NSMutableArray array];
    }
    return _bannerArr;
}

- (NSMutableArray *)jobManagementArr {
    if (!_jobManagementArr) {
        _jobManagementArr = [NSMutableArray array];
    }
    return _jobManagementArr;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)loadNewTopic {
    [self.jobManagementArr removeAllObjects];
    [self.bannerArr removeAllObjects];
    [self getBannersURLData];
    [self getClassData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"作业管理";
    self.zanwushuju = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 105 / 2, 200, 105, 111)];
    self.zanwushuju.image = [UIImage imageNamed:@"暂无数据家长端"];
    self.zanwushuju.alpha = 0;
    [self.view addSubview:self.zanwushuju];
    [self makeJobManagementViewControllerUI];
    //下拉刷新
    self.jobManagementCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    //自动更改透明度
    self.jobManagementCollectionView.mj_header.automaticallyChangeAlpha = YES;
    //进入刷新状态
    [self.jobManagementCollectionView.mj_header beginRefreshing];
}

- (void)getClassData {
    NSDictionary *dic = @{@"key":[UserManager key]};
    [[HttpRequestManager sharedSingleton] POST:getClassURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        //结束头部刷新
        [self.jobManagementCollectionView.mj_header endRefreshing];
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            
            self.jobManagementArr = [TeacherNotifiedModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            if (self.jobManagementArr.count == 0) {
                self.zanwushuju.alpha = 1;
            } else {
                self.zanwushuju.alpha = 0;
                [self.jobManagementCollectionView reloadData];
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

- (void)getBannersURLData {
    NSDictionary *dic = @{@"key":[UserManager key],@"t_id":@"2"};
    [[HttpRequestManager sharedSingleton] POST:bannersURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        //结束头部刷新
        [self.jobManagementCollectionView.mj_header endRefreshing];
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            
            self.bannerArr = [BannerModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            if (self.bannerArr.count == 0) {
                self.headImgView.image = [UIImage imageNamed:@"教师端活动管理banner"];
            } else {
                BannerModel * model = [self.bannerArr objectAtIndex:0];
                [self.headImgView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"教师端活动管理banner"]];
                [self.jobManagementCollectionView reloadData];
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


- (void)makeJobManagementViewControllerUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(180, 0, 0, 0);
    self.jobManagementCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT) collectionViewLayout:layout];
    self.jobManagementCollectionView.backgroundColor = backColor;
    self.jobManagementCollectionView.delegate = self;
    self.jobManagementCollectionView.dataSource = self;
    [self.view addSubview:self.jobManagementCollectionView];
    [self.jobManagementCollectionView registerClass:[TeacherNotifiedCell class] forCellWithReuseIdentifier:TeacherNotifiedCell_CollectionView];
    self.headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 170)];
    self.headImgView.backgroundColor = [UIColor clearColor];
    [self.jobManagementCollectionView addSubview:self.headImgView];
    self.headImgView.image = [UIImage imageNamed:@"教师端活动管理banner"];
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.jobManagementArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = nil;
    TeacherNotifiedCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TeacherNotifiedCell_CollectionView forIndexPath:indexPath];
    if (self.jobManagementArr.count != 0) {
        TeacherNotifiedModel *model = [self.jobManagementArr objectAtIndex:indexPath.row];
        [cell.headImgView sd_setImageWithURL:[NSURL URLWithString:model.head_img] placeholderImage:nil];
        cell.classLabel.text = model.name;
        gridcell = cell;
    }
    return gridcell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize itemSize = CGSizeZero;
    itemSize = CGSizeMake(APP_WIDTH, 70);
    return itemSize;
}


//点击响应方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.jobManagementArr.count != 0) {
        TeacherNotifiedModel *model = [self.jobManagementArr objectAtIndex:indexPath.row];
        HomeWorkViewController *homeWorkVC = [[HomeWorkViewController alloc] init];
        if (model.ID == nil || model.name == nil) {
            [WProgressHUD showErrorAnimatedText:@"数据不正确,请重试"];
        } else {
            homeWorkVC.titleStr = model.name;
            homeWorkVC.ID       = model.ID;
            [self.navigationController pushViewController:homeWorkVC animated:YES];
        }
    }
}


@end
