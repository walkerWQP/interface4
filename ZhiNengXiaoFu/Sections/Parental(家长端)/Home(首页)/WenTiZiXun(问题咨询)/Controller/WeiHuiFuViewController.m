//
//  WeiHuiFuViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/8/4.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "WeiHuiFuViewController.h"
#import "WeiHuiFuCell.h"
#import "ConsultListModel.h"

@interface WeiHuiFuViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView      *WeiHuiFuTableView;
@property (nonatomic, strong) ConsultListModel *consultListModel;
@property (nonatomic, strong) NSMutableArray   *WeiHuiFuAry;
@property (nonatomic, assign) NSInteger        page;
@property (nonatomic, strong) UIImageView      *zanwushuju;

@end

@implementation WeiHuiFuViewController

- (NSMutableArray *)WeiHuiFuAry {
    if (!_WeiHuiFuAry) {
        self.WeiHuiFuAry = [@[]mutableCopy];
    }
    return _WeiHuiFuAry;
}

- (void)viewWillAppear:(BOOL)animated {
    //下拉刷新
    self.WeiHuiFuTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    //自动更改透明度
    self.WeiHuiFuTableView.mj_header.automaticallyChangeAlpha = YES;
    //进入刷新状态
    [self.WeiHuiFuTableView.mj_header beginRefreshing];
    //上拉刷新
    self.WeiHuiFuTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
}

- (void)loadNewTopic {
    self.page = 1;
    [self.WeiHuiFuAry removeAllObjects];
    [self setNetWork:self.page];
}

- (void)loadMoreTopic {
    self.page += 1;
    [self setNetWork:self.page];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    self.view.backgroundColor = backColor;
    self.WeiHuiFuTableView.delegate = self;
    self.WeiHuiFuTableView.dataSource = self;
    
    [self.view addSubview:self.WeiHuiFuTableView];
    self.WeiHuiFuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.WeiHuiFuTableView registerNib:[UINib nibWithNibName:@"WeiHuiFuCell" bundle:nil] forCellReuseIdentifier:@"WeiHuiFuCellId"];
    
    self.zanwushuju = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 105 / 2, 200, 105, 111)];
    self.zanwushuju.image = [UIImage imageNamed:@"暂无数据家长端"];
    self.zanwushuju.alpha = 0;
    [self.view addSubview:self.zanwushuju];
   
}


- (void)setNetWork:(NSInteger)page {
    NSDictionary *dic = @{@"key":[UserManager key], @"status":@0,@"page":[NSString stringWithFormat:@"%ld", page]};
    [[HttpRequestManager sharedSingleton] POST:ConsultConsultList parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        //结束头部刷新
        [self.WeiHuiFuTableView.mj_header endRefreshing];
        //结束尾部刷新
        [self.WeiHuiFuTableView.mj_footer endRefreshing];
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            NSMutableArray *arr = [ConsultListModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            for (ConsultListModel *model in arr) {
                [self.WeiHuiFuAry addObject:model];
            }
            if (self.WeiHuiFuAry.count == 0) {
                self.zanwushuju.alpha = 1;
            } else {
                self.zanwushuju.alpha = 0;
            }
            [self.WeiHuiFuTableView reloadData];
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

- (UITableView *)WeiHuiFuTableView {
    if (!_WeiHuiFuTableView) {
        self.WeiHuiFuTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_NAVH - 40) style:UITableViewStylePlain];
        self.WeiHuiFuTableView.backgroundColor = backColor;
        self.WeiHuiFuTableView.delegate = self;
        self.WeiHuiFuTableView.dataSource = self;
        _WeiHuiFuTableView.estimatedRowHeight = 0;
        _WeiHuiFuTableView.estimatedSectionHeaderHeight = 0;
        _WeiHuiFuTableView.estimatedSectionFooterHeight = 0;
    }
    return _WeiHuiFuTableView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

//有时候tableview的底部视图也会出现此现象对应的修改就好了
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.WeiHuiFuAry.count;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WeiHuiFuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeiHuiFuCellId" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.WeiHuiFuAry.count != 0) {
        ConsultListModel *model = [self.WeiHuiFuAry objectAtIndex:indexPath.row];
        [cell.WeiHuiFuUserIconImg sd_setImageWithURL:[NSURL URLWithString:model.s_headimg] placeholderImage:[UIImage imageNamed:@"user"]];
        cell.WeiHuiFuNameLabel.text = [NSString stringWithFormat:@"%@%@问%@(%@):", model.class_name ,model.student_name, model.teacher_name, model.course_name];
        cell.WeiHuiFuQuestionLabel.text = model.question;
        cell.WeiHuiFuBtn.backgroundColor = RGB(255,144,144);
        cell.WeiHuiFuBtn.layer.masksToBounds = YES;
        cell.WeiHuiFuBtn.layer.cornerRadius  = 5;
        
    }
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger width = APP_WIDTH - 30;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    if (self.WeiHuiFuAry.count != 0) {
        ConsultListModel *model = [self.WeiHuiFuAry objectAtIndex:indexPath.row];
        CGSize size = [model.question boundingRectWithSize:CGSizeMake(width, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        return 130 + size.height - 5;
    } else {
        return 0;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
