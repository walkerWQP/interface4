//
//  ParentXueTangNewViewController.m
//  ZhiNengXiaoFu
//
//  Created by 独秀科技 on 2018/10/11.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "ParentXueTangNewViewController.h"
#import "ParentXueTangCell.h"
#import "ParentXueTangModel.h"
#import "ParentXueTangDetailsViewController.h"
#import "TeacherListNCell.h"

@interface ParentXueTangNewViewController ()<UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate>

@property (nonatomic, strong) UITableView    *ChildJiaoYuTableView;
@property (nonatomic, strong) NSMutableArray *ChildJiaoYuAry;
@property (nonatomic, strong) UIImageView    *zanwushuju;
@property (nonatomic, assign) NSInteger      page;
@property (nonatomic, strong) NSMutableArray *bannerArr;
@property (nonatomic, strong)  UIImageView   *back;
@property (nonatomic, strong)  UILabel       *zinv;
@property (nonatomic, strong) UILabel        *xinli;
@property (nonatomic, strong) UIImageView    *zinvImg;
@property (nonatomic, strong) UIImageView    *xinliImg;
@property (nonatomic, assign) NSInteger      biaoji;
@end

@implementation ParentXueTangNewViewController

- (NSMutableArray *)ChildJiaoYuAry {
    if (!_ChildJiaoYuAry) {
        self.ChildJiaoYuAry = [@[]mutableCopy];
    }
    return _ChildJiaoYuAry;
}

- (NSMutableArray *)bannerArr {
    if (!_bannerArr) {
        _bannerArr = [NSMutableArray array];
    }
    return _bannerArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backColor;
    self.title = @"家长学堂";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    self.ChildJiaoYuTableView.delegate = self;
    self.ChildJiaoYuTableView.dataSource = self;
    
    [self.view addSubview:self.ChildJiaoYuTableView];
    self.ChildJiaoYuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.ChildJiaoYuTableView registerClass:[ParentXueTangCell class] forCellReuseIdentifier:@"ParentXueTangCellId"];
    [self.ChildJiaoYuTableView registerNib:[UINib nibWithNibName:@"TeacherListNCell" bundle:nil] forCellReuseIdentifier:@"TeacherListNCellId"];

    self.zanwushuju = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 105 / 2, 350, 105, 111)];
    self.zanwushuju.image = [UIImage imageNamed:@"暂无数据家长端"];
    self.zanwushuju.alpha = 0;
    [self.view addSubview:self.zanwushuju];
    
    //下拉刷新
    self.ChildJiaoYuTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    //自动更改透明度
    self.ChildJiaoYuTableView.mj_header.automaticallyChangeAlpha = YES;
    //进入刷新状态
    [self.ChildJiaoYuTableView.mj_header beginRefreshing];
    //上拉刷新
    self.ChildJiaoYuTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
    
    [self getBannersURLData];
    self.biaoji = 1;
}


