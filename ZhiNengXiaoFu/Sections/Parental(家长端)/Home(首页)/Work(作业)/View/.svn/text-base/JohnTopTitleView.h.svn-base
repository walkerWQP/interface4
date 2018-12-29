//
//  JohnTopTitleView.h
//  TopTitle
//
//  Created by aspilin on 2017/4/11.
//  Copyright © 2017年 aspilin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JohnTopTitleView : UIView

//传入title数组
@property (nonatomic,strong) NSArray            *title;
@property (nonatomic,assign) CGFloat            titleHeight;  //标题高度
@property (nonatomic,assign) CGFloat            lineViewWidth;  //记录底部线长度
@property (nonatomic,strong) UISegmentedControl *titleSegment;
@property (nonatomic,strong) UIScrollView       *pageScrollView;

/**
 *传入父控制器和子控制器数组即可
 **/
- (void)setupViewControllerWithFatherVC:(UIViewController *)fatherVC childVC:(NSArray<UIViewController *>*)childVC;
@property (nonatomic, strong) UIColor * selcetColor;
@property (nonatomic, strong) UIColor * unSelcetColor;

@end
