//
//  SearchSuggestionVC.m
//  ZhiNengXiaoFu
//
//  Created by 独秀科技 on 2018/12/12.
//  Copyright © 2018 henanduxiu. All rights reserved.
//

#import "SearchSuggestionVC.h"

@interface SearchSuggestionVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *contentView;
@property (nonatomic, copy)   NSString    *searchTest;

@end

@implementation SearchSuggestionVC

- (UITableView *)contentView {
    if (!_contentView) {
        self.contentView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT) style:UITableViewStylePlain];
        _contentView.delegate = self;
        _contentView.dataSource = self;
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.tableFooterView = [UIView new];
    }
    return _contentView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.contentView];
}

- (void)searchTestChangeWithTest:(NSString *)test {
    _searchTest = test;
    [_contentView reloadData];
}


#pragma mark - UITableViewDataSource -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (_searchTest.length > 0) ? (10 / _searchTest.length) : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"CellIdentifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@", _searchTest];
    return cell;
}


#pragma mark - UITableViewDelegate -

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.searchBlock) {
        self.searchBlock([NSString stringWithFormat:@"%@", _searchTest]);
    }
}

@end
