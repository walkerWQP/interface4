//
//  Encryption.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/31.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "Encryption.h"
#import <CommonCrypto/CommonDigest.h>

//秘钥
static NSString *encryptionKey = @"duxiu2018";
@implementation Encryption


+ (NSString *)md5EncryptWithString:(NSString *)string {
    return [self md5:[NSString stringWithFormat:@"%@", string]];
}

+ (NSString *)md5EncryptWithString {
    return [self md5:[NSString stringWithFormat:@"%@%@", @"ios", encryptionKey]];
}


+ (NSString *)md5:(NSString *)string {
    const char *cStr = [string UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02X", digest[i]];
    }
    
    return result;
}

#pragma mark - 32位 小写
+ (NSString *)MD5ForLower32Bate:(NSString *)str {
    
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    
    return digest;
}


@end
