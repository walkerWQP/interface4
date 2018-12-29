//
//  SDBaseRefreshView.h
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/9/4.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *const kSDBaseRefreshViewObserveKeyPath;

typedef enum {
    SDWXRefreshViewStateNormal,
    SDWXRefreshViewStateWillRefresh,
    SDWXRefreshViewStateRefreshing,
} SDWXRefreshViewState;

@interface SDBaseRefreshView : UIView

@property (nonatomic, strong) UIScrollView *scrollView;

- (void)endRefreshing;

@property (nonatomic, assign) UIEdgeInsets scrollViewOriginalInsets;
@property (nonatomic, assign) SDWXRefreshViewState refreshState;

@end
