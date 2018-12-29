//
//  SearchViewController.h
//  ZhiNengXiaoFu
//
//  Created by 独秀科技 on 2018/12/12.
//  Copyright © 2018 henanduxiu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SearchViewControllerDelegate <NSObject>

@optional

- (void)delegateViewControllerDidClickwithString:(NSString *)string;

@end


@interface SearchViewController : UIViewController

@property (nonatomic, assign) id<SearchViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
