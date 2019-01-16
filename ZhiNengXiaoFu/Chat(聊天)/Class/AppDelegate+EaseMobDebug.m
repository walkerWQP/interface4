/************************************************************
 *  * Hyphenate CONFIDENTIAL
 * __________________
 * Copyright (C) 2016 Hyphenate Inc. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of Hyphenate Inc.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Hyphenate Inc.
 */

#import "AppDelegate+EaseMobDebug.h"

#import <Hyphenate/EMOptions+PrivateDeploy.h>

#warning Internal testing, developers do not need to use

@implementation AppDelegate (EaseMobDebug)

-(BOOL)isSpecifyServer
{
    
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    NSNumber *specifyServer = [ud objectForKey:@"identifier_specifyserver"];
    if (![specifyServer boolValue]) {
        return NO;
    }
    
    NSString *apnsCertName = [ud stringForKey:@"identifier_apnsname"];
    if ([apnsCertName length] == 0) {
#if DEBUG
        apnsCertName = @"demoappstore-dev";
#else
        apnsCertName = @"demoappstore";
#endif
        [ud setObject:apnsCertName forKey:@"identifier_apnsname"];
    }
    
    NSString *appkey = [ud stringForKey:@"identifier_appkey"];
    if ([appkey length] == 0)
    {
        appkey = @"1101181224097655#duxiu-keji-2018";
        [ud setObject:appkey forKey:@"identifier_appkey"];
    }
    
    NSString *imServer = [ud stringForKey:@"identifier_imserver"];
    if ([imServer length] == 0)
    {
        imServer = @"";
        [ud setObject:imServer forKey:@"identifier_imserver"];
    }
    
    NSString *imPort = [ud stringForKey:@"identifier_import"];
    if ([imPort length] == 0)
    {
        imPort = @"6717";
        [ud setObject:imPort forKey:@"identifier_import"];
    }
    
    NSString *restServer = [ud stringForKey:@"identifier_restserver"];
    if ([restServer length] == 0)
    {
        restServer = @"";
        [ud setObject:restServer forKey:@"identifier_restserver"];
    }
    
    BOOL isHttpsOnly = NO;
    NSNumber *httpsOnly = [ud objectForKey:@"identifier_httpsonly"];
    if (httpsOnly) {
        isHttpsOnly = [httpsOnly boolValue];
    }
    
    [ud synchronize];
    
    EMOptions *options = [EMOptions optionsWithAppkey:appkey];
    if (![ud boolForKey:@"enable_dns"])
    {
        options.enableDnsConfig = NO;
        options.chatPort = [[ud stringForKey:@"identifier_import"] intValue];
        options.chatServer = [ud stringForKey:@"identifier_imserver"];
        options.restServer = [ud stringForKey:@"identifier_restserver"];
    }
    options.apnsCertName = @"demoappstore-dev";
    options.enableConsoleLog = YES;
    options.usingHttpsOnly = isHttpsOnly;
    
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    return YES;
}

@end
