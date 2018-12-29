//
//  HomeWorkPViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/25.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "HomeWorkPViewController.h"
#import "TongZhiCell.h"
#import "WorkModel.h"
#import "WorkDetailsViewController.h"
#import "WorkNewCell.h"
#import "WorkNewTwoCell.h"
#import "YYCollectionViewLayout.h"

@interface HomeWorkPViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, YYCollectionViewLayoutDelegate>

@property (nonatomic, strong) UICollectionView      *HomeWorkPTableView;
@property(nonatomic, strong) YYCollectionViewLayout *layout;
@property (nonatomic, strong) NSMutableArray        *HomeWorkPAry;
@property (nonatomic, assign) NSInteger             page;
@property (nonatomic, strong) NSMutableArray        *bannerArr;
@property (nonatomic, strong) UIImageView           *zanwushuju;
@property(nonatomic,strong)NSMutableArray           *itemHeights;

@end

@implementation HomeWorkPViewController

- (NSMutableArray *)bannerArr {
    if (!_bannerArr) {
        _bannerArr = [NSMutableArray array];
    }
    return _bannerArr;
}

- (NSMutableArray *)itemHeights {
    if (!_itemHeights) {
        self.itemHeights = [@[] mutableCopy];
    }
    return _itemHeights;
}

- (NSMutableArray *)HomeWorkPAry {
    if (!_HomeWorkPAry) {
        self.HomeWorkPAry = [@[]mutableCopy];
    }
    return _HomeWorkPAry;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backColor;
    self.title = @"作业";
    self.page = 1;
    _layout=[[YYCollectionViewLayout alloc]init];
    _layout.delegate=self;
    self.HomeWorkPTableView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_TABH - 18) collectionViewLayout:self.layout];
    self.HomeWorkPTableView.backgroundColor = backColor;
    self.HomeWorkPTableView.delegate = self;
    self.HomeWorkPTableView.dataSource = self;
    [self.view addSubview:self.HomeWorkPTableView];
    [self.HomeWorkPTableView registerNib:[UINib nibWithNibName:@"WorkNewCell" bundle:nil] forCellWithReuseIdentifier:@"WorkNewCellId"];
    [self.HomeWorkPTableView registerNib:[UINib nibWithNibName:@"WorkNewTwoCell" bundle:nil] forCellWithReuseIdentifier:@"WorkNewTwoCellId"];
    
    //下拉刷新
    self.HomeWorkPTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    //自动更改透明度
    self.HomeWorkPTableView.mj_header.automaticallyChangeAlpha = YES;
    //进入刷新状态
    [self.HomeWorkPTableView.mj_header beginRefreshing];
    //上拉刷新
    self.HomeWorkPTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
    
    self.zanwushuju = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 105 / 2, 200, 105, 111)];
    self.zanwushuju.image = [UIImage imageNamed:@"暂无数据家长端"];
    self.zanwushuju.alpha = 0;
    [self.HomeWorkPTableView addSubview:self.zanwushuju];
    [self getBannersURLData];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:18],NSForegroundColorAttributeName:[UIColor blackColor]}];

}

- (void)loadNewTopic {
    self.page = 1;
    [self.HomeWorkPAry removeAllObjects];
    [self.itemHeights removeAllObjects];
    [self setNetWork:self.page];
}

- (void)loadMoreTopic {
    self.page += 1;
    [self setNetWork:self.page];
}


- (void)getBannersURLData {
    NSDictionary *dic = @{@"key":[UserManager key],@"t_id":@"4"};
    [[HttpRequestManager sharedSingleton] POST:bannersURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            self.bannerArr = [BannerModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            [self.HomeWorkPTableView reloadData];
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


- (void)setNetWork:(NSInteger)page {
    
    NSDictionary * dic = @{@"key":[UserManager key],@"page":[NSString stringWithFormat:@"%ld",page]};
    [[HttpRequestManager sharedSingleton] POST:workGetHomeWork parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        //结束头部刷新
        [self.HomeWorkPTableView.mj_header endRefreshing];
        //结束尾部刷新
        [self.HomeWorkPTableView.mj_footer endRefreshing];
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            NSMutableArray * arr = [WorkModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            
            for (WorkModel *model in arr) {
                [self.HomeWorkPAry addObject:model];
            }
            
            if (self.HomeWorkPAry.count == 0) {
                self.zanwushuju.alpha = 1;
            } else {
                self.zanwushuju.alpha = 0;
            }
            
            for (int i = 0; i < arr.count; i++) {
                WorkModel * model = [arr objectAtIndex:i];
                if ([model.img isEqualToString:@""]) {
                     [self.itemHeights addObject:@(109)];
                } else {
                     [self.itemHeights addObject:@(52 + (kScreenWidth - 30) / 2 + 10)];
                }
            }
            [self.HomeWorkPTableView reloadData];
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


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.HomeWorkPAry.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.HomeWorkPAry.count != 0) {
        WorkModel * model = [self.HomeWorkPAry objectAtIndex:indexPath.row];
        if ([model.img isEqualToString:@""]) {
            WorkNewTwoCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"WorkNewTwoCellId" forIndexPath:indexPath];
            cell.WorkNewTwoTitleLabel.text = model.content;
            [cell.WorkNewTwoIconImg sd_setImageWithURL:[NSURL URLWithString:model.head_img] placeholderImage:[UIImage imageNamed:@"user"]];
            cell.WorkNewTwoTimeLabel.text = model.create_time;
            cell.WorkNewTwoFenLeiLabel.text = model.course_name;
            cell.WorkNewTwoNameLabel.text = model.teacher_name;
            return cell;
        } else {
            WorkNewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"WorkNewCellId" forIndexPath:indexPath];
            [cell.WorkNewImg sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
            [cell.WorkNewIconImg sd_setImageWithURL:[NSURL URLWithString:model.head_img] placeholderImage:[UIImage imageNamed:@"user"]];
            cell.WorkNewTimeLabel.text = model.create_time;
            cell.WorkNewFenLeiLabel.text = model.course_name;
            cell.WorkNewTacherLabel.text = model.teacher_name;
            return cell;
        }
    } else {
        return nil;
    }
}


-(CGSize)YYCollectionViewLayoutForCollectionView:(UICollectionView *)collection withLayout:(YYCollectionViewLayout *)layout atIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(ITEM_WIDTH,[_itemHeights[indexPath.row] floatValue]);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    WorkDetailsViewController * workDetailsVC = [[WorkDetailsViewController alloc] init];
    if (self.HomeWorkPAry.count != 0) {
        WorkModel *model = [self.HomeWorkPAry objectAtIndex:indexPath.row];
        workDetailsVC.workId = model.ID;
    }
    [self.navigationController pushViewController:workDetailsVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
