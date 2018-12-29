//
//  HttpRequestManager.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/31.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#define RESPONSE_CONTENT_TYPE [NSSet setWithObjects:@"application/json",@"text/html",@"text/json",@"text/plain",@"text/javascript",@"text/xml",@"image/*",nil]

#import "HttpRequestManager.h"

@implementation HttpRequestManager

+ (instancetype)sharedSingleton {
    static HttpRequestManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HttpRequestManager alloc]init];
    });
    return manager;
}


- (id)init {
    self =[super init];
    if (self) {
        _sessionManger = [AFHTTPSessionManager manager];
        _sessionManger.responseSerializer.acceptableContentTypes =RESPONSE_CONTENT_TYPE;
        _sessionManger.requestSerializer = [AFHTTPRequestSerializer serializer];
        _sessionManger.requestSerializer.timeoutInterval = 60;
    }
    
    return self;
}

-(NSString *)getStr:(NSString *)url {
    return url;
}
/**
 *  get请求
 */
- (NSURLSessionTask *)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask * task, id responseObject))success failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure {
    
    NSMutableDictionary *mutableParmeters = [[NSMutableDictionary alloc]initWithDictionary:parameters];
    
    NSURLSessionDataTask * dataTask = [_sessionManger GET:URLString parameters:mutableParmeters progress:nil success:^(NSURLSessionDataTask *  task, id  responseObject) {
                                           
                                           success(task, responseObject);
                                           
                                       } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
                                           
                                           failure(task,error);
                                       }];
    //    [_sessionManger GET:URLString parameters:mutableParmeters progress:nil success:success failure:failure];
    return dataTask;
    
}

/**
 *  post
 */
- (NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask * task, id responseObject))success failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure {
    
    NSMutableDictionary *mutableParmerts = [[NSMutableDictionary alloc]initWithDictionary:parameters];
    NSURLSessionDataTask * dataTask = [_sessionManger POST:URLString parameters:mutableParmerts progress:nil success:^(NSURLSessionDataTask *  task, id  responseObject)
                                       {
                                           
                                           
                                           success(task, responseObject);
                                           
                                       } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
                                           
                                           failure(task,error);
                                       }];

    return dataTask;
    
}

/**
 * upload
 *    图片上传接口，若不指定baseurl，可传完整的url
 *
 *    @param image            图片对象
 *    @param url                上传图片的接口路径，如/path/images/
 *    @param filename        给图片起一个名字，默认为当前日期时间,格式为"yyyyMMddHHmmss"，后缀为`jpg`
 *    @param name                与指定的图片相关联的名称，这是由后端写接口的人指定的，如imagefiles
 *    @param mimeType        默认为image/jpeg
 *    @param parameters    参数
 *    @param progress        上传进度
 *    @param success        上传成功回调
 *    @param fail                上传失败回调
 *
 *    @return
 
 */

- (NSURLSessionTask *)uploadWithSingleImage:(UIImage *)image
                                        url:(NSString *)url
                                       name:(NSString *)name
                                 parameters:(NSDictionary *)parameters
                                   progress:(HYBUploadProgress)progress
                                    success:(HYBResponseSuccess)success
                                       fail:(HYBResponseFail)fail {
    
    
    NSString * finallString = [NSString stringWithFormat:@"%@",url];
    
    NSURLSessionTask *session = [_sessionManger POST:finallString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
        //        NSData *imageData = UIImageJPEGRepresentation(image, 1);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *imageFileName = [NSString stringWithFormat:@"%@.jpeg", str];
        // 上传图片，以文件流的格式 image/jpg/png/jpeg
        [formData appendPartWithFileData:imageData name:name fileName:imageFileName mimeType:@"image/jpeg"];
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        fail(error);
        
    }];
    
    return session;
}



- (NSURLSessionTask *)uploadWithImages:(NSMutableArray *)images
                                   url:(NSString *)url
                                  name:(NSString *)name
                            parameters:(NSDictionary *)parameters
                              progress:(HYBUploadProgress)progress
                               success:(HYBResponseSuccess)success
                                  fail:(HYBResponseFail)fail {
    
    
    NSString * finallString = [NSString stringWithFormat:@"%@",url];
    
    
    NSURLSessionTask *session = [_sessionManger POST:finallString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i=0; i< images.count; i++) {
            
            UIImage *image = images[i];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            //        NSData *imageData = UIImageJPEGRepresentation(image, 1);
            
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString * imageFileName = [NSString stringWithFormat:@"%@.jpeg", str];
            
            // 上传图片，以文件流的格式 image/jpg/png/jpeg
            [formData appendPartWithFileData:imageData name:name fileName:imageFileName mimeType:@"image/jpeg"];
            
            
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        fail(error);
        
    }];
    
    return session;
}

@end
