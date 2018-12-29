//
//  HZQDatePickerView.h
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/31.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    
    // 开始日期
    DateTypeOfStart = 0,
    
    // 结束日期
    DateTypeOfEnd,
    
}DateType;

@protocol HZQDatePickerViewDelegate <NSObject>

- (void)getSelectDate:(NSString *)date type:(DateType)type;

@end

@interface HZQDatePickerView : UIView

+ (HZQDatePickerView *)instanceDatePickerView;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerView;

@property (nonatomic, weak) id<HZQDatePickerViewDelegate> delegate;

@property (nonatomic, assign) DateType type;

@end
