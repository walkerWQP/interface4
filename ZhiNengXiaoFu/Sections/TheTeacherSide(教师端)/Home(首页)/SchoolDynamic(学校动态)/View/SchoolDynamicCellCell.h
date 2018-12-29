//
//  SchoolDynamicCellCell.h
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/27.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SchoolDynamicCellCell_CollectionView @"SchoolDynamicCellCell"

@interface SchoolDynamicCellCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView  *headImgView;
@property (nonatomic, strong) UILabel      *titleLabel;
@property (nonatomic, strong) UILabel      *subjectsLabel;
@property (nonatomic, strong) UILabel      *timeLabel;

@end
