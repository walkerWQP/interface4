//
//  DemoCallManager.h
//  ChatDemo-UI3.0
//
//  Created by XieYajie on 22/11/2016.
//  Copyright © 2016 XieYajie. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Hyphenate/Hyphenate.h>
#import "EMCallOptions+NSCoding.h"

@class TotalTabBarController;
@interface DemoCallManager : NSObject

#if DEMO_CALL == 1

@property (nonatomic) BOOL isCalling;

@property (strong, nonatomic) TotalTabBarController *mainController;

+ (instancetype)sharedManager;

- (void)answerCall:(NSString *)aCallId;

- (void)endCallWithId:(NSString *)aCallId
               reason:(EMCallEndReason)aReason;

- (void)saveCallOptions;

#endif

@end
