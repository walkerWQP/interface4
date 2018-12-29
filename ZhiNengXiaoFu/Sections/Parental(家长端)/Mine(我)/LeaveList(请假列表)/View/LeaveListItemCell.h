//
//  LeaveListItemCell.h
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/24.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaveListItemCell : UITableViewCell

//个人请假情况
@property (nonatomic, strong) UILabel *titleLabel;
//请假时间
@property (nonatomic, strong) UILabel *LeaveTimeLabel;
//请假原因
@property (nonatomic, strong) UILabel *LeaveReasonLabel;
//请假状态
@property (nonatomic, strong) UILabel *stateLabel;
//粉色圈圈
@property (nonatomic, strong) UIView  *fenQuan;
//绿色圈圈
@property (nonatomic, strong) UIView  *lvQuan;
//线
@property (nonatomic, strong) UIView  *lineView;


@end
