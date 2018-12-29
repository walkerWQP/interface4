//
//  UIButton+YasinTimerCategory.h
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/9/5.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (YasinTimerCategory)

- (void)startCountDownTime:(int)time withCountDownBlock:(void(^)(void))countDownBlock;

@end
