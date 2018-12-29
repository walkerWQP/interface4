//
//  SearchViewController.m
//  ZhiNengXiaoFu
//
//  Created by 独秀科技 on 2018/12/12.
//  Copyright © 2018 henanduxiu. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchSuggestionVC.h"
#import "SearchView.h"


@interface SearchViewController ()<UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar          *searchBar;
@property (nonatomic, strong) SearchView           *searchView;
@property (nonatomic, strong) NSMutableArray       *historyArray;
@property (nonatomic, strong) SearchSuggestionVC   *searchSuggestVC;

@end


@implementation SearchViewController

- (NSMutableArray *)historyArray {
    if (!_historyArray) {
        _historyArray = [NSKeyedUnarchiver unarchiveObjectWithFile:KHistorySearchPath];
        if (!_historyArray) {
            self.historyArray = [NSMutableArray array];
        }
    }
    return _historyArray;
}

- (SearchView *)searchView {
    if (!_searchView) {
        self.searchView = [[SearchView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT) hotArray:nil historyArray:self.historyArray];
        __weak SearchViewController *weakSelf = self;
        _searchView.tapAction = ^(NSString *str) {
            [weakSelf pushToSearchResultWithSearchStr:str];
        };
    }
    return _searchView;
}


- (SearchSuggestionVC *)searchSuggestVC {
    if (!_searchSuggestVC) {
        self.searchSuggestVC = [[SearchSuggestionVC alloc] init];
        _searchSuggestVC.view.frame = CGRectMake(0, APP_NAVH, APP_WIDTH, APP_HEIGHT - APP_NAVH);
        _searchSuggestVC.view.hidden = YES;
        __weak SearchViewController *weakSelf = self;
        _searchSuggestVC.searchBlock = ^(NSString *searchTest) {
            [weakSelf pushToSearchResultWithSearchStr:searchTest];
        };
    }
    return _searchSuggestVC;
}



- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!_searchBar.isFirstResponder) {
        [self.searchBar becomeFirstResponder];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 回收键盘
    [self.searchBar resignFirstResponder];
    _searchSuggestVC.view.hidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBarButtonItem];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.searchView];
    [self.view addSubview:self.searchSuggestVC.view];
    [self addChildViewController:_searchSuggestVC];
}


- (void)setBarButtonItem {
    [self.navigationItem setHidesBackButton:YES];
    // 创建搜索框
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(5, 7, self.view.frame.size.width, 30)];
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(titleView.frame) - 15, 30)];
    searchBar.placeholder = @"搜索内容";
    searchBar.backgroundImage = [UIImage imageNamed:@"clearImage"];
    searchBar.delegate = self;
    searchBar.showsCancelButton = YES;
    UIView *searchTextField = searchTextField = [searchBar valueForKey:@"_searchField"];
    searchTextField.backgroundColor = [UIColor colorWithRed:234/255.0 green:235/255.0 blue:237/255.0 alpha:1];
    [searchBar setImage:[UIImage imageNamed:@"sort_magnifier"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    UIButton *cancleBtn = [searchBar valueForKey:@"cancelButton"];
    //修改标题和标题颜色
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [titleView addSubview:searchBar];
    self.searchBar = searchBar;
    [self.searchBar becomeFirstResponder];
    self.navigationItem.titleView = titleView;
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
}


- (void)presentVCFirstBackClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


/** 点击取消 */
- (void)cancelDidClick {
    [self.searchBar resignFirstResponder];
    [self dismissViewControllerAnimated:NO completion:nil];
}


- (void)pushToSearchResultWithSearchStr:(NSString *)str {
    self.searchBar.text = str;
    [self setHistoryArrWithStr:str];
    if ([self.delegate respondsToSelector:@selector(delegateViewControllerDidClickwithString:)]) {
        [self.delegate delegateViewControllerDidClickwithString:str];
    }
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"点击搜索");
}

- (void)setHistoryArrWithStr:(NSString *)str {
    for (int i = 0; i < _historyArray.count; i++) {
        if ([_historyArray[i] isEqualToString:str]) {
            [_historyArray removeObjectAtIndex:i];
            break;
        }
    }
    [_historyArray insertObject:str atIndex:0];
    [NSKeyedArchiver archiveRootObject:_historyArray toFile:KHistorySearchPath];
}


#pragma mark - UISearchBarDelegate -


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self pushToSearchResultWithSearchStr:searchBar.text];
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchBar.text == nil || [searchBar.text length] <= 0) {
        _searchSuggestVC.view.hidden = YES;
        [self.view bringSubviewToFront:_searchView];
    } else {
        _searchSuggestVC.view.hidden = NO;
        [self.view bringSubviewToFront:_searchSuggestVC.view];
        [_searchSuggestVC searchTestChangeWithTest:searchBar.text];
    }
}


@end
