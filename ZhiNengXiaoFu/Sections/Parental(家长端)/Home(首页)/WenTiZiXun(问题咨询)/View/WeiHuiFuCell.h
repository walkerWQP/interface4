//
//  WeiHuiFuCell.h
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/8/4.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeiHuiFuCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *WeiHuiFuUserIconImg;
@property (weak, nonatomic) IBOutlet UILabel     *WeiHuiFuNameLabel;
@property (weak, nonatomic) IBOutlet UILabel     *WeiHuiFuQuestionLabel;
@property (weak, nonatomic) IBOutlet UIButton    *WeiHuiFuBtn;
@property (weak, nonatomic) IBOutlet UIView      *WeiHuiFuLineView;

@end
