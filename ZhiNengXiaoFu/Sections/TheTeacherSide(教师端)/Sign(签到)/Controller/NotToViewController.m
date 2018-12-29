//
//  NotToViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/31.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "NotToViewController.h"
#import "TotalNumberCell.h"
#import "QianDaoViewController.h"
#import "TotalNumberModel.h"
#import "LeaveTheDetailsViewController.h"

@interface NotToViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray   *notToArr;
@property (nonatomic, strong) UICollectionView *notToCollectionView;
@property (nonatomic, strong) UIImageView      *zanwushuju;

@end

@implementation NotToViewController

- (NSMutableArray *)notToArr {
    if (!_notToArr) {
        _notToArr = [NSMutableArray array];
    }
    return _notToArr;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //下拉刷新
    self.notToCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    //自动更改透明度
    self.notToCollectionView.mj_header.automaticallyChangeAlpha = YES;
    //进入刷新状态
    [self.notToCollectionView.mj_header beginRefreshing];
}

- (void)loadNewTopic {
    [self.notToArr removeAllObjects];
    [self getClassConditionURLData:@"3"];
}

- (void)viewWillDisappear:(BOOL)animated {
    //结束头部刷新
    [self.notToCollectionView.mj_header endRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 未到
    // 总数
    self.zanwushuju = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 105 / 2, 200, 105, 111)];
    self.zanwushuju.image = [UIImage imageNamed:@"暂无数据家长端"];
    self.zanwushuju.alpha = 0;
    [self.view addSubview:self.zanwushuju];
    [self makeNotToViewControllerUI];
}

- (void)getClassConditionURLData:(NSString *)type {
    
    NSDictionary *dic = @{@"key":[UserManager key],@"class_id":self.ID,@"type":type};
    [[HttpRequestManager sharedSingleton] POST:classConditionURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        //结束头部刷新
        [self.notToCollectionView.mj_header endRefreshing];
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            
            self.notToArr = [TotalNumberModel mj_objectArrayWithKeyValuesArray:[[responseObject objectForKey:@"data"] objectForKey:@"students"]];
            if (self.notToArr.count == 0) {
                self.zanwushuju.alpha = 1;
            } else {
                self.zanwushuju.alpha = 0;
                [self.notToCollectionView reloadData];
            }
            [self.notToCollectionView reloadData];
            
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

- (void)makeNotToViewControllerUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.notToCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_NAVH - APP_TABH - 40) collectionViewLayout:layout];
    self.notToCollectionView.backgroundColor = backColor;
    self.notToCollectionView.delegate = self;
    self.notToCollectionView.dataSource = self;
    [self.view addSubview:self.notToCollectionView];
    [self.notToCollectionView registerClass:[TotalNumberCell class] forCellWithReuseIdentifier:TotalNumberCell_CollectionView];
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.notToArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *gridcell = nil;
    TotalNumberCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TotalNumberCell_CollectionView forIndexPath:indexPath];
    if (self.notToArr.count != 0) {
        TotalNumberModel *model = [self.notToArr objectAtIndex:indexPath.row];
        if (model.head_img == nil || [model.head_img isEqualToString:@""]) {
            cell.headImgView.image = [UIImage imageNamed:@"user"];
        } else {
            [cell.headImgView sd_setImageWithURL:[NSURL URLWithString:model.head_img] placeholderImage:[UIImage imageNamed:@"user"]];
        }
        cell.nameLabel.text = model.name;
        if (model.is_leave == 1) { //1请假
            cell.nameLabel.textColor = RGB(253, 129, 149);
        } else if (model.is_leave == 2) { //2逃学
            cell.nameLabel.textColor = RGB(253, 129, 149);
        } else if (model.is_leave == 3) { //3签到
            cell.nameLabel.textColor = titlColor;
        }
        gridcell = cell;
    }
    return gridcell;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize itemSize = CGSizeZero;
    itemSize = CGSizeMake((APP_WIDTH - 45) / 3, APP_HEIGHT * 0.15);
    return itemSize;
}


//点击响应方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.notToArr.count != 0) {
        TotalNumberModel *model = [self.notToArr objectAtIndex:indexPath.row];
        LeaveTheDetailsViewController *LeaveTheDetailsVC = [[LeaveTheDetailsViewController alloc] init];
        switch (model.is_leave) {
            case 1:
            {
                NSLog(@"请假");
                if (model.ID == nil) {
                    [WProgressHUD showErrorAnimatedText:@"数据不正确,请重试"];
                } else {
                    LeaveTheDetailsVC.typeStr = @"1";
                    LeaveTheDetailsVC.studentID= model.ID;
                    [self.navigationController pushViewController:LeaveTheDetailsVC animated:YES];
                }
            }
                break;
            case 2:
            {
                NSLog(@"逃学");
                QianDaoViewController *qianDaoVC = [QianDaoViewController new];
                qianDaoVC.studentId = model.ID;
                qianDaoVC.typeID    = @"1";
                [self.navigationController pushViewController:qianDaoVC animated:YES];
            }
                break;
            case 3:
            {
                NSLog(@"签到");
                QianDaoViewController *qianDaoVC = [QianDaoViewController new];
                qianDaoVC.studentId = model.ID;
                qianDaoVC.typeID    = @"1";
                [self.navigationController pushViewController:qianDaoVC animated:YES];
            }
                break;
                
            default:
                break;
        }
    } else {
        
    }
}

@end
