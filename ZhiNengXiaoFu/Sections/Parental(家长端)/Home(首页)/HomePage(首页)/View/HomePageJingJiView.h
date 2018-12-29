//
//  HomePageJingJiView.h
//  ZhiNengXiaoFu
//
//  Created by 独秀科技 on 2018/10/9.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HomePageJingJiViewDelegate <NSObject>

-(void)jumpToAnswerHomePageJingJi:(NSString *)answerStr weizhi:(NSString *)weizhi;

@end

@interface HomePageJingJiView : UIView

@property(nonatomic,retain)id <HomePageJingJiViewDelegate>HomePageJingJiViewDelegate;
@property(nonatomic,strong)NSArray         *array;
@property (strong, nonatomic) UIScrollView *scrollView;

-(void)setDetail:(NSArray *)array;


@end

NS_ASSUME_NONNULL_END
