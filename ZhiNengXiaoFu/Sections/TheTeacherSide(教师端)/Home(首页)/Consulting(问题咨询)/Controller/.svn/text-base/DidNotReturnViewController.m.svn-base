//
//  DidNotReturnViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/28.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "DidNotReturnViewController.h"
#import "DidNotReturnCell.h"
#import "ConsultListModel.h"
#import "ReplyViewController.h"


@interface DidNotReturnViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray         *didNotReturnArr;
@property (nonatomic, strong) UICollectionView       *didNotReturnCollectionView;
@property (nonatomic, assign) NSInteger              page;
@property (nonatomic, strong) UIImageView            *zanwushuju;
@property (nonatomic, strong) PersonInformationModel *personInfo;
@property (nonatomic, assign) NSInteger              typeID;


@end

@implementation DidNotReturnViewController

- (NSMutableArray *)didNotReturnArr {
    if (!_didNotReturnArr) {
        _didNotReturnArr = [NSMutableArray array];
    }
    return _didNotReturnArr;
}

- (void)viewWillAppear:(BOOL)animated {   //未回复
    [super viewWillAppear:animated];
    self.page = 1;
    //下拉刷新
    self.didNotReturnCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    //自动更改透明度
    self.didNotReturnCollectionView.mj_header.automaticallyChangeAlpha = YES;
    //进入刷新状态
    [self.didNotReturnCollectionView.mj_header beginRefreshing];
    //上拉刷新
    self.didNotReturnCollectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeDidNotReturnViewControllerUI];
    self.zanwushuju = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 105 / 2, 200, 105, 111)];
    self.zanwushuju.image = [UIImage imageNamed:@"暂无数据家长端"];
    self.zanwushuju.alpha = 0;
    [self.didNotReturnCollectionView addSubview:self.zanwushuju];
}

- (void)loadNewTopic {
    self.page = 1;
    [self.didNotReturnArr removeAllObjects];
    [self getConsultConsultListURLData:self.page];
}

- (void)loadMoreTopic {
    self.page += 1;
    [self getConsultConsultListURLData:self.page];
}

- (void)getConsultConsultListURLData :(NSInteger )page {
    NSDictionary * dic = @{@"key":[UserManager key], @"status":@0,@"page":[NSString stringWithFormat:@"%ld",page]};
    [[HttpRequestManager sharedSingleton] POST:ConsultConsultList parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        //结束头部刷新
        [self.didNotReturnCollectionView.mj_header endRefreshing];
        //结束尾部刷新
        [self.didNotReturnCollectionView.mj_footer endRefreshing];
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            NSMutableArray *arr = [ConsultListModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            for (ConsultListModel * model in arr) {
                [self.didNotReturnArr addObject:model];
            }
            if (self.didNotReturnArr.count == 0) {
                [self.didNotReturnArr removeAllObjects];
                self.zanwushuju.alpha = 1;
                [self.didNotReturnCollectionView reloadData];
            } else {
                self.zanwushuju.alpha = 0;
                [self.didNotReturnCollectionView reloadData];
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

- (void)makeDidNotReturnViewControllerUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(10, 0, 0, 0);
    self.didNotReturnCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_NAVH - 40) collectionViewLayout:layout];
    self.didNotReturnCollectionView.backgroundColor = backColor;
    self.didNotReturnCollectionView.delegate = self;
    self.didNotReturnCollectionView.dataSource = self;
    [self.view addSubview:self.didNotReturnCollectionView];
    [self.didNotReturnCollectionView registerClass:[DidNotReturnCell class] forCellWithReuseIdentifier:DidNotReturnCell_CollectionView];
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.didNotReturnArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *gridcell = nil;
    DidNotReturnCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DidNotReturnCell_CollectionView forIndexPath:indexPath];
    if (self.didNotReturnArr.count != 0) {
        ConsultListModel *model = [self.didNotReturnArr objectAtIndex:indexPath.row];
        
        [cell.headImgView sd_setImageWithURL:[NSURL URLWithString:model.s_headimg] placeholderImage:[UIImage imageNamed:@"user"]];
        if (model.s_headimg == nil) {
            if (self.personInfo.head_img == nil) {
                cell.headImgView.image = [UIImage imageNamed:@"user"];
            } else {
                [cell.headImgView sd_setImageWithURL:[NSURL URLWithString:self.personInfo.head_img] placeholderImage:[UIImage imageNamed:@"user"]];
            }
        }
        
        cell.problemLabel.text = [NSString stringWithFormat:@"%@%@问:", model.class_name ,model.student_name];
        cell.problemContentLabel.text = model.question;
        cell.problemContentLabel.isTop = YES;
        self.typeID = indexPath.row;
        [cell.answerBtn addTarget:self action:@selector(answerBtn:) forControlEvents:UIControlEventTouchUpInside];
        gridcell = cell;
    }
    return gridcell;
}

- (void)answerBtn : (UIButton *)sender {
    NSLog(@"点击回答咨询");
    if (self.didNotReturnArr.count != 0) {
        ConsultListModel *model = [self.didNotReturnArr objectAtIndex:self.typeID];
        ReplyViewController *replyVC = [[ReplyViewController alloc] init];
        if (model.ID == nil) {
            [WProgressHUD showErrorAnimatedText:@"数据不正确,请重试"];
        } else {
            replyVC.ID = model.ID;
            replyVC.headImg = model.s_headimg;
            replyVC.nameStr = [NSString stringWithFormat:@"%@%@问:",model.class_name,model.student_name];
            replyVC.problemStr =  model.question;
            [self.navigationController pushViewController:replyVC animated:YES];
        }
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize itemSize = CGSizeZero;
    itemSize = CGSizeMake(APP_WIDTH, APP_HEIGHT * 0.3 + 30);
    return itemSize;
}


//点击响应方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.didNotReturnArr.count != 0) {
        ConsultListModel *model = [self.didNotReturnArr objectAtIndex:indexPath.row];
        ReplyViewController *replyVC = [[ReplyViewController alloc] init];
        if (model.ID == nil) {
            [WProgressHUD showErrorAnimatedText:@"数据不正确,请重试"];
        } else {
            replyVC.ID = model.ID;
            replyVC.headImg = model.s_headimg;
            replyVC.nameStr = [NSString stringWithFormat:@"%@%@问:",model.class_name,model.student_name];
            replyVC.problemStr =  model.question;
            [self.navigationController pushViewController:replyVC animated:YES];
        }
    }
}


@end
