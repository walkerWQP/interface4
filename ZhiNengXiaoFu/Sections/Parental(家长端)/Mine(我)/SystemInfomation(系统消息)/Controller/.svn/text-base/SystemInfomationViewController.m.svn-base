//
//  SystemInfomationViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/24.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "SystemInfomationViewController.h"
#import "SystemInformationCell.h"

@interface SystemInfomationViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView    *systemInfomationTableView;
@property (nonatomic, strong) NSMutableArray *leaveListAry;
@end

@implementation SystemInfomationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"系统消息";
    [self.view addSubview:self.systemInfomationTableView];
    [self.systemInfomationTableView registerClass:[SystemInformationCell class] forCellReuseIdentifier:@"SystemInformationCellId"];
}

- (UITableView *)systemInfomationTableView {
    if (!_systemInfomationTableView) {
        self.systemInfomationTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT) style:UITableViewStylePlain];
        self.systemInfomationTableView.backgroundColor = backColor;
        self.systemInfomationTableView.dataSource = self;
        self.systemInfomationTableView.delegate = self;
    }
    return _systemInfomationTableView;
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
    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SystemInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SystemInformationCellId" forIndexPath:indexPath];
    cell.titleLabel.text = @"[我们与总数据在一起]谱写新时间";
    cell.connectLabel.text = @"央视网消息(新闻联播) : 12日上午, 中共中央总书记、国家主席、中央军委主席";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
