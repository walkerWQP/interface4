//
//  ClassHomeViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/20.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "ClassHomeViewController.h"
#import "TeacherNotifiedCell.h"
#import "TheClassInformationViewController.h"
#import "ClassHomeModel.h"

@interface ClassHomeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray   *classArr;
@property (nonatomic, strong) UICollectionView *classCollectionView;
@property (nonatomic, strong) UIImageView      *headImgView;
@property (nonatomic, strong) NSMutableArray   *bannerArr;

@end

@implementation ClassHomeViewController

- (NSMutableArray *)bannerArr {
    if (!_bannerArr) {
        _bannerArr = [NSMutableArray array];
    }
    return _bannerArr;
}

- (NSMutableArray *)classArr {
    if (!_classArr) {
        self.classArr = [@[]mutableCopy];
    }
    return _classArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backColor;
    self.title = @"班级信息";
    [self setNetWork];
    [self getBannersURLData];
    [self makeClassViewControllerUI];
}

- (void)setNetWork {
    NSDictionary *dic = @{@"key":[UserManager key]};
    [[HttpRequestManager sharedSingleton] POST:userClassInfo parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            ClassHomeModel * model = [ClassHomeModel mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
            NSMutableArray *imgArr = [NSMutableArray arrayWithObjects:model.class_head_img, nil];
            NSMutableArray *titleArr = [NSMutableArray arrayWithObjects:model.class_name, nil];
            
            for (int i = 0; i < imgArr.count; i++) {
                NSString *img     = [imgArr objectAtIndex:i];
                NSString *title   = [titleArr objectAtIndex:i];
                NSDictionary *dic = @{@"img":img,@"title":title};
                [self.classArr addObject:dic];
            }
            
        } else {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
            } else {
                
            }
            [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
        }
        [self.classCollectionView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}



- (void)makeClassViewControllerUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(190, 0, 0, 0);
    self.classCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT) collectionViewLayout:layout];
    self.classCollectionView.backgroundColor = backColor;
    self.classCollectionView.delegate = self;
    self.classCollectionView.dataSource = self;
    [self.view addSubview:self.classCollectionView];
    [self.classCollectionView registerClass:[TeacherNotifiedCell class] forCellWithReuseIdentifier:TeacherNotifiedCell_CollectionView];
    
    self.headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 170)];
    self.headImgView.backgroundColor = [UIColor clearColor];
    [self.classCollectionView addSubview:self.headImgView];
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.classArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *gridcell = nil;
    TeacherNotifiedCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TeacherNotifiedCell_CollectionView forIndexPath:indexPath];
    if (self.classArr.count != 0) {
        NSDictionary *dic = [self.classArr objectAtIndex:indexPath.row];
        [cell.headImgView sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"img"]] placeholderImage:[UIImage imageNamed:@"user"]];
        cell.classLabel.text = [dic objectForKey:@"title"];
    }
   
    gridcell = cell;
    return gridcell;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 20;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize itemSize = CGSizeZero;
    itemSize = CGSizeMake(APP_WIDTH, 70);
    return itemSize;
}

- (void)getBannersURLData {
    NSDictionary *dic = @{@"key":[UserManager key],@"t_id":@"2"};
    [[HttpRequestManager sharedSingleton] POST:bannersURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            self.bannerArr = [BannerModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            if (self.bannerArr.count == 0) {
                self.headImgView.image = [UIImage imageNamed:@"教师端活动管理banner"];
            } else {
                BannerModel *model = [self.bannerArr objectAtIndex:0];
                [self.headImgView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"教师端活动管理banner"]];
                [self.classCollectionView reloadData];
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


//点击响应方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TheClassInformationViewController *theClassInformationVC = [TheClassInformationViewController new];
    [self.navigationController pushViewController:theClassInformationVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
