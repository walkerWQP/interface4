//
//  SchoolDynamicViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/26.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "SchoolDynamicViewController.h"
#import "SchoolDynamicCellCell.h"
#import "SchoolDynamicModel.h"
#import "SchoolDongTaiDetailsViewController.h"

@interface SchoolDynamicViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *schoolDynamicCollectionView;
@property (nonatomic, strong) NSMutableArray   *schoolDynamicArr;
@property (nonatomic, strong) UIImageView      *headImgView;
@property (nonatomic, assign) NSInteger        page;
@property (nonatomic, strong) UIImageView      *zanwushuju;
@property (nonatomic, strong) NSMutableArray   *bannerArr;

@end

@implementation SchoolDynamicViewController

- (NSMutableArray *)schoolDynamicArr {
    if (!_schoolDynamicArr) {
        _schoolDynamicArr = [NSMutableArray array];
    }
    return _schoolDynamicArr;
}

- (NSMutableArray *)bannerArr {
    if (!_bannerArr) {
        _bannerArr = [NSMutableArray array];
    }
    return _bannerArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"学校动态";
    self.page = 1;
    [self makeSchoolDynamicViewControllerUI];
    //下拉刷新
    self.schoolDynamicCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    //自动更改透明度
    self.schoolDynamicCollectionView.mj_header.automaticallyChangeAlpha = YES;
    //进入刷新状态
    [self.schoolDynamicCollectionView.mj_header beginRefreshing];
    //上拉刷新
    self.schoolDynamicCollectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
    self.zanwushuju = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 105 / 2, 200, 105, 111)];
    self.zanwushuju.image = [UIImage imageNamed:@"暂无数据家长端"];
    self.zanwushuju.alpha = 0;
    [self.schoolDynamicCollectionView addSubview:self.zanwushuju];
    [self getBannersURLData];
}

- (void)loadNewTopic {
    self.page = 1;
    [self.schoolDynamicArr removeAllObjects];
    [self getDynamicGetListData:self.page];
}

- (void)loadMoreTopic {
    self.page += 1;
    [self getDynamicGetListData:self.page];
}

- (void)getBannersURLData {
    NSDictionary *dic = @{@"key":[UserManager key],@"t_id":@"6"};
    [[HttpRequestManager sharedSingleton] POST:bannersURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            self.bannerArr = [BannerModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            
            if (self.bannerArr.count == 0) {
                self.headImgView.image = [UIImage imageNamed:@"教师端活动管理banner"];
            } else {
                BannerModel *model = [self.bannerArr objectAtIndex:0];
                [self.headImgView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"教师端活动管理banner"]];
                [self.schoolDynamicCollectionView reloadData];
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


- (void)getDynamicGetListData:(NSInteger)page {

    NSDictionary *dic = @{@"key":[UserManager key],@"page":[NSString stringWithFormat:@"%ld",page]};
    [[HttpRequestManager sharedSingleton] POST:dynamicGetList parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        //结束头部刷新
        [self.schoolDynamicCollectionView.mj_header endRefreshing];
        //结束尾部刷新
        [self.schoolDynamicCollectionView.mj_footer endRefreshing];
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            NSMutableArray *arr = [SchoolDynamicModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            for (SchoolDynamicModel *model in arr) {
                [self.schoolDynamicArr addObject:model];
            }
            if (self.schoolDynamicArr.count == 0) {
                self.zanwushuju.alpha = 1;
            } else {
                self.zanwushuju.alpha = 0;
                [self.schoolDynamicCollectionView reloadData];
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

- (void)makeSchoolDynamicViewControllerUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(180, 0, 0, 0);
    self.schoolDynamicCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_NAVH) collectionViewLayout:layout];
    self.schoolDynamicCollectionView.backgroundColor = backColor;
    self.schoolDynamicCollectionView.delegate = self;
    self.schoolDynamicCollectionView.dataSource = self;
    [self.view addSubview:self.schoolDynamicCollectionView];
    [self.schoolDynamicCollectionView registerClass:[SchoolDynamicCellCell class] forCellWithReuseIdentifier:SchoolDynamicCellCell_CollectionView];
    self.headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 170)];
    self.headImgView.backgroundColor = [UIColor clearColor];
    [self.schoolDynamicCollectionView addSubview:self.headImgView];
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.schoolDynamicArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = nil;
    SchoolDynamicCellCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SchoolDynamicCellCell_CollectionView forIndexPath:indexPath];
    if (self.schoolDynamicArr.count != 0) {
        SchoolDynamicModel *model = [self.schoolDynamicArr objectAtIndex:indexPath.row];
        [cell.headImgView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"通知图标"]];
        cell.titleLabel.text = model.title;
        cell.timeLabel.text = model.create_time;
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
    if (self.schoolDynamicArr.count != 0) {
        SchoolDynamicModel *model = [self.schoolDynamicArr objectAtIndex:indexPath.row];
        SchoolDongTaiDetailsViewController *schoolDongTaiDetailsVC = [[SchoolDongTaiDetailsViewController alloc] init];
        if (model.ID == nil) {
            [WProgressHUD showErrorAnimatedText:@"数据不正确,请重试"];
        } else {
            schoolDongTaiDetailsVC.schoolDongTaiId = model.ID;
            [self.navigationController pushViewController:schoolDongTaiDetailsVC animated:YES];
        }
    }
}


@end
