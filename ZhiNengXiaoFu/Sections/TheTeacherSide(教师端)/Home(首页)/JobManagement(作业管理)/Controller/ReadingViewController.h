//
//  ReadingViewController.h
//  ZhiNengXiaoFu
//
//  Created by 独秀科技 on 2018/12/25.
//  Copyright © 2018 henanduxiu. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReadingViewController : BaseViewController

//1通知2作业
@property (nonatomic, strong) NSString   *type;
@property (nonatomic, strong) NSString   *ID;
@property (nonatomic, strong) NSString   *class_id;


@end

NS_ASSUME_NONNULL_END
