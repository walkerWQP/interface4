//
//  InformationCollectionController.m
//  ZhiNengXiaoFu
//
//  Created by 独秀科技 on 2018/11/26.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "InformationCollectionController.h"
#import "TotalNumberCell.h"
#import "TotalNumberModel.h"
#import "InformationCollectionModel.h"

@interface InformationCollectionController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,WPopupMenuDelegate>

@property (nonatomic, strong) NSMutableArray   *informationCollectionArr;
@property (nonatomic, strong) UICollectionView *informationCollectionCollectionView;
@property (nonatomic, strong) UIImageView      *zanwushuju;
@property (nonatomic, strong) UIButton         *rightBtn;
@property (nonatomic, strong) NSMutableArray   *classNameArr;
@property (nonatomic, strong) NSString         *studentID;

@end

@implementation InformationCollectionController

- (NSMutableArray *)classNameArr {
    if (!_classNameArr) {
        _classNameArr = [NSMutableArray array];
    }
    return _classNameArr;
}

- (NSMutableArray *)informationCollectionArr {
    if (!_informationCollectionArr) {
        _informationCollectionArr = [NSMutableArray array];
    }
    return _informationCollectionArr;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //下拉刷新
    self.informationCollectionCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    //自动更改透明度
    self.informationCollectionCollectionView.mj_header.automaticallyChangeAlpha = YES;
    //进入刷新状态
    [self.informationCollectionCollectionView.mj_header beginRefreshing];
}

- (void)loadNewTopic {
    [self.informationCollectionArr removeAllObjects];
    [self getClassConditionURLData:@"1"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"更换学生头像";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    self.zanwushuju = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 105 / 2, 200, 105, 111)];
    self.zanwushuju.image = [UIImage imageNamed:@"暂无数据家长端"];
    self.zanwushuju.alpha = 0;
    [self.view addSubview:self.zanwushuju];
    if ([self.typeID isEqualToString:@"1"]) {
        self.rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        [self.rightBtn setTitle:@"切换班级" forState:UIControlStateNormal];
        self.rightBtn.titleLabel.font = titFont;
        [self.rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
    }
    [self makeInformationCollectionControllerUI];
}

- (void)rightBtn:(UIButton *)sender {
    NSLog(@"点击选择班级");
    [self getClassURLDataForClassID];
}

- (void)viewWillDisappear:(BOOL)animated {
    //结束头部刷新
    [self.informationCollectionCollectionView.mj_header endRefreshing];
}



- (void)getClassConditionURLData:(NSString *)type {
    NSDictionary *dic = @{@"key":[UserManager key],@"class_id":self.classID,@"type":type};
    [[HttpRequestManager sharedSingleton] POST:GetStudentListURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        //结束头部刷新
        [self.informationCollectionCollectionView.mj_header endRefreshing];
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            self.informationCollectionArr = [InformationCollectionModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"] ];
            if (self.informationCollectionArr.count == 0) {
                self.zanwushuju.alpha = 1;
            } else {
                self.zanwushuju.alpha = 0;
                [self.informationCollectionCollectionView reloadData];
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

- (void)makeInformationCollectionControllerUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.informationCollectionCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_NAVH) collectionViewLayout:layout];
    self.informationCollectionCollectionView.backgroundColor = backColor;
    self.informationCollectionCollectionView.delegate = self;
    self.informationCollectionCollectionView.dataSource = self;
    [self.view addSubview:self.informationCollectionCollectionView];
    [self.informationCollectionCollectionView registerClass:[TotalNumberCell class] forCellWithReuseIdentifier:TotalNumberCell_CollectionView];
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.informationCollectionArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = nil;
    TotalNumberCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TotalNumberCell_CollectionView forIndexPath:indexPath];
    if (self.informationCollectionArr.count != 0) {
        TotalNumberModel *model = [self.informationCollectionArr objectAtIndex:indexPath.row];
        if (model.head_img == nil || [model.head_img isEqualToString:@""]) {
            cell.headImgView.image = [UIImage imageNamed:@"user"];
        } else {
            [cell.headImgView sd_setImageWithURL:[NSURL URLWithString:model.head_img] placeholderImage:[UIImage imageNamed:@"user"]];
        }
        cell.nameLabel.text = model.name;
        cell.nameLabel.textColor = [UIColor redColor];
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
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"youkeState"] isEqualToString:@"1"]) {
        [WProgressHUD showErrorAnimatedText:@"游客不能进行此操作"];
    } else {
        if (self.informationCollectionArr.count > 0) {
            InformationCollectionModel *model = [self.informationCollectionArr objectAtIndex:indexPath.row];
            self.studentID = model.ID;
            if (![self.studentID isEqualToString:@""] || self.studentID != nil) {
                [TakePhoto sharePictureWith:self andWith:^(UIImage *image) {
                    NSDictionary * params = @{@"key":[UserManager key],@"upload_type":@"img", @"upload_img_type":@"head_img",@"student_id":self.studentID};
                    [WProgressHUD showHUDShowText:@"加载中..."];
                    [[HttpRequestManager sharedSingleton].sessionManger POST:WENJIANSHANGCHUANJIEKOU parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                        NSData  *imageData = UIImageJPEGRepresentation(image,0.3);
                        float length = [imageData length]/1000;
                        
                        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                        formatter.dateFormat = @"yyyyMMddHHmmss";
                        NSString *str = [formatter stringFromDate:[NSDate date]];
                        NSString *imageFileName = [NSString stringWithFormat:@"%@.jpeg", str];
                        if (length > 1280) {
                            NSData *fData = UIImageJPEGRepresentation(image, 0.3);
                            [formData appendPartWithFileData:fData name:[NSString stringWithFormat:@"file"] fileName:imageFileName mimeType:@"image/jpeg"];
                        } else {
                            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"file"] fileName:imageFileName mimeType:@"image/jpeg"];
                        }
                    } progress:^(NSProgress * _Nonnull uploadProgress) {
                    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        
                        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
                            [WProgressHUD showSuccessfulAnimatedText:[responseObject objectForKey:@"msg"]];
                            [WProgressHUD hideAllHUDAnimated:YES];
                            [self loadNewTopic];
                        } else {
                            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                                [UserManager logoOut];
                            } else {
                            }
                            [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
                        }
                        
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        NSLog(@"%@", error);
                        [WProgressHUD hideAllHUDAnimated:YES];
                    }];
                }];
            }
        }
    }
}


- (void)getClassURLDataForClassID {
    NSDictionary *dic = @{@"key":[UserManager key]};
    [[HttpRequestManager sharedSingleton] POST:GetAdviserClassURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            self.classNameArr = [InformationCollectionModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            NSMutableArray *ary = [@[]mutableCopy];
            for (InformationCollectionModel *model in self.classNameArr) {
                [ary addObject:[NSString stringWithFormat:@"%@", model.name]];
            }
            if (ary.count == 0) {
                [WProgressHUD showErrorAnimatedText:@"数据不正确,请重试"];
            } else {
                [WPopupMenu showRelyOnView:self.rightBtn titles:ary icons:nil menuWidth:140 delegate:self];
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


#pragma mark - YBPopupMenuDelegate
- (void)WPopupMenuDidSelectedAtIndex:(NSInteger)index WPopupMenu:(WPopupMenu *)WPopupMenu {
    InformationCollectionModel *model = [self.classNameArr objectAtIndex:index];
    if (model.ID == nil) {
        [WProgressHUD showSuccessfulAnimatedText:@"数据不正确,请重试"];
    } else {
        self.classID = model.ID;
        [self getClassConditionURLData:@"1"];
    }
}



@end
