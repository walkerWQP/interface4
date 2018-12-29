//
//  LQPhotoPickerViewController.h
//  LQPhotoPicker
//
//  Created by lawchat on 15/9/22.
//  Copyright (c) 2015年 Fillinse. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol LQPhotoPickerViewDelegate <NSObject>

@optional
/***
 *  选择图片过程中更新 collectionView 的高度会调用该方法
 */
- (void)LQPhotoPicker_pickerViewFrameChanged;

@end

@interface LQPhotoPickerViewController : UIViewController


@property(nonatomic,assign) id<LQPhotoPickerViewDelegate> LQPhotoPicker_delegate;


/***
 *  pickerView所在view
 */
@property(nonatomic,strong) UIView *LQPhotoPicker_superView;


/***
 *  图片总数量限制
 */
@property(nonatomic,assign) NSInteger LQPhotoPicker_imgMaxCount;


/***
 *  初始化collectionView
 */
- (void)LQPhotoPicker_initPickerView;


/***
 *  修改collectionView 的位置
 */
- (void)LQPhotoPicker_updatePickerViewFrameY:(CGFloat)Y;


/***
 *  获得collectionView 的 Frame
 */
- (CGRect)LQPhotoPicker_getPickerViewFrame;


/***
 *  选择的图片数据(ALAsset)
 */
@property(nonatomic,strong) NSMutableArray *LQPhotoPicker_selectedAssetArray;
- (NSMutableArray*)LQPhotoPicker_getALAssetArray;


/***
 *  方形压缩图image 数组
 */
@property(nonatomic,strong) NSMutableArray<UIImage*> * LQPhotoPicker_smallImageArray;
- (NSMutableArray*)LQPhotoPicker_getSmallImageArray;


/**
 *  方形压缩图data 数组
 */
- (void)LQPhotoPicker_getSmallDataImageArray;//调用后，所有图片对应的小图的 NSData类型的数据全都保存在LQPhotoPicker_smallDataImageArray里面。方法请在特定条件使用，例如需要上传图片前请先调用对应方法获得对应数据（方法调用只需要一次）
@property(nonatomic,strong,readonly) NSMutableArray<NSData*> * LQPhotoPicker_smallImgDataArray;


/**
 *  大图image 数组
 */
- (void)LQPhotoPicker_getBigImageArray;//调用后，所有图片对应的大图的 UIImage类型的数据全都保存在LQPhotoPicker_bigImageArray里面。方法请在特定条件使用，例如需要上传图片前请先调用对应方法获得对应数据（方法调用只需要一次）
@property(nonatomic,strong) NSMutableArray<UIImage*>  * LQPhotoPicker_bigImageArray;


/**
 *  大图data 数组
 */
- (void)LQPhotoPicker_getBigImageDataArray;//调用后，所有图片对应的大图的 NSData类型的数据全都保存在LQPhotoPicker_bigImgDataArray里面。方法请在特定条件使用，例如需要上传图片前请先调用对应方法获得对应数据（方法调用只需要一次）
@property(nonatomic,strong,readonly) NSMutableArray<NSData*> * LQPhotoPicker_bigImgDataArray;







@end
