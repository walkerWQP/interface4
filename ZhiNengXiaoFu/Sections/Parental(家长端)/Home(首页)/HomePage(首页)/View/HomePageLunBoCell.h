//
//  HomePageLunBoCell.h
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/20.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HomePageLunBoCell : UICollectionViewCell

//@property (nonatomic, retain) SDCycleScrollView *cycleScrollView2;
@property (nonatomic, retain) NSMutableArray    *dataHeaderSourceAry;
@property (nonatomic, retain) NSMutableArray    *dataHeaderSourceAryImg;

- (void)getClassData;

@end
