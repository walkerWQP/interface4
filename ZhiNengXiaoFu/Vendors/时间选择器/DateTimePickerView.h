//
//  DateTimePickerView.h
//  ZhiNengXiaoFu
//
//  Created by 独秀科技 on 2018/12/18.
//  Copyright © 2018 henanduxiu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    DatePickerViewDateTimeMode,//年月日,时分
    DatePickerViewDateMode,//年月日
    DatePickerViewTimeMode//时分
} DatePickerViewMode;

@protocol DateTimePickerViewDelegate <NSObject>
@optional
/**
 * 确定按钮
 */
-(void)didClickFinishDateTimePickerView:(NSString*)date;
/**
 * 取消按钮
 */
-(void)didClickCancelDateTimePickerView;

@end


@interface DateTimePickerView : UIView
/**
 * 设置当前时间
 */
@property(nonatomic, strong)NSDate*currentDate;
/**
 * 设置中心标题文字
 */
@property(nonatomic, strong)UILabel *titleL;

@property(nonatomic, strong)id<DateTimePickerViewDelegate>delegate;
/**
 * 模式
 */
@property (nonatomic, assign) DatePickerViewMode pickerViewMode;


/**
 * 掩藏
 */
- (void)hideDateTimePickerView;
/**
 * 显示
 */
- (void)showDateTimePickerView;

@end

NS_ASSUME_NONNULL_END
