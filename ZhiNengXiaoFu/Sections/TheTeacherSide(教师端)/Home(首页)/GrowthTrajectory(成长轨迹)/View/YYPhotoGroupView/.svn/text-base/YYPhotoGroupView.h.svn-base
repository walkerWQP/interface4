//
//  YYPhotoGroupView.h
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/9/4.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface YYPhotoGroupItem : NSObject

@property (nonatomic, strong) UIView *thumbView;
@property (nonatomic, assign) CGSize largeImageSize;
@property (nonatomic, strong) NSURL  *largeImageURL;

@end


@interface YYPhotoGroupView : UIView

@property (nonatomic, readonly) NSArray      *groupItems;
@property (nonatomic, readonly) NSInteger    currentPage;
@property (nonatomic, assign) BOOL           blurEffectBackground;
@property (nonatomic, assign) BOOL           showAnimated;
@property (nonatomic, assign) BOOL           showPageControl;
@property (nonatomic, weak) UIViewController *superView;


- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithFrame:(CGRect)frame UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithGroupItems:(NSArray *)groupItems;

- (void)presentFromImageView:(UIView *)fromView
                 toContainer:(UIView *)container
                    animated:(BOOL)animated
                  completion:(void (^)(void))completion;

- (void)dismissAnimated:(BOOL)animated completion:(void (^)(void))completion;
- (void)dismiss;

@end