- (void)getBannersURLData {
    NSDictionary *dic = @{@"key":[UserManager key],@"t_id":@"11"};
    [[HttpRequestManager sharedSingleton] POST:bannersURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            
            self.bannerArr = [BannerModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            [self.ChildJiaoYuTableView reloadData];
            
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


- (void)loadNewTopic {
    self.page = 1;
    [self.ChildJiaoYuAry removeAllObjects];
    [self setNetWork:self.page];
}

- (void)loadMoreTopic {
    self.page += 1;
    [self setNetWork:self.page];
}

- (void)setNetWork:(NSInteger)page {
    NSDictionary *dic = [NSDictionary dictionary];
    if (self.biaoji == 1) {
         dic = @{@"key":[UserManager key], @"type":@1,@"page":[NSString stringWithFormat:@"%ld",page]};
    } else if (self.biaoji == 2) {
         dic = @{@"key":[UserManager key], @"type":@2,@"page":[NSString stringWithFormat:@"%ld",page]};
    }
   
    [[HttpRequestManager sharedSingleton] POST:pschoolGetList parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        //结束头部刷新
        [self.ChildJiaoYuTableView.mj_header endRefreshing];
        //结束尾部刷新
        [self.ChildJiaoYuTableView.mj_footer endRefreshing];
        
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            NSMutableArray *arr = [ParentXueTangModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            for (ParentXueTangModel *model in arr) {
                [self.ChildJiaoYuAry addObject:model];
            }
            if (self.ChildJiaoYuAry.count == 0) {
                self.zanwushuju.alpha = 1;
                
            } else {
                self.zanwushuju.alpha = 0;
                [self.ChildJiaoYuTableView reloadData];
            }
            [self.ChildJiaoYuTableView reloadData];
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



- (UITableView *)ChildJiaoYuTableView {
    if (!_ChildJiaoYuTableView) {
        self.ChildJiaoYuTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_NAVH) style:UITableViewStylePlain];
        self.ChildJiaoYuTableView.backgroundColor = backColor;
        self.ChildJiaoYuTableView.delegate = self;
        self.ChildJiaoYuTableView.dataSource = self;
        self.ChildJiaoYuTableView.backgroundColor = [UIColor whiteColor];
        
        _ChildJiaoYuTableView.estimatedRowHeight = 0;
        _ChildJiaoYuTableView.estimatedSectionHeaderHeight = 0;
        _ChildJiaoYuTableView.estimatedSectionFooterHeight = 0;
    }
    return _ChildJiaoYuTableView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    } else {
        return 44;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
     if (section == 0) {
         return nil;
     } else {
         UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
         
         self.back = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
         if (self.biaoji == 1) {
             self.back.image = [UIImage imageNamed:@"左边选中右边未选"];
         } else if (self.biaoji == 2) {
             self.back.image = [UIImage imageNamed:@"右边选中左边未选"];
         }
         [headerView addSubview:self.back];
         
         self.zinv = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth / 4 - 30, 8, 62, 28)];
         self.zinv.text = @"子女教育";
         self.zinv.font = [UIFont systemFontOfSize:15];
         if (self.biaoji == 1) {
             self.zinv.textColor = RGB(51, 51, 51);
             
         } else if (self.biaoji == 2) {
             self.zinv.textColor = RGB(170, 170, 170);
         }
         
         [headerView addSubview:self.zinv];
         
         self.xinli = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth / 4 * 3 - 30, 8, 62, 28)];
         self.xinli.text = @"心理健康";
         self.xinli.font = [UIFont systemFontOfSize:15];
         if (self.biaoji == 1) {
             self.xinli.textColor = RGB(170, 170, 170);
         } else if (self.biaoji == 2) {
             self.xinli.textColor = RGB(51, 51, 51);
         }
         [headerView addSubview:self.xinli];
         
         self.zinvImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.zinv.frame.origin.x - 4 - 16, 14, 16, 14)];
         if (self.biaoji == 1) {
             self.zinvImg.image = [UIImage imageNamed:@"子女教育选中"];
         } else if (self.biaoji == 2) {
             self.zinvImg.image = [UIImage imageNamed:@"子女教育未选"];
         }
         [headerView addSubview:self.zinvImg];
         
         self.xinliImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.xinli.frame.origin.x - 4 - 16, 14, 16, 14)];
         if (self.biaoji == 1) {
             self.xinliImg.image = [UIImage imageNamed:@"心理健康未选"];
             
         } else if (self.biaoji == 2) {
             self.xinliImg.image = [UIImage imageNamed:@"心理健康选中"];
         }
         [headerView addSubview:self.xinliImg];
         
         UIButton *left = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth / 2, 40)];
         [left addTarget:self action:@selector(left:) forControlEvents:UIControlEventTouchDown];
         left.userInteractionEnabled = YES;
         [headerView addSubview:left];

         UIButton *right = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth / 2, 0, kScreenWidth / 2, 40)];
         [right addTarget:self action:@selector(right:) forControlEvents:UIControlEventTouchDown];
         right.userInteractionEnabled = YES;
         [headerView addSubview:right];
         return headerView;
     }
}


- (void)left:(UIButton *)sender {
    self.back.image = [UIImage imageNamed:@"左边选中右边未选"];
    self.xinli.textColor = RGB(170, 170, 170);
    self.zinv.textColor = RGB(51, 51, 51);
    self.zinvImg.image = [UIImage imageNamed:@"子女教育选中"];
    self.xinliImg.image = [UIImage imageNamed:@"心理健康未选"];
    self.biaoji = 1;
    self.page = 1;
    [self.ChildJiaoYuAry removeAllObjects];
    [self setNetWork:self.page];
}

- (void)right:(UIButton *)sender {
    self.back.image = [UIImage imageNamed:@"右边选中左边未选"];
    self.zinv.textColor = RGB(170, 170, 170);
    self.xinli.textColor = RGB(51, 51, 51);
    self.zinvImg.image = [UIImage imageNamed:@"子女教育未选"];
    self.xinliImg.image = [UIImage imageNamed:@"心理健康选中"];
    self.biaoji = 2;
    self.page = 1;
    [self.ChildJiaoYuAry removeAllObjects];
    [self setNetWork:self.page];
}

