//
//  NewDynamicsLayout.h
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/9/5.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DynamicsModel.h"

#define kDynamicsNormalPadding 15
#define kDynamicsPortraitWidthAndHeight 45
#define kDynamicsPortraitNamePadding 10
#define kDynamicsNameDetailPadding 8
#define kDynamicsNameHeight 17
#define kDynamicsMoreLessButtonHeight 30
#define kDynamicsSpreadButtonHeight 20
#define kDynamicsGrayBgHeight 51
#define kDynamicsGrayPicHeight 45
#define kDynamicsGrayPicPadding 3
#define kDynamicsThumbTopPadding 10


#define kDynamicsLineSpacing 5

typedef void(^ClickUserBlock)(NSString * userID);
typedef void(^ClickUrlBlock)(NSString * url);
typedef void(^ClickPhoneNumBlock)(NSString * phoneNum);

@interface NewDynamicsLayout : NSObject

@property(nonatomic,strong)DynamicsModel * model;

@property(nonatomic,strong)YYTextLayout *detailLayout;
@property(nonatomic,assign)CGSize photoContainerSize;
@property(nonatomic,strong)YYTextLayout *dspLayout;
@property(nonatomic,strong)YYTextLayout * thumbLayout;
@property(nonatomic,strong)NSMutableArray * commentLayoutArr;
@property(nonatomic,assign)CGFloat thumbHeight;
@property(nonatomic,assign)CGFloat commentHeight;
@property(nonatomic,assign)CGFloat thumbCommentHeight;
@property(nonatomic,copy)ClickUserBlock clickUserBlock;
@property(nonatomic,copy)ClickUrlBlock clickUrlBlock;
@property(nonatomic,copy)ClickPhoneNumBlock clickPhoneNumBlock;

@property(nonatomic,assign)CGFloat height;

- (instancetype)initWithModel:(DynamicsModel *)model;
- (void)resetLayout;

@property (nonatomic, strong) NSString    *userNameStr;

@property (nonatomic, strong) PersonInformationModel * personInfo;

@end

