//
//  HaveToReplyViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/28.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "HaveToReplyViewController.h"
#import "HaveToReplyCell.h"
#import "ConsultListModel.h"

@interface HaveToReplyViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray         *haveToReplyArr;
@property (nonatomic, strong) UICollectionView       *haveToReplyCollectionView;
@property (nonatomic, assign) NSInteger              page;
@property (nonatomic, strong) UIImageView            *zanwushuju;
@property (nonatomic, strong) PersonInformationModel *personInfo;

@end

@implementation HaveToReplyViewController

- (NSMutableArray *)haveToReplyArr {
    if (!_haveToReplyArr) {
        _haveToReplyArr = [NSMutableArray array];
    }
    return _haveToReplyArr;
}

- (void)viewWillAppear:(BOOL)animated {   //已回复
    [super viewWillAppear:animated];
    self.page = 1;
    //下拉刷新
    self.haveToReplyCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    //自动更改透明度
    self.haveToReplyCollectionView.mj_header.automaticallyChangeAlpha = YES;
    //进入刷新状态
    [self.haveToReplyCollectionView.mj_header beginRefreshing];
    //上拉刷新
    self.haveToReplyCollectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeHaveToReplyViewControllerUI];
    self.zanwushuju = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 105 / 2, 200, 105, 111)];
    self.zanwushuju.image = [UIImage imageNamed:@"暂无数据家长端"];
    self.zanwushuju.alpha = 0;
    [self.haveToReplyCollectionView addSubview:self.zanwushuju];
}

- (void)loadNewTopic {
    self.page = 1;
    [self.haveToReplyArr removeAllObjects];
    [self getConsultListURLData:self.page];
}

- (void)loadMoreTopic {
    self.page += 1;
    [self getConsultListURLData:self.page];
}

- (void)getConsultListURLData:(NSInteger)page {
    
    NSDictionary * dic = @{@"key":[UserManager key], @"status":@1,@"page":[NSString stringWithFormat:@"%ld",page]};
    [[HttpRequestManager sharedSingleton] POST:ConsultConsultList parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        //结束头部刷新
        [self.haveToReplyCollectionView.mj_header endRefreshing];
        //结束尾部刷新
        [self.haveToReplyCollectionView.mj_footer endRefreshing];
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            NSMutableArray *arr = [ConsultListModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            for (ConsultListModel * model in arr) {
                [self.haveToReplyArr addObject:model];
            }
            
            if (self.haveToReplyArr.count == 0) {
                self.zanwushuju.alpha = 1;
            } else {
                self.zanwushuju.alpha = 0;
                [self.haveToReplyCollectionView reloadData];
            }
            
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

- (void)makeHaveToReplyViewControllerUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(10, 0, 0, 0);
    self.haveToReplyCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_NAVH - 40) collectionViewLayout:layout];
    self.haveToReplyCollectionView.backgroundColor = backColor;
    self.haveToReplyCollectionView.delegate = self;
    self.haveToReplyCollectionView.dataSource = self;
    [self.view addSubview:self.haveToReplyCollectionView];
    [self.haveToReplyCollectionView registerClass:[HaveToReplyCell class] forCellWithReuseIdentifier:HaveToReplyCell_CollectionView];
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.haveToReplyArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *gridcell = nil;
    HaveToReplyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HaveToReplyCell_CollectionView forIndexPath:indexPath];
    if (self.haveToReplyArr.count != 0) {
        ConsultListModel *model = [self.haveToReplyArr objectAtIndex:indexPath.row];
        if ([model.s_headimg isEqualToString:@""]) {
            
            cell.headImgView.image = [UIImage imageNamed:@"user"];
            
        } else {
            [cell.headImgView sd_setImageWithURL:[NSURL URLWithString:model.s_headimg] placeholderImage:[UIImage imageNamed:@"user"]];
        }
        
        cell.problemLabel.text = [NSString stringWithFormat:@"%@%@问:", model.class_name ,model.student_name];
        cell.problemContentLabel.text = model.question;
        cell.problemContentLabel.isTop = YES;
        if (model.t_headimg == nil) {
            if ([self.personInfo.head_img isEqualToString:@""]) {
                cell.headImageView.image = [UIImage imageNamed:@"user"];
            } else {
                [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:self.personInfo.head_img] placeholderImage:[UIImage imageNamed:@"user"]];
            }
        } else {
            [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:model.t_headimg] placeholderImage:[UIImage imageNamed:@"user"]];
        }
        
        cell.replyLabel.text = [NSString stringWithFormat:@"%@%@老师%@回复:", model.class_name, model.course_name, model.teacher_name];
        cell.replyContentLabel.text = model.answer;
        cell.replyContentLabel.isTop = YES;
        gridcell = cell;
    }
    return gridcell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize itemSize = CGSizeZero;
    itemSize = CGSizeMake(APP_WIDTH, APP_HEIGHT * 0.3 + 70);
    return itemSize;
}


//点击响应方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%ld",indexPath.row);
    
}


@end
