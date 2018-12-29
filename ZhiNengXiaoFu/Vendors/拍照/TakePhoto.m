//
//  TakePhoto.m
//  TakePhotoDemo
//
//  Created by ios on 2018/1/4.
//  Copyright © 2018年 LuoDong. All rights reserved.
//

#import "TakePhoto.h"

@interface TakePhoto()<UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end
@implementation TakePhoto

+ (TakePhoto *)sharedModel{
    static TakePhoto *sharedModel = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        sharedModel = [[self alloc] init];
    });
    return sharedModel;
}

+(void)sharePictureWith:(UIViewController *)controller andWith:(sendPictureBlock)block{
    
    TakePhoto *tP = [TakePhoto sharedModel];
    tP.sPictureBlock =block;
    // 跳转到相机或相册页面
   UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.allowsEditing = YES;
    picker.delegate = tP;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *al = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            //进入照相
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [controller presentViewController:picker animated:YES completion:nil];
        } else {
            ShowMessage(@"相机不可用");
        }
    }];
    UIAlertAction *a2 = [UIAlertAction actionWithTitle:@"选择本地相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            //进入相册
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [controller presentViewController:picker animated:YES completion:nil];
        } else {
            ShowMessage(@"相册不可用");
        }
    }];
    UIAlertAction *a3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:al];
    [alert addAction:a2];
    [alert addAction:a3];
    
    [controller presentViewController:alert animated:YES completion:nil];
}


#pragma mark - image picker delegte

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    TakePhoto *TPhoto = [TakePhoto sharedModel];
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [TPhoto sPictureBlock](image);
    
}


//弹出消息框来显示消息
void ShowMessage(NSString* message)
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
    [alertView show];
}

@end
