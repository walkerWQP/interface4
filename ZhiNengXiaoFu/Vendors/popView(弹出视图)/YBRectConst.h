//
//  YBRectMake.h
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_STATIC_INLINE CGFloat WRectWidth(CGRect rect)
{
    return rect.size.width;
}

UIKIT_STATIC_INLINE CGFloat WRectHeight(CGRect rect)
{
    return rect.size.height;
}

UIKIT_STATIC_INLINE CGFloat WRectX(CGRect rect)
{
    return rect.origin.x;
}

UIKIT_STATIC_INLINE CGFloat WRectY(CGRect rect)
{
    return rect.origin.y;
}

UIKIT_STATIC_INLINE CGFloat WRectTop(CGRect rect)
{
    return rect.origin.y;
}

UIKIT_STATIC_INLINE CGFloat WRectBottom(CGRect rect)
{
    return rect.origin.y + rect.size.height;
}

UIKIT_STATIC_INLINE CGFloat WRectLeft(CGRect rect)
{
    return rect.origin.x;
}

UIKIT_STATIC_INLINE CGFloat WRectRight(CGRect rect)
{
    return rect.origin.x + rect.size.width;
}





