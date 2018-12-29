//
//  TeacherNotifiedCell.h
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/27.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TeacherNotifiedCell_CollectionView @"TeacherNotifiedCell"

@interface TeacherNotifiedCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView  *headImgView;
@property (nonatomic, strong) UILabel      *classLabel;
@property (nonatomic, strong) UIButton     *rightBtn;

@end
