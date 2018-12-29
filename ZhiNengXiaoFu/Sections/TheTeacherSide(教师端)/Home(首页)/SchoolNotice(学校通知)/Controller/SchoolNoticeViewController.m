//
//  SchoolNoticeViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/26.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "SchoolNoticeViewController.h"
#import "ClassDetailsCell.h"
#import "SchoolDynamicModel.h"
#import "TongZhiDetailsViewController.h"

@interface SchoolNoticeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, assign) NSInteger        page;
@property (nonatomic, strong) UIImageView      *zanwushuju;
@property (nonatomic, strong) NSMutableArray   *schoolNoticeArr;
@property (nonatomic, strong) UICollectionView *schoolNoticeCollectionView;
@property (nonatomic, strong) UIImageView      *headImgView;
@property (nonatomic, strong) NSMutableArray   *bannerArr;

@end

@implementation SchoolNoticeViewController

- (NSMutableArray *)schoolNoticeArr {
    if (!_schoolNoticeArr) {
        _schoolNoticeArr = [NSMutableArray array];
    }
    return _schoolNoticeArr;
}

- (NSMutableArray *)bannerArr {
    if (!_bannerArr) {
        _bannerArr = [NSMutableArray array];
    }
    return _bannerArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"学校通知";
    self.page  = 1;
    [self mkeSchoolNoticeViewControllerUI];
    //下拉刷新
    self.schoolNoticeCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    //自动更改透明度
    self.schoolNoticeCollectionView.mj_header.automaticallyChangeAlpha = YES;
    //进入刷新状态
    [self.schoolNoticeCollectionView.mj_header beginRefreshing];
    //上拉刷新
    self.schoolNoticeCollectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
    self.zanwushuju = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 105 / 2, 200, 105, 111)];
    self.zanwushuju.image = [UIImage imageNamed:@"暂无数据家长端"];
    self.zanwushuju.alpha = 0;
    [self.schoolNoticeCollectionView addSubview:self.zanwushuju];
    [self getBannersURLData];
}

- (void)loadNewTopic {
    self.page = 1;
    [self.schoolNoticeArr removeAllObjects];
    [self getNoticeListData:self.page];
}

- (void)loadMoreTopic {
    self.page += 1;
    [self getNoticeListData:self.page];
}

- (void)getBannersURLData {
    NSDictionary *dic = @{@"key":[UserManager key],@"t_id":@"5"};
    [[HttpRequestManager sharedSingleton] POST:bannersURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            
            self.bannerArr = [BannerModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            
            if (self.bannerArr.count == 0) {
                self.headImgView.image = [UIImage imageNamed:@"教师端活动管理banner"];
            } else {
                BannerModel *model = [self.bannerArr objectAtIndex:0];
                [self.headImgView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"教师端活动管理banner"]];
                [self.schoolNoticeCollectionView reloadData];
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


- (void)getNoticeListData:(NSInteger)page {
    NSDictionary *dic = @{@"key":[UserManager key], @"page":[NSString stringWithFormat:@"%ld",page],@"is_school":@"1"};
    [[HttpRequestManager sharedSingleton] POST:noticeListURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        //结束头部刷新
        [self.schoolNoticeCollectionView.mj_header endRefreshing];
        //结束尾部刷新
        [self.schoolNoticeCollectionView.mj_footer endRefreshing];
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) { 
            
            NSMutableArray *arr = [SchoolDynamicModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            for (SchoolDynamicModel *model in arr) {
                [self.schoolNoticeArr addObject:model];
            }
            if (self.schoolNoticeArr.count == 0) {
                self.zanwushuju.alpha = 1;
            } else {
                self.zanwushuju.alpha = 0;
                [self.schoolNoticeCollectionView reloadData];
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

- (void)mkeSchoolNoticeViewControllerUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(180, 0, 0, 0);
    self.schoolNoticeCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_NAVH) collectionViewLayout:layout];
    self.schoolNoticeCollectionView.backgroundColor = backColor;
    self.schoolNoticeCollectionView.delegate = self;
    self.schoolNoticeCollectionView.dataSource = self;
    [self.view addSubview:self.schoolNoticeCollectionView];
    [self.schoolNoticeCollectionView registerClass:[ClassDetailsCell class] forCellWithReuseIdentifier:ClassDetailsCell_CollectionView];
    self.headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 170)];
    self.headImgView.backgroundColor = [UIColor clearColor];
    [self.schoolNoticeCollectionView addSubview:self.headImgView];
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.schoolNoticeArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = nil;
    if (self.schoolNoticeArr.count != 0) {
        SchoolDynamicModel *model = [self.schoolNoticeArr objectAtIndex:indexPath.row];
        ClassDetailsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ClassDetailsCell_CollectionView forIndexPath:indexPath];
        [cell.headImgView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"通知图标"]];
        //[UIImage imageNamed:@"通知图标"];
        cell.titleLabel.text = model.title;
        //    cell.subjectsLabel.text = model.abstract;
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
    if (self.schoolNoticeArr.count != 0) {
        SchoolDynamicModel *model = [self.schoolNoticeArr objectAtIndex:indexPath.row];
        TongZhiDetailsViewController *tongZhiDetailsVC = [[TongZhiDetailsViewController alloc] init];
        if (model.ID == nil) {
            [WProgressHUD showErrorAnimatedText:@"数据不正确,请重试"];
        } else {
            tongZhiDetailsVC.tongZhiId = model.ID;
            [self.navigationController pushViewController:tongZhiDetailsVC animated:YES];
        }
    }
}




@end
