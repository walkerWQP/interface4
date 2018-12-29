//
//  SingletonHelper.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/31.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "SingletonHelper.h"

@implementation SingletonHelper

+ (SingletonHelper *)manager {
    static SingletonHelper *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[SingletonHelper alloc]  init];
    });
    return helper;
}

- (NSMutableArray *)yidaoAry {
    if (!_yidaoAry) {
        self.yidaoAry = [@[]mutableCopy];
    }
    return _yidaoAry;
}

- (NSMutableArray *)weidaoAry {
    if (!_weidaoAry) {
        self.weidaoAry = [@[]mutableCopy];
    }
    return _weidaoAry;
}

- (NSString *)encode:(NSString *)string {
    //先将string转换成data
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSData *base64Data = [data base64EncodedDataWithOptions:0];
    NSString *baseString = [[NSString alloc]initWithData:base64Data encoding:NSUTF8StringEncoding];
    return baseString;
}

- (NSString *)dencode:(NSString *)base64String {
    //NSData *base64data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [[NSData alloc]initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    return string;
}


@end
