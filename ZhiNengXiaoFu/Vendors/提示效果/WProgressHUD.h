//
//  WProgressHUD.h
//  TheTemplate
//
//  Created by duxiu on 2018/8/8.
//  Copyright © 2018年 walker. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WHUDType) {
    WHUDLoadingType,//加载中
    WHUDSuccessfulAnimatedType,//加载成功动画
    WHUDErrorAnimatedType,//加载错误动画
    WHUDpromptTextType,//提示文字
};

@interface WProgressHUD : UIView

@property (nonatomic,strong) NSString *tipText;
@property(nonatomic,strong)  UILabel  *showTextLabel;
@property (nonatomic,strong) UIView   *toast;
@property(nonatomic,assign)  WHUDType type;

- (void)show:(BOOL)animated view:(UIView *)view;

- (void)hide:(BOOL)animated view:(UIView *)view;

- (instancetype)initWithFrame:(CGRect)frame showText:(NSString *)showText HUDType:(WHUDType)type;
///加载类型
+ (instancetype)showHUDShowText:(NSString *)showText;
//加载成功提示
+ (instancetype)showSuccessfulAnimatedText:(NSString *)ShowText;
//错误提示
+ (instancetype)showErrorAnimatedText:(NSString *)ShowText;
//文字提示
+ (instancetype)showDpromptText:(NSString *)showText;
//隐藏
+ (NSUInteger)hideAllHUDAnimated:(BOOL)animated;

@end
