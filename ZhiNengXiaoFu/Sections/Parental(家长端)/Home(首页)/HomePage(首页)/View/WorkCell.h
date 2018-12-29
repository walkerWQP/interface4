//
//  WorkCell.h
//  ZhiNengXiaoFu
//
//  Created by 独秀科技 on 2018/10/9.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WorkCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *WorkImg;
@property (weak, nonatomic) IBOutlet UILabel     *WorkTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel     *WorkConnectLabel;
@property (weak, nonatomic) IBOutlet UILabel     *WorkTimeLabel;

@end

NS_ASSUME_NONNULL_END
