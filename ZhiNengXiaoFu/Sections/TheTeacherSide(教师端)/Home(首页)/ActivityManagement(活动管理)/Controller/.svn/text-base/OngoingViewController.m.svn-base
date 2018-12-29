//
//  OngoingViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/28.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "OngoingViewController.h"
#import "OngoingCell.h"
#import "OngoingModel.h"
#import "JingJiActivityDetailsViewController.h"


@interface OngoingViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray   *ongoingArr;
@property (nonatomic, strong) UICollectionView *ongoingCollectionView;
@property (nonatomic, assign) NSInteger        page;
@property (nonatomic, strong) UIImageView      *zanwushuju;

@end

@implementation OngoingViewController

- (NSMutableArray *)ongoingArr {
    if (!_ongoingArr) {
        _ongoingArr = [NSMutableArray array];
    }
    return _ongoingArr;
}

- (void)viewWillAppear:(BOOL)animated {  //正在进行中
    [super viewWillAppear:animated];
    self.page = 1;
    [self makeOngoingViewControllerUI];
    //下拉刷新
    self.ongoingCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    //自动更改透明度
    self.ongoingCollectionView.mj_header.automaticallyChangeAlpha = YES;
    //进入刷新状态
    [self.ongoingCollectionView.mj_header beginRefreshing];
    //上拉刷新
    self.ongoingCollectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
    self.zanwushuju = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 105 / 2, 200, 105, 111)];
    self.zanwushuju.image = [UIImage imageNamed:@"暂无数据家长端"];
    self.zanwushuju.alpha = 0;
    [self.ongoingCollectionView addSubview:self.zanwushuju];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)loadNewTopic {
    self.page = 1;
    [self.ongoingArr removeAllObjects];
    [self getActivityActivityListData:self.page];
}

- (void)loadMoreTopic {
    self.page += 1;
    [self getActivityActivityListData:self.page];
}


-  (void)getActivityActivityListData:(NSInteger)page  {
    
    NSDictionary *dic = @{@"key":[UserManager key],@"status":@"1",@"page":[NSString stringWithFormat:@"%ld",page]};
    [[HttpRequestManager sharedSingleton] POST:activityActivityList parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        //结束头部刷新
        [self.ongoingCollectionView.mj_header endRefreshing];
        //结束尾部刷新
        [self.ongoingCollectionView.mj_footer endRefreshing];
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            NSMutableArray *arr = [OngoingModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            for (OngoingModel *model in arr) {
                [self.ongoingArr addObject:model];
            }
            if (self.ongoingArr.count == 0) {
                self.zanwushuju.alpha = 1;
                
            } else {
                self.zanwushuju.alpha = 0;
                [self.ongoingCollectionView reloadData];
            }
            
        } else {

            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];

            }else {
                
            }
            [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
        }
        [self.ongoingCollectionView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}

- (void)makeOngoingViewControllerUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(10, 0, 0, 0);
    self.ongoingCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_NAVH - 40) collectionViewLayout:layout];
    self.ongoingCollectionView.backgroundColor = backColor;
    self.ongoingCollectionView.delegate = self;
    self.ongoingCollectionView.dataSource = self;
    [self.view addSubview:self.ongoingCollectionView];
    [self.ongoingCollectionView registerClass:[OngoingCell class] forCellWithReuseIdentifier:OngoingCell_CollectionView];
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.ongoingArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *gridcell = nil;
    OngoingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:OngoingCell_CollectionView forIndexPath:indexPath];
    if (self.ongoingArr.count != 0) {
        OngoingModel *model = [self.ongoingArr objectAtIndex:indexPath.row];
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
        cell.titleLabel.text = model.title;
        cell.timeLabel.text = [NSString stringWithFormat:@"活动日期:%@ 至 %@", model.start, model.end];;
        cell.detailsLabel.text = model.title;
        gridcell = cell;
    }
    return gridcell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize itemSize = CGSizeZero;
    itemSize = CGSizeMake(APP_WIDTH, 200);
    return itemSize;
}


//点击响应方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.ongoingArr.count != 0) {
        OngoingModel *model = [self.ongoingArr objectAtIndex:indexPath.row];
        JingJiActivityDetailsViewController *jingJiActivityDetailsVC = [JingJiActivityDetailsViewController new];
        if (model.ID == nil) {
            [WProgressHUD showSuccessfulAnimatedText:@"数据不正确,请重试"];
        } else {
            jingJiActivityDetailsVC.JingJiActivityDetailsId = model.ID;
            [self.navigationController pushViewController:jingJiActivityDetailsVC animated:YES];
        }
    }
}


@end
