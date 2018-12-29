//
//  HttpRequestManager.h
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/31.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//
/*!
 *  上传进度
 *
 *  @param bytesWritten              已上传的大小
 *  @param totalBytesWritten         总上传大小
 */
typedef void (^HYBUploadProgress)(int64_t bytesWritten,
                                  int64_t totalBytesWritten);

typedef void(^HYBResponseSuccess)(id response);
typedef void(^HYBResponseFail)(NSError *error);



#import <Foundation/Foundation.h>

typedef void (^DowloadBlackSuccess)(AFHTTPSessionManager *sessionManger,id responseObject);



@interface HttpRequestManager : NSObject

@property(nonatomic,strong) AFHTTPSessionManager * sessionManger;



+(instancetype)sharedSingleton;

/**
 *   请求数据接口
 */
-(NSString *)getStr:(NSString *)url;

/**
 *   GET 请求
 */
-(NSURLSessionDataTask *)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask * task, id responseObject))success failure:( void (^)(NSURLSessionDataTask * task, NSError * error))failure;

/**
 *  post 请求
 */


- (NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask * task, id responseObject))success failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;

/**
 *  upload 请求
 */

- (NSURLSessionTask *)uploadWithSingleImage:(UIImage *)image
                                        url:(NSString *)url
                                       name:(NSString *)name
                                 parameters:(NSDictionary *)parameters
                                   progress:(HYBUploadProgress)progress
                                    success:(HYBResponseSuccess)success
                                       fail:(HYBResponseFail)fail;

- (NSURLSessionTask *)uploadWithImages:(NSMutableArray *)images
                                   url:(NSString *)url
                                  name:(NSString *)name
                            parameters:(NSDictionary *)parameters
                              progress:(HYBUploadProgress)progress
                               success:(HYBResponseSuccess)success
                                  fail:(HYBResponseFail)fail;

@end
