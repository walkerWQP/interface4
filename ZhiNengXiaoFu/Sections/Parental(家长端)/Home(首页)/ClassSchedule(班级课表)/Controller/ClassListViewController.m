//
//  ClassListViewController.m
//  ZhiNengXiaoFu
//
//  Created by 独秀科技 on 2018/12/18.
//  Copyright © 2018 henanduxiu. All rights reserved.
//

#import "ClassListViewController.h"
#import "ClassListCell.h"
#import "AddLessonsViewController.h"
#import "ClassListModel.h"

@interface ClassListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray  *classListArr;
@property (nonatomic, strong) UITableView     *classListTableView;
@property (nonatomic, strong) UIImageView     *zanwushuju;
@property (nonatomic, strong) UIButton        *rightBtn;

@end

@implementation ClassListViewController

- (NSMutableArray *)classListArr {
    if (!_classListArr) {
        _classListArr = [NSMutableArray array];
    }
    return _classListArr;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    if (self.class_id != nil) {
        [self GetTimeListURLData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"课节列表";
    self.zanwushuju = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 105 / 2, 200, 105, 111)];
    self.zanwushuju.image = [UIImage imageNamed:@"暂无数据家长端"];
    self.zanwushuju.alpha = 0;
    [self.classListTableView addSubview:self.zanwushuju];
    [self.view addSubview:self.classListTableView];
    [self.classListTableView registerClass:[ClassListCell class] forCellReuseIdentifier:@"ClassListCellID"];
    self.classListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [self.rightBtn setImage:[UIImage imageNamed:@"加号"] forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = titFont;
    [self.rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
    
}

- (void)rightBtn:(UIButton *)sender {
    AddLessonsViewController *addLessonsVC = [AddLessonsViewController new];
    addLessonsVC.class_id = self.class_id;
    [self.navigationController pushViewController:addLessonsVC animated:YES];
}

- (void)GetTimeListURLData {
    NSDictionary *dic = @{@"key":[UserManager key],@"class_id":self.class_id};
    [[HttpRequestManager sharedSingleton] POST:GetTimeListURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            [self.classListArr removeAllObjects];
            NSMutableArray *arr = [ClassListModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            for (ClassListModel *model in arr) {
                [self.classListArr addObject:model];
            }
            if (self.classListArr.count == 0) {
                self.zanwushuju.alpha = 1;
            } else {
                self.zanwushuju.alpha = 0;
                [self.classListTableView reloadData];
            }
            
        } else {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
            } else {
                
            }
            [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
        }
        [self.classListTableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}



- (UITableView *)classListTableView {
    if (!_classListTableView) {
        self.classListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_NAVH) style:UITableViewStylePlain];
        self.classListTableView.backgroundColor = backColor;
        self.classListTableView.delegate = self;
        self.classListTableView.dataSource = self;
        self.classListTableView.estimatedRowHeight = 0;
        self.classListTableView.estimatedSectionHeaderHeight = 0;
        self.classListTableView.estimatedSectionFooterHeight = 0;
    }
    return _classListTableView;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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
    return self.classListArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     ClassListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClassListCellID" forIndexPath:indexPath];
    if (self.classListArr.count > 0) {
        ClassListModel * model = [self.classListArr objectAtIndex:indexPath.row];
        [cell.numBtn setTitle:[NSString stringWithFormat:@"%ld",indexPath.row + 1] forState:UIControlStateNormal];
        cell.timeLabel.text = [NSString stringWithFormat:@"%@~%@",model.start,model.end];
        
        UIButton *changeBtn = cell.changBtn;
        [changeBtn addTarget:self action:@selector(changeBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *delegateBtn = cell.delegateBtn;
        [delegateBtn addTarget:self action:@selector(delegateBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return cell;
}

//删除
- (void)delegateBtn:(UIButton *)sender {
    NSLog(@"删除");
    UIView *v = [sender superview];//获取父类view
    ClassListCell *cell = (ClassListCell *)[v superview];//获取cell
    NSIndexPath *indexpath = [self.classListTableView indexPathForCell:cell];//获取cell对应的indexpath;
    if (self.classListArr.count != 0) {
        ClassListModel *model = [self.classListArr objectAtIndex:indexpath.row];
        if (model.ID == nil) {
            [WProgressHUD showErrorAnimatedText:@"数据不正确,请重试"];
        } else {
            //先删数据 再删UI
            ClassListModel *model = [self.classListArr objectAtIndex:indexpath.row];
            [self DelTimeURLData:model.ID];
            [self.classListArr removeObjectAtIndex:indexpath.row];
            [self.classListTableView deleteRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
    
}

- (void)DelTimeURLData:(NSString *)timeID {
    NSDictionary *dic = @{@"key":[UserManager key],@"id":timeID};
    [[HttpRequestManager sharedSingleton] POST:DelTimeURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            
            [WProgressHUD showSuccessfulAnimatedText:[responseObject objectForKey:@"msg"]];
            [self.classListArr removeAllObjects];
            [self.classListTableView reloadData];
            [self GetTimeListURLData];
            
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



//修改
- (void)changeBtn:(UIButton *)sender {
    NSLog(@"点击修改");
    AddLessonsViewController *addLessonsVC = [AddLessonsViewController new];
    UIView *v = [sender superview];//获取父类view
    ClassListCell *cell = (ClassListCell *)[v superview];//获取cell
    NSIndexPath *indexpath = [self.classListTableView indexPathForCell:cell];//获取cell对应的indexpath;
    if (self.classListArr.count != 0) {
        ClassListModel *model = [self.classListArr objectAtIndex:indexpath.row];
        if (model.ID == nil) {
            [WProgressHUD showErrorAnimatedText:@"数据不正确,请重试"];
        } else {
            addLessonsVC.class_id  = model.ID;
            addLessonsVC.begintStr = model.start;
            addLessonsVC.endStr    = model.end;
            addLessonsVC.typeStr   = @"1";
            [self.navigationController pushViewController:addLessonsVC animated:YES];
        }
    }
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}




@end
