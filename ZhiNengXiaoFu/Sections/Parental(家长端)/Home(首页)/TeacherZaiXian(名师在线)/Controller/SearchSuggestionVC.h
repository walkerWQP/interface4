//
//  SearchSuggestionVC.h
//  ZhiNengXiaoFu
//
//  Created by 独秀科技 on 2018/12/12.
//  Copyright © 2018 henanduxiu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SuggestSelectBlock)(NSString *searchTest);

@interface SearchSuggestionVC : UIViewController

@property (nonatomic, copy) SuggestSelectBlock searchBlock;

- (void)searchTestChangeWithTest:(NSString *)test;

@end

NS_ASSUME_NONNULL_END
