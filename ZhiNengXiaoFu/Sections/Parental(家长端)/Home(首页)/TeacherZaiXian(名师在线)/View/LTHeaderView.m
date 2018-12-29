//
//  LTHeaderView.m
//  OCExample
//
//  Created by 高刘通 on 2018/4/19.
//  Copyright © 2018年 LT. All rights reserved.
//
//  如有疑问，欢迎联系本人QQ: 1282990794
//
//  ScrollView嵌套ScrolloView解决方案（初级、进阶)， 支持OC/Swift
//
//  github地址: https://github.com/gltwy/LTScrollView
//
//  clone地址:  https://github.com/gltwy/LTScrollView.git
//

#import "LTHeaderView.h"

@interface LTHeaderView ()
@property(strong, nonatomic) UILabel *testLabel;

@end

@implementation LTHeaderView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark - 布局子视图
-(void)setupSubviews {
    self.backgroundColor = [UIColor blueColor];
//    [self addSubview:self.testLabel];
    [self addSubview:self.backTwo];
    [self addSubview:self.back];
}

-(void)tagGesture:(UITapGestureRecognizer *)gesture {
    NSLog(@"响应事件，回调自己处理吧。");
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[UILabel class]]) {
            UILabel *subLabel = (UILabel *)subView;
            CGPoint convertP = [self convertPoint:point toView:subLabel];
            if (CGRectContainsPoint(subLabel.bounds, convertP)) {
                return YES;
            }
        }
    }
    return NO;
}



-(UILabel *)testLabel {
    if (!_testLabel) {
        _testLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, 200, 20)];
//        _testLabel.text = @"点击响应事件";
        _testLabel.backgroundColor = [UIColor grayColor];
        _testLabel.textColor = [UIColor whiteColor];
        _testLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagGesture:)];
        [_testLabel addGestureRecognizer:gesture];
    }
    return _testLabel;
}

- (UIImageView *)back {
    if (!_back) {
        _back = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, self.frame.size.width - 30, self.frame.size.height)];
        _back.contentMode = UIViewContentModeScaleAspectFill;
        _back.clipsToBounds = YES;
        _back.layer.cornerRadius  = 5;
        _back.layer.masksToBounds = YES;
    }
    return _back;
}

- (UIImageView *)backTwo {
    if (!_backTwo) {
        _backTwo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _backTwo.image = [UIImage imageNamed:@"banner底部"];
    }
    return _backTwo;
}

@end