//有时候tableview的底部视图也会出现此现象对应的修改就好了
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return self.ChildJiaoYuAry.count;
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"TableViewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        } else {
            //删除cell中的子对象,刷新覆盖问题。
            while ([cell.contentView.subviews lastObject] != nil) {
                [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *imgs = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, APP_WIDTH - 30, 170)];
        imgs.contentMode = UIViewContentModeScaleAspectFill;
        imgs.clipsToBounds = YES;
        imgs.layer.cornerRadius  = 10;
        imgs.layer.masksToBounds = YES;
        if (self.bannerArr.count == 0) {
            //            imgs.image = [UIImage imageNamed:@"教师端活动管理banner"];
        } else {
            BannerModel *model = [self.bannerArr objectAtIndex:0];
            [imgs sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"教师端活动管理banner"]];
        }
        [cell addSubview:imgs];
        return cell;
    } else {
        TeacherListNCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TeacherListNCellId" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.LiuLanTopCon.constant = 15;
      
        if (self.ChildJiaoYuAry.count != 0) {
            ParentXueTangModel *model = [self.ChildJiaoYuAry objectAtIndex:indexPath.row];
            [cell.TeacherListNImg sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"缩略图"]];
            cell.TeacherListNImg.contentMode = UIViewContentModeScaleAspectFill;
            cell.TeacherListNImg.clipsToBounds = YES;
            cell.TeacherListNTitleLabel.text = model.title;
            if (model.view > 9999) {
                CGFloat num = model.view / 10000;
                cell.TeacherListNBoFangCi.text = [NSString stringWithFormat:@"%.1f万次播放", num];
            } else {
                cell.TeacherListNBoFangCi.text = [NSString stringWithFormat:@"%ld次播放", model.view];
            }
            
            cell.TeacherListNFenLeiLabel.alpha = 0;
            
            if (model.label.count == 0) {
                cell.TeacherListNOneView.alpha = 0;
                cell.TeacherListNTwoView.alpha = 0;
                cell.TeacherListNThreeView.alpha = 0;
                
                cell.TeacherListNOneLabel.alpha = 0;
                cell.TeacherListNTwoLabel.alpha = 0;
                cell.TeacherListNThreeLabel.alpha = 0;
            } else if (model.label.count == 1) {
                cell.TeacherListNOneView.alpha = 1;
                cell.TeacherListNTwoView.alpha = 0;
                cell.TeacherListNThreeView.alpha = 0;
                
                cell.TeacherListNOneLabel.alpha = 1;
                cell.TeacherListNTwoLabel.alpha = 0;
                cell.TeacherListNThreeLabel.alpha = 0;
                cell.TeacherListNOneLabel.text = [model.label objectAtIndex:0];
                
            } else if (model.label.count == 2) {
                cell.TeacherListNOneView.alpha = 1;
                cell.TeacherListNTwoView.alpha = 1;
                cell.TeacherListNThreeView.alpha = 0;
                
                cell.TeacherListNOneLabel.alpha = 1;
                cell.TeacherListNTwoLabel.alpha = 1;
                cell.TeacherListNThreeLabel.alpha = 0;
                cell.TeacherListNOneLabel.text = [model.label objectAtIndex:0];
                cell.TeacherListNTwoLabel.text = [model.label objectAtIndex:1];
            } else if (model.label.count == 3) {
                cell.TeacherListNOneView.alpha = 1;
                cell.TeacherListNTwoView.alpha = 1;
                cell.TeacherListNThreeView.alpha = 1;
                
                cell.TeacherListNOneLabel.alpha = 1;
                cell.TeacherListNTwoLabel.alpha = 1;
                cell.TeacherListNThreeLabel.alpha = 1;
                cell.TeacherListNOneLabel.text = [model.label objectAtIndex:0];
                cell.TeacherListNTwoLabel.text = [model.label objectAtIndex:1];
                cell.TeacherListNThreeLabel.text = [model.label objectAtIndex:2];
            }
        }
      return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 170;
    } else {
        return 112 + 10;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ParentXueTangDetailsViewController *parentXueTangDetailsVC = [[ParentXueTangDetailsViewController alloc] init];
    if (self.ChildJiaoYuAry.count != 0) {
        ParentXueTangModel *model = [self.ChildJiaoYuAry objectAtIndex:indexPath.row];
        parentXueTangDetailsVC.ParentXueTangDetailsId = model.ID;
    }
    [self.navigationController pushViewController:parentXueTangDetailsVC animated:YES];
}



@end
