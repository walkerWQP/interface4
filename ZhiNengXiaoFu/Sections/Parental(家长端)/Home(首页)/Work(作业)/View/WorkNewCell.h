//
//  WorkNewCell.h
//  ZhiNengXiaoFu
//
//  Created by 独秀科技 on 2018/10/11.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WorkNewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *WorkNewImg;
@property (weak, nonatomic) IBOutlet UIImageView *WorkNewIconImg;
@property (weak, nonatomic) IBOutlet UILabel     *WorkNewFenLeiLabel;
@property (weak, nonatomic) IBOutlet UILabel     *WorkNewTacherLabel;
@property (weak, nonatomic) IBOutlet UILabel     *WorkNewTimeLabel;

@end

NS_ASSUME_NONNULL_END
