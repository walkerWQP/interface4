//
//  KeChengJieShaoViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/30.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "KeChengJieShaoViewController.h"
#import "KeChengJieShaonCell.h"
@interface KeChengJieShaoViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *KeChengJieShaoTableView;

@end

@implementation KeChengJieShaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backColor;
    self.KeChengJieShaoTableView.delegate = self;
    self.KeChengJieShaoTableView.dataSource = self;
    [self.view addSubview:self.KeChengJieShaoTableView];
    self.KeChengJieShaoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.KeChengJieShaoTableView registerNib:[UINib nibWithNibName:@"KeChengJieShaonCell" bundle:nil] forCellReuseIdentifier:@"KeChengJieShaonCellId"];
}

- (UITableView *)KeChengJieShaoTableView {
    if (!_KeChengJieShaoTableView) {
        self.KeChengJieShaoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - 200 - APP_NAVH - 40) style:UITableViewStyleGrouped];
        self.KeChengJieShaoTableView.backgroundColor = backColor;
        self.KeChengJieShaoTableView.delegate = self;
        self.KeChengJieShaoTableView.dataSource = self;
    }
    return _KeChengJieShaoTableView;
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
    return 1;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KeChengJieShaonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KeChengJieShaonCellId" forIndexPath:indexPath];
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    cell.shanChangConnectLabel.text = self.teacherZaiXianDetailsModel.content;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger width = APP_WIDTH - 30;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    CGSize size = [self.teacherZaiXianDetailsModel.content boundingRectWithSize:CGSizeMake(width, 1000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return 30 + size.height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
