//
//  NewDynamicsViewController.h
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/9/5.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewDynamicsViewController : UIViewController

@property(nonatomic,copy)NSString         *dynamicsUserId;
@property(nonatomic,strong)UITableView    *dynamicsTable;
@property(nonatomic,strong)NSMutableArray *layoutsArr;
@property(nonatomic,copy)NSString         *toUserName;
@property(nonatomic,assign)NSIndexPath    *commentIndexPath;
@property(nonatomic,strong)UITextField    *commentInputTF;

@property (nonatomic, strong) NSString    *classID;
@property (nonatomic, strong) NSString    *className;
@property (nonatomic, strong) NSString    *typeStr;

@end
