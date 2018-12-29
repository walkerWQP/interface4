//
//  WPopupMenuPath.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "WPopupMenuPath.h"
#import "YBRectConst.h"

@implementation WPopupMenuPath

+ (CAShapeLayer *)W_maskLayerWithRect:(CGRect)rect
                            rectCorner:(UIRectCorner)rectCorner
                          cornerRadius:(CGFloat)cornerRadius
                            arrowWidth:(CGFloat)arrowWidth
                           arrowHeight:(CGFloat)arrowHeight
                         arrowPosition:(CGFloat)arrowPosition
                        arrowDirection:(WPopupMenuArrowDirection)arrowDirection
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [self W_bezierPathWithRect:rect rectCorner:rectCorner cornerRadius:cornerRadius borderWidth:0 borderColor:nil backgroundColor:nil arrowWidth:arrowWidth arrowHeight:arrowHeight arrowPosition:arrowPosition arrowDirection:arrowDirection].CGPath;
    return shapeLayer;
}


+ (UIBezierPath *)W_bezierPathWithRect:(CGRect)rect
                             rectCorner:(UIRectCorner)rectCorner
                           cornerRadius:(CGFloat)cornerRadius
                            borderWidth:(CGFloat)borderWidth
                            borderColor:(UIColor *)borderColor
                        backgroundColor:(UIColor *)backgroundColor
                             arrowWidth:(CGFloat)arrowWidth
                            arrowHeight:(CGFloat)arrowHeight
                          arrowPosition:(CGFloat)arrowPosition
                         arrowDirection:(WPopupMenuArrowDirection)arrowDirection
{
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    if (borderColor) {
        [borderColor setStroke];
    }
    if (backgroundColor) {
        [backgroundColor setFill];
    }
    bezierPath.lineWidth = borderWidth;
    rect = CGRectMake(borderWidth / 2, borderWidth / 2, WRectWidth(rect) - borderWidth, WRectHeight(rect) - borderWidth);
    CGFloat topRightRadius = 0,topLeftRadius = 0,bottomRightRadius = 0,bottomLeftRadius = 0;
    CGPoint topRightArcCenter,topLeftArcCenter,bottomRightArcCenter,bottomLeftArcCenter;
    
    if (rectCorner & UIRectCornerTopLeft) {
        topLeftRadius = cornerRadius;
    }
    if (rectCorner & UIRectCornerTopRight) {
        topRightRadius = cornerRadius;
    }
    if (rectCorner & UIRectCornerBottomLeft) {
        bottomLeftRadius = cornerRadius;
    }
    if (rectCorner & UIRectCornerBottomRight) {
        bottomRightRadius = cornerRadius;
    }
    
    if (arrowDirection == WPopupMenuArrowDirectionTop) {
        topLeftArcCenter = CGPointMake(topLeftRadius + WRectX(rect), arrowHeight + topLeftRadius + WRectX(rect));
        topRightArcCenter = CGPointMake(WRectWidth(rect) - topRightRadius + WRectX(rect), arrowHeight + topRightRadius + WRectX(rect));
        bottomLeftArcCenter = CGPointMake(bottomLeftRadius + WRectX(rect), WRectHeight(rect) - bottomLeftRadius + WRectX(rect));
        bottomRightArcCenter = CGPointMake(WRectWidth(rect) - bottomRightRadius + WRectX(rect), WRectHeight(rect) - bottomRightRadius + WRectX(rect));
        if (arrowPosition < topLeftRadius + arrowWidth / 2) {
            arrowPosition = topLeftRadius + arrowWidth / 2;
        } else if (arrowPosition > WRectWidth(rect) - topRightRadius - arrowWidth / 2) {
            arrowPosition = WRectWidth(rect) - topRightRadius - arrowWidth / 2;
        }
        [bezierPath moveToPoint:CGPointMake(arrowPosition - arrowWidth / 2, arrowHeight + WRectX(rect))];
        [bezierPath addLineToPoint:CGPointMake(arrowPosition, WRectTop(rect) + WRectX(rect))];
        [bezierPath addLineToPoint:CGPointMake(arrowPosition + arrowWidth / 2, arrowHeight + WRectX(rect))];
        [bezierPath addLineToPoint:CGPointMake(WRectWidth(rect) - topRightRadius, arrowHeight + WRectX(rect))];
        [bezierPath addArcWithCenter:topRightArcCenter radius:topRightRadius startAngle:M_PI * 3 / 2 endAngle:2 * M_PI clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(WRectWidth(rect) + WRectX(rect), WRectHeight(rect) - bottomRightRadius - WRectX(rect))];
        [bezierPath addArcWithCenter:bottomRightArcCenter radius:bottomRightRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(bottomLeftRadius + WRectX(rect), WRectHeight(rect) + WRectX(rect))];
        [bezierPath addArcWithCenter:bottomLeftArcCenter radius:bottomLeftRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(WRectX(rect), arrowHeight + topLeftRadius + WRectX(rect))];
        [bezierPath addArcWithCenter:topLeftArcCenter radius:topLeftRadius startAngle:M_PI endAngle:M_PI * 3 / 2 clockwise:YES];
        
    } else if (arrowDirection == WPopupMenuArrowDirectionBottom) {
        topLeftArcCenter = CGPointMake(topLeftRadius + WRectX(rect),topLeftRadius + WRectX(rect));
        topRightArcCenter = CGPointMake(WRectWidth(rect) - topRightRadius + WRectX(rect), topRightRadius + WRectX(rect));
        bottomLeftArcCenter = CGPointMake(bottomLeftRadius + WRectX(rect), WRectHeight(rect) - bottomLeftRadius + WRectX(rect) - arrowHeight);
        bottomRightArcCenter = CGPointMake(WRectWidth(rect) - bottomRightRadius + WRectX(rect), WRectHeight(rect) - bottomRightRadius + WRectX(rect) - arrowHeight);
        if (arrowPosition < bottomLeftRadius + arrowWidth / 2) {
            arrowPosition = bottomLeftRadius + arrowWidth / 2;
        } else if (arrowPosition > WRectWidth(rect) - bottomRightRadius - arrowWidth / 2) {
            arrowPosition = WRectWidth(rect) - bottomRightRadius - arrowWidth / 2;
        }
        [bezierPath moveToPoint:CGPointMake(arrowPosition + arrowWidth / 2, WRectHeight(rect) - arrowHeight + WRectX(rect))];
        [bezierPath addLineToPoint:CGPointMake(arrowPosition, WRectHeight(rect) + WRectX(rect))];
        [bezierPath addLineToPoint:CGPointMake(arrowPosition - arrowWidth / 2, WRectHeight(rect) - arrowHeight + WRectX(rect))];
        [bezierPath addLineToPoint:CGPointMake(bottomLeftRadius + WRectX(rect), WRectHeight(rect) - arrowHeight + WRectX(rect))];
        [bezierPath addArcWithCenter:bottomLeftArcCenter radius:bottomLeftRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(WRectX(rect), topLeftRadius + WRectX(rect))];
        [bezierPath addArcWithCenter:topLeftArcCenter radius:topLeftRadius startAngle:M_PI endAngle:M_PI * 3 / 2 clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(WRectWidth(rect) - topRightRadius + WRectX(rect), WRectX(rect))];
        [bezierPath addArcWithCenter:topRightArcCenter radius:topRightRadius startAngle:M_PI * 3 / 2 endAngle:2 * M_PI clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(WRectWidth(rect) + WRectX(rect), WRectHeight(rect) - bottomRightRadius - WRectX(rect) - arrowHeight)];
        [bezierPath addArcWithCenter:bottomRightArcCenter radius:bottomRightRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
        
    } else if (arrowDirection == WPopupMenuArrowDirectionLeft) {
        topLeftArcCenter = CGPointMake(topLeftRadius + WRectX(rect) + arrowHeight,topLeftRadius + WRectX(rect));
        topRightArcCenter = CGPointMake(WRectWidth(rect) - topRightRadius + WRectX(rect), topRightRadius + WRectX(rect));
        bottomLeftArcCenter = CGPointMake(bottomLeftRadius + WRectX(rect) + arrowHeight, WRectHeight(rect) - bottomLeftRadius + WRectX(rect));
        bottomRightArcCenter = CGPointMake(WRectWidth(rect) - bottomRightRadius + WRectX(rect), WRectHeight(rect) - bottomRightRadius + WRectX(rect));
        if (arrowPosition < topLeftRadius + arrowWidth / 2) {
            arrowPosition = topLeftRadius + arrowWidth / 2;
        } else if (arrowPosition > WRectHeight(rect) - bottomLeftRadius - arrowWidth / 2) {
            arrowPosition = WRectHeight(rect) - bottomLeftRadius - arrowWidth / 2;
        }
        [bezierPath moveToPoint:CGPointMake(arrowHeight + WRectX(rect), arrowPosition + arrowWidth / 2)];
        [bezierPath addLineToPoint:CGPointMake(WRectX(rect), arrowPosition)];
        [bezierPath addLineToPoint:CGPointMake(arrowHeight + WRectX(rect), arrowPosition - arrowWidth / 2)];
        [bezierPath addLineToPoint:CGPointMake(arrowHeight + WRectX(rect), topLeftRadius + WRectX(rect))];
        [bezierPath addArcWithCenter:topLeftArcCenter radius:topLeftRadius startAngle:M_PI endAngle:M_PI * 3 / 2 clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(WRectWidth(rect) - topRightRadius, WRectX(rect))];
        [bezierPath addArcWithCenter:topRightArcCenter radius:topRightRadius startAngle:M_PI * 3 / 2 endAngle:2 * M_PI clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(WRectWidth(rect) + WRectX(rect), WRectHeight(rect) - bottomRightRadius - WRectX(rect))];
        [bezierPath addArcWithCenter:bottomRightArcCenter radius:bottomRightRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(arrowHeight + bottomLeftRadius + WRectX(rect), WRectHeight(rect) + WRectX(rect))];
        [bezierPath addArcWithCenter:bottomLeftArcCenter radius:bottomLeftRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
        
    } else if (arrowDirection == WPopupMenuArrowDirectionRight) {
        topLeftArcCenter = CGPointMake(topLeftRadius + WRectX(rect),topLeftRadius + WRectX(rect));
        topRightArcCenter = CGPointMake(WRectWidth(rect) - topRightRadius + WRectX(rect) - arrowHeight, topRightRadius + WRectX(rect));
        bottomLeftArcCenter = CGPointMake(bottomLeftRadius + WRectX(rect), WRectHeight(rect) - bottomLeftRadius + WRectX(rect));
        bottomRightArcCenter = CGPointMake(WRectWidth(rect) - bottomRightRadius + WRectX(rect) - arrowHeight, WRectHeight(rect) - bottomRightRadius + WRectX(rect));
        if (arrowPosition < topRightRadius + arrowWidth / 2) {
            arrowPosition = topRightRadius + arrowWidth / 2;
        } else if (arrowPosition > WRectHeight(rect) - bottomRightRadius - arrowWidth / 2) {
            arrowPosition = WRectHeight(rect) - bottomRightRadius - arrowWidth / 2;
        }
        [bezierPath moveToPoint:CGPointMake(WRectWidth(rect) - arrowHeight + WRectX(rect), arrowPosition - arrowWidth / 2)];
        [bezierPath addLineToPoint:CGPointMake(WRectWidth(rect) + WRectX(rect), arrowPosition)];
        [bezierPath addLineToPoint:CGPointMake(WRectWidth(rect) - arrowHeight + WRectX(rect), arrowPosition + arrowWidth / 2)];
        [bezierPath addLineToPoint:CGPointMake(WRectWidth(rect) - arrowHeight + WRectX(rect), WRectHeight(rect) - bottomRightRadius - WRectX(rect))];
        [bezierPath addArcWithCenter:bottomRightArcCenter radius:bottomRightRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(bottomLeftRadius + WRectX(rect), WRectHeight(rect) + WRectX(rect))];
        [bezierPath addArcWithCenter:bottomLeftArcCenter radius:bottomLeftRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(WRectX(rect), arrowHeight + topLeftRadius + WRectX(rect))];
        [bezierPath addArcWithCenter:topLeftArcCenter radius:topLeftRadius startAngle:M_PI endAngle:M_PI * 3 / 2 clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(WRectWidth(rect) - topRightRadius + WRectX(rect) - arrowHeight, WRectX(rect))];
        [bezierPath addArcWithCenter:topRightArcCenter radius:topRightRadius startAngle:M_PI * 3 / 2 endAngle:2 * M_PI clockwise:YES];
        
    } else if (arrowDirection == WPopupMenuArrowDirectionNone) {
        topLeftArcCenter = CGPointMake(topLeftRadius + WRectX(rect),  topLeftRadius + WRectX(rect));
        topRightArcCenter = CGPointMake(WRectWidth(rect) - topRightRadius + WRectX(rect),  topRightRadius + WRectX(rect));
        bottomLeftArcCenter = CGPointMake(bottomLeftRadius + WRectX(rect), WRectHeight(rect) - bottomLeftRadius + WRectX(rect));
        bottomRightArcCenter = CGPointMake(WRectWidth(rect) - bottomRightRadius + WRectX(rect), WRectHeight(rect) - bottomRightRadius + WRectX(rect));
        [bezierPath moveToPoint:CGPointMake(topLeftRadius + WRectX(rect), WRectX(rect))];
        [bezierPath addLineToPoint:CGPointMake(WRectWidth(rect) - topRightRadius, WRectX(rect))];
        [bezierPath addArcWithCenter:topRightArcCenter radius:topRightRadius startAngle:M_PI * 3 / 2 endAngle:2 * M_PI clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(WRectWidth(rect) + WRectX(rect), WRectHeight(rect) - bottomRightRadius - WRectX(rect))];
        [bezierPath addArcWithCenter:bottomRightArcCenter radius:bottomRightRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(bottomLeftRadius + WRectX(rect), WRectHeight(rect) + WRectX(rect))];
        [bezierPath addArcWithCenter:bottomLeftArcCenter radius:bottomLeftRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(WRectX(rect), arrowHeight + topLeftRadius + WRectX(rect))];
        [bezierPath addArcWithCenter:topLeftArcCenter radius:topLeftRadius startAngle:M_PI endAngle:M_PI * 3 / 2 clockwise:YES];
    }
    
    [bezierPath closePath];
    return bezierPath;
}




@end
