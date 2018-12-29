//
//  DynamicsModel.h
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/9/5.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DynamicsLikeItemModel,DynamicsCommentItemModel,NewDynamicsLayout;

@interface DynamicsModel : NSObject

@property (nonatomic, assign) NSInteger      album_id;
@property (nonatomic, strong) NSString       *name;
@property (nonatomic, strong) NSString       *head_img;
@property (nonatomic, assign) NSInteger      user_id;
@property (nonatomic, strong) NSString       *content;
@property (nonatomic, copy) NSMutableArray   *img;
@property (nonatomic, strong) NSString       *create_time;
@property (nonatomic, strong) NSMutableArray *praise;
@property (nonatomic, strong) NSMutableArray *discuss;
@property (nonatomic, assign) NSInteger      is_praise;
@property (nonatomic, assign) NSInteger      is_myself;
@property (nonatomic, strong) NSString       *type;

@property(nonatomic,strong)NSMutableArray *optthumb;//点赞数组
@property(nonatomic,strong)NSMutableArray *optcomment;//评论数组
@property(nonatomic,strong)NSMutableArray<DynamicsLikeItemModel *> * likeArr;//存放Model点赞数组
@property(nonatomic,strong)NSMutableArray<DynamicsCommentItemModel *> * commentArr;//存放Model评论数组
@property(nonatomic,strong)NSData * photocollectionsData;//照片数组(存入数据库)
@property(nonatomic,assign)int pagetype;//动态类型(0:普通动态,1:头条动态)



@property (nonatomic, assign) BOOL isOpening;//已展开文字
@property (nonatomic, assign, readonly) BOOL shouldShowMoreButton;//应该显示"全文"
@property(nonatomic,assign)BOOL isThumb;//已点赞

@end

@interface DynamicsLikeItemModel : NSObject

@property (nonatomic, strong) NSString  *praise_id;  //点赞id
@property (nonatomic, assign) NSInteger praise_user_id; //点赞人id
@property (nonatomic, strong) NSString  *praise_head_img; //点赞人头像
@property (nonatomic, strong) NSString  *praise_name; //点赞人姓名
@property (nonatomic, assign) NSInteger praise_identity;  //点赞人身份1家长2教师


@property (nonatomic, copy) NSAttributedString *attributedContent;
@end

@interface DynamicsCommentItemModel : NSObject

@property (nonatomic, strong) NSString   *discuss_content;//评论内容
@property (nonatomic, strong) NSString   *discuss_id; //评论id
@property (nonatomic, assign) NSInteger  discuss_user_id; //评论人id
@property (nonatomic, strong) NSString   *discuss_head_img; //评论人头像
@property (nonatomic, strong) NSString   *discuss_name; //评论人名字
@property (nonatomic, assign) NSInteger  discuss_identity; //评论人身份1家长2教师
@property (nonatomic, strong) NSString   *discuss_create_time; //评论时间
@property (nonatomic, assign) NSInteger  discuss_is_self; //是否是自己的评论0否1是
@property(nonatomic,copy)NSString * message;


@property(nonatomic,assign)float commentCellHeight;




@end
