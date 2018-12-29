//
//  JiuQinItemCell.h
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/8/29.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JiuQinItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel     *JiuQinItemNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *JiuQinItemStateImg;
@property (weak, nonatomic) IBOutlet UIImageView *JiuQinItemStateTwoImg;
@property (weak, nonatomic) IBOutlet UILabel     *JiuQinItemXingQiLabel;
@property (weak, nonatomic) IBOutlet UILabel     *JiuQinItemTimeLabel;

@end
