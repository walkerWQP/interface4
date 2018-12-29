//
//  TongZhiDetailsCell.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/8/1.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "TongZhiDetailsCell.h"
@implementation TongZhiDetailsCell

- (WKWebView *)webView {
    if (!_webView) {
        //        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:self.webConfig];
        _webView = [WKWebView new];
        _webView.frame = CGRectMake(10, 50, APP_WIDTH - 20, 5);
        _webView.hidden = YES;
        //  添加 WKWebView 的代理，注意：用此方法添加代理
        
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.scrollView.bounces = NO;
        
        [self.contentView addSubview:_webView];
    }
    return _webView;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
