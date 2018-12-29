//
//  TakePhoto.h
//  TakePhotoDemo
//
//  Created by ios on 2018/1/4.
//  Copyright © 2018年 LuoDong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//使用block 返回值
typedef void (^sendPictureBlock)(UIImage *image);
@interface TakePhoto : NSObject
@property (nonatomic,copy)sendPictureBlock sPictureBlock;

+ (TakePhoto *)sharedModel;
+(void)sharePictureWith:(UIViewController *)controller andWith:(sendPictureBlock)block;

@end
