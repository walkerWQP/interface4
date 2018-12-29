//
//  WorkDetailsViewController.h
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/8/2.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkDetailsViewController : UIViewController

@property (nonatomic, copy) NSString     *workId;
@property (nonatomic, strong) NSString   *typeID;
@property (nonatomic, strong) NSString   *ID;
@property (nonatomic, strong) NSString   *titleStr;
@property (nonatomic, strong) NSString   *content;

@end
