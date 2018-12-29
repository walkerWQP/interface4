//
//  RightCell.m
//  ZhiNengXiaoFu
//
//  Created by 独秀科技 on 2018/12/19.
//  Copyright © 2018 henanduxiu. All rights reserved.
//

#import "RightCell.h"

@implementation RightCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self makeRightCellUI];
    }
    return self;
}

- (void)makeRightCellUI {
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 2, 35 - 4, 60 - 4)];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLabel];
    int R = (arc4random() % 256) ;
    int G = (arc4random() % 256) ;
    int B = (arc4random() % 256) ;
    self.contentView.backgroundColor = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1];
}

@end
