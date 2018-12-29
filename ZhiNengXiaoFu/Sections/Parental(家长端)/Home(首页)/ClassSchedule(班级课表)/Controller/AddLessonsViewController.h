//
//  AddLessonsViewController.h
//  ZhiNengXiaoFu
//
//  Created by 独秀科技 on 2018/12/18.
//  Copyright © 2018 henanduxiu. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddLessonsViewController : BaseViewController

@property (nonatomic, strong) NSString   *class_id;
@property (nonatomic, strong) NSString   *begintStr;
@property (nonatomic, strong) NSString   *endStr;
@property (nonatomic, strong) NSString   *typeStr;

@end

NS_ASSUME_NONNULL_END
