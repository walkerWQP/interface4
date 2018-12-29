//
//  HomePageJingJiView.m
//  ZhiNengXiaoFu
//
//  Created by 独秀科技 on 2018/10/9.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "HomePageJingJiView.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"


@implementation HomePageJingJiView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (NSArray *)array {
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}

- (void)setDetail:(NSArray *)array {
    self.array=array;
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIView class]]) {
            [view removeFromSuperview];
        }
    }
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 5, CGRectGetWidth(self.frame) , (kScreenWidth - 40) / 3 * 144 / 235)];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.scrollEnabled = NO;
    self.scrollView.userInteractionEnabled  = YES;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    
    self.scrollView.bounces = YES;
    [self addSubview:self.scrollView];
    CGFloat viewWidth= (kScreenWidth - 40) / 3;
    for (int i=0; i<array.count; i++) {
        
        NSDictionary *dic=array[i];
        if (array.count*viewWidth+array.count * 10 > self.scrollView.size.width) {
        self.scrollView.contentSize=CGSizeMake(array.count*viewWidth+array.count*10, 0);
            
        }else
        {
            self.scrollView.contentSize=CGSizeMake(self.scrollView.size.width + 10, 0);
        }
        
        
        UIButton *bigView=[[UIButton alloc] init];
        bigView.frame=CGRectMake(10+i*(viewWidth+10), 0, viewWidth, viewWidth * 144 / 235);
        [bigView setBackgroundColor:[UIColor whiteColor]];
        bigView.tag = i;
        bigView.layer.cornerRadius = 4;
        bigView.layer.masksToBounds = YES;
        [bigView sd_setBackgroundImageWithURL:[NSURL URLWithString:[dic objectForKey:@"img"]] forState:UIControlStateNormal];
        [self.scrollView addSubview:bigView];
        
        
        UIView * mengBan = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bigView.frame.size.width, bigView.frame.size.height)];
        mengBan.backgroundColor = RGBA(0, 0, 0, 0.2);
        mengBan.userInteractionEnabled = YES;
        [bigView addSubview:mengBan];
        
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, bigView.frame.size.width - 16, bigView.frame.size.height)];
        titleLabel.text = [dic objectForKey:@"title"];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [bigView addSubview:titleLabel];
        
        UIButton *bigViewT=[[UIButton alloc] init];
        bigViewT.frame=CGRectMake(10+i*(viewWidth+10), 0, viewWidth, viewWidth * 144 / 235);
        [bigViewT setBackgroundColor:[UIColor clearColor]];
        bigViewT.tag = i;
        [bigViewT addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
        bigViewT.userInteractionEnabled = YES;
        [self.scrollView addSubview:bigViewT];
    }
}

-(void)buttonClick:(UIButton *)button {
    NSDictionary *dic=self.array[button.tag];
    NSString *str=[NSString stringWithFormat:@"%@",dic[@"id"]];//dic[@"id"];
    if (_HomePageJingJiViewDelegate && [_HomePageJingJiViewDelegate respondsToSelector:@selector(jumpToAnswerHomePageJingJi:weizhi:)]) {
        [_HomePageJingJiViewDelegate jumpToAnswerHomePageJingJi:str weizhi:@""];
    }
}

@end
