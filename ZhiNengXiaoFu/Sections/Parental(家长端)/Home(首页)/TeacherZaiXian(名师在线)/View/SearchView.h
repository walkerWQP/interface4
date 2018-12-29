//
//  SearchView.h
//  ZhiNengXiaoFu
//
//  Created by 独秀科技 on 2018/12/12.
//  Copyright © 2018 henanduxiu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TapActionBlock)(NSString *str);

@interface SearchView : UIView

@property (nonatomic, copy) TapActionBlock tapAction;

- (instancetype)initWithFrame:(CGRect)frame hotArray:(NSMutableArray *)hotArr historyArray:(NSMutableArray *)historyArr;

@end

NS_ASSUME_NONNULL_END
