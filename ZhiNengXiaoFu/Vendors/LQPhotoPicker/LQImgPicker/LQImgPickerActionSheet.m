//
//  LQImgPickerActionSheet.m
//  QQImagePicker
//
//  Created by lawchat on 15/9/23.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "LQImgPickerActionSheet.h"
#import <Photos/Photos.h>
@implementation LQImgPickerActionSheet

- (instancetype)init
{
    self = [super init];
    if (self) {
        if (!_arrSelected) {
            self.arrSelected = [NSMutableArray array];
        }
    }
    return self;
}

#pragma mark - 显示选择照片提示sheet
- (void)showImgPickerActionSheetInView:(UIViewController*)controller{
    viewController = controller;
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        

        //判断是否具有相机权限
     if ([JurisdictionMethod videoJurisdiction]) {
            //打开照相机拍照
         if ([JurisdictionMethod libraryJurisdiction]) {
             
         
                  if (!imaPic) {
                      imaPic = [[UIImagePickerController alloc] init];
                  }
                  if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                      imaPic.sourceType = UIImagePickerControllerSourceTypeCamera;
                      imaPic.delegate = self;
                      [viewController presentViewController:imaPic animated:YES completion:nil];
                  }
           }else
           {
               [[JurisdictionMethod shareJurisdictionMethod] libraryJurisdictionAlert];

           }
          
        }else{
            [[JurisdictionMethod shareJurisdictionMethod] photoJurisdictionAlert];
        }
        
       
    }]];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //判断是否具有相机权限
        if ([JurisdictionMethod libraryJurisdiction]) {
            //打开图库
            [self loadImgDataAndShowAllGroup];
        }else{
            [[JurisdictionMethod shareJurisdictionMethod] libraryJurisdictionAlert];
        }
        
    }]];
    
    
    [controller presentViewController:alertVC animated:YES completion:nil];

}


#pragma mark - 加载照片数据
- (void)loadImgDataAndShowAllGroup{
    if (!_arrSelected) {
        self.arrSelected = [NSMutableArray array];
    }
    [[MImaLibTool shareMImaLibTool] getAllGroupWithArrObj:^(NSArray *arrObj) {
        if (arrObj && arrObj.count > 0) {
            self.arrGroup = arrObj;
            if ( self.arrGroup.count > 0) {
                MShowAllGroup *svc = [[MShowAllGroup alloc] initWithArrGroup:self.arrGroup arrSelected:self.arrSelected];
                svc.delegate = self;
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:svc];
                if (_arrSelected) {
                    svc.arrSeleted = _arrSelected;
                    svc.mvc.arrSelected = _arrSelected;
                }
                svc.maxCout = _maxCount;
                [viewController presentViewController:nav animated:YES completion:nil];
            }
        }
    }];
}


#pragma mark - 相机拍照得到的UIImage
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *theImage = nil;
    // 判断，图片是否允许修改
    if ([picker allowsEditing]){
        //获取用户编辑之后的图像
        theImage = [info objectForKey:UIImagePickerControllerEditedImage];
    } else {
        // 照片的元数据参数
        theImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        
    }
//    NSData * imageData = UIImageJPEGRepresentation(theImage,1);
//
//    NSInteger length = [imageData length]/1024;
    
    
    
    NSData * dataN = [LQImgPickerActionSheet imageCompressToData:theImage];
    UIImage *imageN = [UIImage imageWithData: dataN];
    
    
    
    if (imageN) {
        // 保存图片到相册中
        MImaLibTool *imgLibTool = [MImaLibTool shareMImaLibTool];
        
            
            
        [imgLibTool.lib writeImageToSavedPhotosAlbum:[imageN CGImage] orientation:(ALAssetOrientation)[imageN imageOrientation] completionBlock:^(NSURL *assetURL, NSError *error){
            if (error) {

             [picker dismissViewControllerAnimated:NO completion:nil];

            } else {
                
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

                //获取图片路径
                [imgLibTool.lib assetForURL:assetURL resultBlock:^(ALAsset *asset) {
                    if (asset) {
                    
                        [_arrSelected addObject:asset];
                        [self finishSelectImg];
                        [picker dismissViewControllerAnimated:YES completion:nil];

                   }
                    
                } failureBlock:^(NSError *error) {

                      [picker dismissViewControllerAnimated:NO completion:nil];

                }];
                });
            }
        }];
        

    }
}


///压缩图片
+ (NSData *)imageCompressToData:(UIImage *)image{
    NSData *data=UIImageJPEGRepresentation(image, 1.0);
    if (data.length>300*1024) {
        if (data.length>1024*1024) {//1M以及以上
            data=UIImageJPEGRepresentation(image, 0.1);
        }else if (data.length>512*1024) {//0.5M-1M
            data=UIImageJPEGRepresentation(image, 0.5);
        }else if (data.length>300*1024) {//0.25M-0.5M
            data=UIImageJPEGRepresentation(image, 0.9);
        }
    }
    return data;
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - 完成选择后返回的图片Array(ALAsset*)
- (void)finishSelectImg{
    //正方形缩略图
    NSMutableArray *thumbnailImgArr = [NSMutableArray array];
    
    for (ALAsset *set in _arrSelected) {
        CGImageRef cgImg = [set thumbnail];
        UIImage* image = [UIImage imageWithCGImage: cgImg];
        [thumbnailImgArr addObject:image];
    }

    [self.delegate  getSelectImgWithALAssetArray:_arrSelected thumbnailImgImageArray:thumbnailImgArr];
}

@end
