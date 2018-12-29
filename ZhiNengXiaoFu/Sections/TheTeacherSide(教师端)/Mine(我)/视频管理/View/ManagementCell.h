//
//  ManagementCell.h
//  ZhiNengXiaoFu
//
//  Created by 独秀科技 on 2018/12/6.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ManagementCell : UITableViewCell

@property (nonatomic, strong) UIView     *lineView;
@property (nonatomic, strong) UILabel    *videoNameLabel;
@property (nonatomic, strong) UILabel    *numLabel;
@property (nonatomic, strong) UILabel    *classLabel;
@property (nonatomic, strong) UILabel    *auditLabel;
@property (nonatomic, strong) UILabel    *typeLabel;


@end

NS_ASSUME_NONNULL_END
