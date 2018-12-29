//
//  HomePageTongZhiView.m
//  ZhiNengXiaoFu
//
//  Created by 独秀科技 on 2018/10/10.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "HomePageTongZhiView.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "MJExtension.h"

@interface HomePageTongZhiView ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView    *ccpScrollView;
@property (nonatomic,assign) CGFloat         labelW;
@property (nonatomic,assign) CGFloat         labelH;
@property (nonatomic,strong) NSTimer         *timer;
@property (nonatomic,assign) int             page;
@property (nonatomic, strong) NSMutableArray *objAry;


@end

@implementation HomePageTongZhiView

- (UIScrollView *)ccpScrollView {
    
    if (_ccpScrollView == nil) {
        _ccpScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _ccpScrollView.backgroundColor = [UIColor whiteColor];
        _ccpScrollView.showsHorizontalScrollIndicator = NO;
        _ccpScrollView.showsVerticalScrollIndicator = NO;
        _ccpScrollView.scrollEnabled = NO;
        _ccpScrollView.pagingEnabled = YES;
        [self addSubview:_ccpScrollView];
        [_ccpScrollView setContentOffset:CGPointMake(0 , self.labelH) animated:YES];
    }
    return _ccpScrollView;
    
}

- (NSMutableArray *)objAry {
    if (!_objAry) {
        self.objAry = [@[]mutableCopy];
    }
    return _objAry;
}

- (NSMutableArray *)titleNewArray {
    if (!_titleNewArray) {
        self.titleNewArray = [@[]mutableCopy];
    }
    return _titleNewArray;
}


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.labelW = frame.size.width;
        self.labelH = frame.size.height;
        self.ccpScrollView.delegate = self;
        [self addTimer];
    }
    return self;
}

//重写set方法 创建对应的view数据
- (void)setTitleArray:(NSMutableArray *)titleArray {
    
    _titleArray = titleArray;
    if (titleArray == nil) {
        [self removeTimer];
        return;
    }
    
    if (titleArray.count == 1) {
        [self removeTimer];
    }
    
    id lastObj = [titleArray lastObject];
    NSMutableArray *objArray = [[NSMutableArray alloc] init];
    [objArray addObject:lastObj];
    [objArray addObjectsFromArray:titleArray];
    self.titleNewArray = objArray;
    
    //CGFloat contentW = 0;
    CGFloat contentH = self.labelH *objArray.count;
    self.ccpScrollView.contentSize = CGSizeMake(0, contentH);
    CGFloat labelW = self.ccpScrollView.frame.size.width;
    self.labelW = labelW;
    CGFloat labelH = self.ccpScrollView.frame.size.height;
    self.labelH = labelH;
    CGFloat labelX = 0;
    
    //防止重复赋值数据叠加
    for (id label in self.ccpScrollView.subviews) {
        [label removeFromSuperview];
    }
    
    for (int i = 0; i < objArray.count; i++) {
        
        NSDictionary * dic = objArray[i];
        CGFloat labelY = i * labelH;
        UIView *bgView=[[UIView alloc] init];
        bgView.userInteractionEnabled=YES;
        bgView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTheLabel:)];
        [bgView addGestureRecognizer:tap];
        bgView.frame=CGRectMake(labelX, labelY, labelW, labelH);
        bgView.backgroundColor=[UIColor whiteColor];
       
//        UIImageView * tongZhiImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 46, 39)];
//        tongZhiImg.image = [UIImage imageNamed:@"通知New"];
//        [bgView addSubview:tongZhiImg];
        
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 14, kScreenWidth - (15 + 46 + 10)  - 15, 15)];
        titleLabel.text = [dic objectForKey:@"title"];
        titleLabel.textColor = RGBA(119, 119, 119, 1);
        titleLabel.font = [UIFont systemFontOfSize:14];
        [bgView addSubview:titleLabel];
        
        UILabel * connectLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 34, kScreenWidth - (15 + 46 + 10)  - 15, 12)];
        connectLabel.text = [dic objectForKey:@"content"];
        connectLabel.textColor = RGBA(170, 170, 170, 1);
        connectLabel.font = [UIFont systemFontOfSize:12];
        [bgView addSubview:connectLabel];
        
        [self.ccpScrollView addSubview:bgView];
        
    }
    
}

- (void)clickTheLabel:(UITapGestureRecognizer *)tap {
    
    if (self.clickLabelBlock) {
        NSInteger index = [[[self.titleNewArray objectAtIndex:tap.view.tag] objectForKey:@"id"] integerValue];
        NSInteger tag = tap.view.tag - 1;
        
        if (tag < 100) {
            tag = 100 + (self.titleArray.count - 1);
        }
        self.clickLabelBlock(index,self.titleArray[tag - 100]);
    }
}

- (void) clickTitleLabel:(clickLabelBlock) clickLabelBlock {
    self.clickLabelBlock = clickLabelBlock;
}

- (void)setIsCanScroll:(BOOL)isCanScroll {
    
    if (isCanScroll) {
        self.ccpScrollView.scrollEnabled = YES;
    } else {
        self.ccpScrollView.scrollEnabled = NO;
    }
    
}
- (void)setBGColor:(UIColor *)BGColor {
    
    _BGColor = BGColor;
    self.backgroundColor = BGColor;
    
}

- (void)nextLabel {
    
    CGPoint oldPoint = self.ccpScrollView.contentOffset;
//    if (oldPoint.y <= 60) {
        oldPoint.y += 60;
//    }else if (oldPoint.y > 60 && oldPoint.y <= 120)
//    {
//        oldPoint.y += 120;
//    }else if (oldPoint.y > 120)
//    {
//         oldPoint.y += 120;
//    }
    int a;
    a = (int)oldPoint.y;
    
    if (a % 60 != 0) {
        oldPoint.y =  (CGFloat)((a / 60 + 1) * 60);
    }
    
    if (oldPoint.y > self.titleArray.count * 60) {
        oldPoint.y = self.titleArray.count * 60;
    }
    
    
//   oldPoint.y += self.ccpScrollView.frame.size.height;
    
    [self.ccpScrollView setContentOffset:oldPoint animated:YES];
    
}
//当图片滚动时调用scrollView的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (self.ccpScrollView.contentOffset.y == self.ccpScrollView.frame.size.height*(self.titleArray.count )) {
        
        [self.ccpScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        
    }
    
}


// 开始拖拽的时候调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self removeTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    //开启定时器
    [self addTimer];
}

- (void)addTimer{
    
    /*
     scheduledTimerWithTimeInterval:  滑动视图的时候timer会停止
     这个方法会默认把Timer以NSDefaultRunLoopMode添加到主Runloop上，而当你滑tableView的时候，就不是NSDefaultRunLoopMode了，这样，你的timer就会停了。
     self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(nextLabel) userInfo:nil repeats:YES];
     */
    
    self.timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(nextLabel) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)removeTimer {
    
    [self.timer invalidate];
    self.timer = nil;
}

- (void)dealloc {
    
    [self.timer invalidate];
    self.timer = nil;
    
}

@end
