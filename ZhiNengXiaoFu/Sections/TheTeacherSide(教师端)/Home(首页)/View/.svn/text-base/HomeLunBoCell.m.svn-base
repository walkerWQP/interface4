//
//  HomeLunBoCell.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/23.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "HomeLunBoCell.h"

@implementation HomeLunBoCell

- (NSMutableArray *)dataHeaderSourceAryImg {
    if (!_dataHeaderSourceAryImg) {
        self.dataHeaderSourceAryImg = [@[]mutableCopy];
    }
    return _dataHeaderSourceAryImg;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.cycleScrollView2];
        [self getClassData];
    }
    return self;
}

- (void)getClassData {
    
    NSDictionary *dic = @{@"key":[UserManager key], @"t_id":@"1"};
    [[HttpRequestManager sharedSingleton] POST:bannersURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            NSMutableArray * ary = [BannerModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            for (BannerModel * model in ary) {
                [self.dataHeaderSourceAryImg addObject:model.img];
            }
            
            [self loadTicketTop];
            
        } else {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
            } else {
                
            }
            [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}



- (void)loadTicketTop {
    
    if (APP_WIDTH == 414) {
        self.cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.frame.size.width, 200) imageURLStringsGroup:nil]; // 模拟网络延时情景
    } else {
        self.cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.frame.size.width, 170) imageURLStringsGroup:nil]; // 模拟网络延时情景
    }
    
    self.cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.cycleScrollView2.delegate = self;
    
//    self.cycleScrollView2.dotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    self.cycleScrollView2.placeholderImage = [UIImage imageNamed:@"placeholder"];
    [self addSubview:self.cycleScrollView2];
    
    //             --- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.cycleScrollView2.imageURLStringsGroup = self.dataHeaderSourceAryImg;
        
    });
    
}

@end
