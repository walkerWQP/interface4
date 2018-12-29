//
//  YiZhuQinViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/8/30.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "YiZhuQinViewController.h"
#import "JiuQinStuCell.h"
#import "StudentJiuQinModel.h"

@interface YiZhuQinViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView            *YiZhuQinCollectionView;
@property (nonatomic, retain) UICollectionViewFlowLayout  *layout;
@property (nonatomic, strong) NSMutableArray              *YiZhuQinAry;

@end

@implementation YiZhuQinViewController

- (NSMutableArray *)YiZhuQinAry {
    if (!_YiZhuQinAry) {
        self.YiZhuQinAry = [@[]mutableCopy];
    }
    return _YiZhuQinAry;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 1)];
    [self.view addSubview:lineView];
    lineView.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    self.YiZhuQinCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 1, APP_WIDTH, APP_HEIGHT - 287 - APP_NAVH - 40 - 1) collectionViewLayout:self.layout];
    self.YiZhuQinCollectionView.backgroundColor = backColor;
    self.YiZhuQinCollectionView.delegate = self;
    self.YiZhuQinCollectionView.dataSource = self;
    [self.view addSubview:self.YiZhuQinCollectionView];
    [self.YiZhuQinCollectionView registerClass:[JiuQinStuCell class] forCellWithReuseIdentifier:@"JiuQinStuCellId"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [SingletonHelper manager].yidaoAry.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JiuQinStuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JiuQinStuCellId" forIndexPath:indexPath];
    if ([SingletonHelper manager].yidaoAry.count != 0) {
        StudentJiuQinModel *model = [[SingletonHelper manager].yidaoAry objectAtIndex:indexPath.row];
        [cell.headImg sd_setImageWithURL:[NSURL URLWithString:model.student_head_img] placeholderImage:[UIImage imageNamed:@"user"]] ;
        cell.nameLabel.text = model.student_name;
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((APP_WIDTH  - 30 )/ 3, 115);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
