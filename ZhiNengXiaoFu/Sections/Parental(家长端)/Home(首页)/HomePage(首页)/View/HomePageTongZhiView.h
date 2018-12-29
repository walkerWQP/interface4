//
//  HomePageTongZhiView.h
//  ZhiNengXiaoFu
//
//  Created by 独秀科技 on 2018/10/10.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^clickLabelBlock)(NSInteger ID,NSString *titleString);

@interface HomePageTongZhiView : UIView

@property (nonatomic,strong) NSMutableArray *titleArray;
@property (nonatomic,strong) NSMutableArray *titleNewArray;
@property (nonatomic,assign) BOOL           isCanScroll;
@property (nonatomic,copy)void(^clickLabelBlock)(NSInteger index,NSString *titleString);
@property (nonatomic,strong) UIColor        *titleColor;
@property (nonatomic,strong) UIColor        *BGColor;
@property (nonatomic,assign) CGFloat        titleFont;

- (void)removeTimer;
- (void)addTimer;
- (void) clickTitleLabel:(clickLabelBlock) clickLabelBlock;

@end

NS_ASSUME_NONNULL_END
