//
//  ClassListCell.h
//  ZhiNengXiaoFu
//
//  Created by 独秀科技 on 2018/12/18.
//  Copyright © 2018 henanduxiu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ClassListCell : UITableViewCell

@property (nonatomic, strong) UIButton        *numBtn;
@property (nonatomic, strong) UILabel         *timeLabel;
@property (nonatomic, strong) UIButton        *changBtn;
@property (nonatomic, strong) UIButton        *delegateBtn;

@end

NS_ASSUME_NONNULL_END
