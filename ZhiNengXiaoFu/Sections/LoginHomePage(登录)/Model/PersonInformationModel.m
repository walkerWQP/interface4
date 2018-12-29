//
//  PersonInformationModel.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/31.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "PersonInformationModel.h"
#import <MJExtension/MJExtension.h>
@implementation PersonInformationModel

+ (NSDictionary *)replacedKeyFromPropertyName {
    
    return @{@"ID": @"id"};
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        
        self.ID           = [aDecoder decodeObjectForKey:@"ID"];
        self.head_img     = [aDecoder decodeObjectForKey:@"head_img"];
        self.mobile       = [aDecoder decodeObjectForKey:@"mobile"];
        self.class_id     = [aDecoder decodeIntegerForKey:@"class_id"];
        self.name         = [aDecoder decodeObjectForKey:@"name"];
        self.nature       = [aDecoder decodeIntegerForKey:@"nature"];
        self.password     = [aDecoder decodeObjectForKey:@"password"];
        self.school_id    = [aDecoder decodeIntegerForKey:@"school_id"];
        self.sex          = [aDecoder decodeIntegerForKey:@"sex"];
        self.token        = [aDecoder decodeObjectForKey:@"token"];
        self.usernum      = [aDecoder decodeObjectForKey:@"usernum"];
        self.class_name_s = [aDecoder decodeObjectForKey:@"class_name_s"];
        self.class_name_t = [aDecoder decodeObjectForKey:@"class_name_t"];
        self.school_name  = [aDecoder decodeObjectForKey:@"school_name"];

    }
    return self;
}
//归档
- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.ID forKey:@"ID"];
    [aCoder encodeObject:self.head_img forKey:@"head_img"];
    [aCoder encodeObject:self.mobile forKey:@"mobile"];
    [aCoder encodeInteger:self.class_id forKey:@"class_id"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInteger:self.nature  forKey:@"nature"];
    [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeInteger:self.school_id forKey:@"school_id"];
    [aCoder encodeInteger:self.sex forKey:@"sex"];
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.usernum forKey:@"usernum"];
    [aCoder encodeObject:self.class_name_s forKey:@"class_name_s"];
    [aCoder encodeObject:self.school_name forKey:@"school_name"];
    [aCoder encodeObject:self.class_name_t forKey:@"class_name_t"];

}

@end
