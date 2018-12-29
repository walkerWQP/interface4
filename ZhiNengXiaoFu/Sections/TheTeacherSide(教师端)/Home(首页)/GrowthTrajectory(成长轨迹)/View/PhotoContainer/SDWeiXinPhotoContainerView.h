//
//  SDWeiXinPhotoContainerView.h
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/9/4.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDWeiXinPhotoContainerView : UIView

@property (nonatomic, strong) NSArray          *picPathStringsArray;
@property (nonatomic, strong) UIViewController *superView;
@property (nonatomic, assign) int              customImgWidth;

+ (CGSize)getContainerSizeWithPicPathStringsArray:(NSArray *)picPathStringsArray;

@end
