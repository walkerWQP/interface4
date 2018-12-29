//
//  WPopupMenuPath.h
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, WPopupMenuArrowDirection) {
    WPopupMenuArrowDirectionTop = 0,  //箭头朝上
    WPopupMenuArrowDirectionBottom,   //箭头朝下
    WPopupMenuArrowDirectionLeft,     //箭头朝左
    WPopupMenuArrowDirectionRight,    //箭头朝右
    WPopupMenuArrowDirectionNone      //没有箭头
};




@interface WPopupMenuPath : NSObject

+ (CAShapeLayer *)W_maskLayerWithRect:(CGRect)rect
                            rectCorner:(UIRectCorner)rectCorner
                          cornerRadius:(CGFloat)cornerRadius
                            arrowWidth:(CGFloat)arrowWidth
                           arrowHeight:(CGFloat)arrowHeight
                         arrowPosition:(CGFloat)arrowPosition
                        arrowDirection:(WPopupMenuArrowDirection)arrowDirection;

+ (UIBezierPath *)W_bezierPathWithRect:(CGRect)rect
                             rectCorner:(UIRectCorner)rectCorner
                           cornerRadius:(CGFloat)cornerRadius
                            borderWidth:(CGFloat)borderWidth
                            borderColor:(UIColor *)borderColor
                        backgroundColor:(UIColor *)backgroundColor
                             arrowWidth:(CGFloat)arrowWidth
                            arrowHeight:(CGFloat)arrowHeight
                          arrowPosition:(CGFloat)arrowPosition
                         arrowDirection:(WPopupMenuArrowDirection)arrowDirection;



@end
