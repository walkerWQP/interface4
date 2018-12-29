//
//  SearchView.m
//  ZhiNengXiaoFu
//
//  Created by 独秀科技 on 2018/12/12.
//  Copyright © 2018 henanduxiu. All rights reserved.
//

#import "SearchView.h"

@interface SearchView ()

@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, strong) NSMutableArray *hotArray;
@property (nonatomic, strong) NSMutableArray *historyArray;
@property (nonatomic, strong) UIView         *searchHistoryView;
@property (nonatomic, strong) UIView         *hotSearchView;

@end

@implementation SearchView

- (instancetype)initWithFrame:(CGRect)frame hotArray:(NSMutableArray *)hotArr historyArray:(NSMutableArray *)historyArr {
    if (self = [super initWithFrame:frame]) {
        self.historyArray = historyArr;
        self.hotArray = hotArr;
        [self addSubview:self.searchHistoryView];
        [self addSubview:self.hotSearchView];
    }
    return self;
}


//- (UIView *)hotSearchView
//{
//    if (!_hotSearchView) {
//        self.hotSearchView = [self setViewWithOriginY:CGRectGetHeight(_searchHistoryView.frame) title:@"热门搜索" textArr:self.hotArray];
//    }
//    return _hotSearchView;
//}


- (UIView *)searchHistoryView {
    if (!_searchHistoryView) {
        if (_historyArray.count > 0) {
            self.searchHistoryView = [self setViewWithOriginY:0 title:@"最近搜索" textArr:self.historyArray];
        } else {
            self.searchHistoryView = [self setNoHistoryView];
        }
    }
    return _searchHistoryView;
}



- (UIView *)setViewWithOriginY:(CGFloat)riginY title:(NSString *)title textArr:(NSMutableArray *)textArr {
    UIView *view = [[UIView alloc] init];
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, APP_WIDTH - 30 - 45, 30)];
    titleL.text = title;
    titleL.font = [UIFont systemFontOfSize:15];
    titleL.textColor = [UIColor blackColor];
    titleL.textAlignment = NSTextAlignmentLeft;
    [view addSubview:titleL];
    
    if ([title isEqualToString:@"最近搜索"]) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(APP_WIDTH - 45, 10, 28, 30);
        [btn setImage:[UIImage imageNamed:@"sort_recycle"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clearnSearchHistory:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
    }
    
    CGFloat y = 10 + 40;
    CGFloat letfWidth = 15;
    for (int i = 0; i < textArr.count; i++) {
        NSString *text = textArr[i];
        CGFloat width = [self getWidthWithStr:text] + 30;
        if (letfWidth + width + 15 > APP_WIDTH) {
            if (y >= 130 && [title isEqualToString:@"最近搜索"]) {
                [self removeTestDataWithTextArr:textArr index:i];
                break;
            }
            y += 40;
            letfWidth = 15;
        }
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(letfWidth, y, width, 30)];
        label.userInteractionEnabled = YES;
        label.font = [UIFont systemFontOfSize:12];
        label.text = text;
        label.layer.borderWidth = 0.5;
        label.layer.cornerRadius = 5;
        label.textAlignment = NSTextAlignmentCenter;
        if (i % 2 == 0 && [title isEqualToString:@"热门搜索"]) {
            label.layer.borderColor = RGB(255, 148, 153).CGColor;
            label.textColor = RGB(255, 148, 153);
        } else {
            label.textColor = RGB(111, 111, 111);
            label.layer.borderColor = RGB(227, 227, 227).CGColor;
        }
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagDidCLick:)]];
        [view addSubview:label];
        letfWidth += width + 10;
    }
    view.frame = CGRectMake(0, riginY, APP_WIDTH, y + 40);
    return view;
}


- (UIView *)setNoHistoryView {
    UIView *historyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 80)];
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, APP_WIDTH - 30, 30)];
    titleL.text = @"最近搜索";
    titleL.font = [UIFont systemFontOfSize:15];
    titleL.textColor = [UIColor blackColor];
    titleL.textAlignment = NSTextAlignmentLeft;
    
    UILabel *notextL = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(titleL.frame) + 10, 100, 20)];
    notextL.text = @"无搜索历史";
    notextL.font = [UIFont systemFontOfSize:12];
    notextL.textColor = [UIColor blackColor];
    notextL.textAlignment = NSTextAlignmentLeft;
    [historyView addSubview:titleL];
    [historyView addSubview:notextL];
    return historyView;
}

- (void)tagDidCLick:(UITapGestureRecognizer *)tap {
    UILabel *label = (UILabel *)tap.view;
    if (self.tapAction) {
        self.tapAction(label.text);
    }
}

- (CGFloat)getWidthWithStr:(NSString *)text {
    CGFloat width = [text boundingRectWithSize:CGSizeMake(APP_WIDTH, 40) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12]} context:nil].size.width;
    return width;
}


- (void)clearnSearchHistory:(UIButton *)sender {
    [self.searchHistoryView removeFromSuperview];
    self.searchHistoryView = [self setNoHistoryView];
    [_historyArray removeAllObjects];
    [NSKeyedArchiver archiveRootObject:_historyArray toFile:KHistorySearchPath];
    [self addSubview:self.searchHistoryView];
    CGRect frame = _hotSearchView.frame;
    frame.origin.y = CGRectGetHeight(_searchHistoryView.frame);
    _hotSearchView.frame = frame;
}

- (void)removeTestDataWithTextArr:(NSMutableArray *)testArr index:(int)index {
    NSRange range = {index, testArr.count - index - 1};
    [testArr removeObjectsInRange:range];
    [NSKeyedArchiver archiveRootObject:testArr toFile:KHistorySearchPath];
}

@end
