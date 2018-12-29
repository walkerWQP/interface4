//
//  NewDynamicsLayout.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/9/5.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "NewDynamicsLayout.h"
#import "SDWeiXinPhotoContainerView.h"

@implementation NewDynamicsLayout

- (NSMutableArray *)commentLayoutArr {
    if (!_commentLayoutArr) {
        _commentLayoutArr = [NSMutableArray array];
    }
    return _commentLayoutArr;
}

- (instancetype)initWithModel:(DynamicsModel *)model {
    self = [super init];
    if (self) {
        [self setUser];
        _model = model;
        [self resetLayout];
    }
    return self;
}

- (void)resetLayout {
    _height = 0;
    _thumbCommentHeight = 0;
    
    [self.commentLayoutArr removeAllObjects];
    
    _height += kDynamicsNormalPadding;
    _height += kDynamicsNameHeight;
    _height += kDynamicsNameDetailPadding;
    
    [self layoutDetail];
    _height += _detailLayout.textBoundingSize.height;
    
    if (_model.shouldShowMoreButton) {
        _height += kDynamicsNameDetailPadding;
        _height += kDynamicsMoreLessButtonHeight;
    }
    if (_model.img.count != 0) {
        [self layoutPicture];
        _height += kDynamicsNameDetailPadding;
        _height += _photoContainerSize.height;
    }
    if (_model.pagetype == 1) {//头条类型
        [self layoutGrayDetailView];
        _height += kDynamicsNameDetailPadding;
        _height += kDynamicsGrayBgHeight;
    }
    
    _height += kDynamicsPortraitNamePadding;
    _height += kDynamicsNameHeight;//时间
    _height += kDynamicsPortraitNamePadding;
    
    if (_model.likeArr.count != 0) {
        [self layoutThumb];
    }
    if (_model.commentArr.count != 0) {
        [self layoutComment];
    }
    _height += _thumbCommentHeight;
    
    if (_model.likeArr.count != 0 || _model.commentArr.count != 0) {//底部间隙
        _height += kDynamicsPortraitNamePadding;
    }
}

- (void)layoutDetail {
    _detailLayout = nil;
    
    NSMutableAttributedString * text = [[NSMutableAttributedString alloc] initWithString:_model.content];
    text.font = [UIFont systemFontOfSize:14];
    text.lineSpacing = kDynamicsLineSpacing;
    
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypePhoneNumber | NSTextCheckingTypeLink error:nil];
    
    WS(weakSelf);
    [detector enumerateMatchesInString:_model.content
                               options:kNilOptions
                                 range:text.rangeOfAll
                            usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                                
                                if (result.URL) {
                                    YYTextHighlight * highLight = [YYTextHighlight new];
                                    [text setColor:[UIColor colorWithRed:69/255.0 green:88/255.0 blue:133/255.0 alpha:1] range:result.range];
                                    highLight.tapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                                        if (weakSelf.clickUrlBlock) {
                                            weakSelf.clickUrlBlock([text.string substringWithRange:range]);
                                        }
                                    };
                                    [text setTextHighlight:highLight range:result.range];
                                }
                                if (result.phoneNumber) {
                                    YYTextHighlight * highLight = [YYTextHighlight new];
                                    [text setColor:[UIColor colorWithRed:69/255.0 green:88/255.0 blue:133/255.0 alpha:1] range:result.range];
                                    highLight.tapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                                        if (weakSelf.clickPhoneNumBlock) {
                                            weakSelf.clickPhoneNumBlock([text.string substringWithRange:range]);
                                        }
                                    };
                                    [text setTextHighlight:highLight range:result.range];
                                }
                            }];
    
    NSInteger lineCount = 6;
    YYTextContainer * container = [YYTextContainer containerWithSize:CGSizeMake(APP_WIDTH - kDynamicsNormalPadding - kDynamicsPortraitWidthAndHeight - kDynamicsPortraitNamePadding - kDynamicsNormalPadding, _model.isOpening ? CGFLOAT_MAX : 16 * lineCount + kDynamicsLineSpacing * (lineCount - 1))];
    
    container.truncationType = YYTextTruncationTypeEnd;
    
    _detailLayout = [YYTextLayout layoutWithContainer:container text:text];
    
}

- (void)layoutPicture {
    self.photoContainerSize = CGSizeZero;
    self.photoContainerSize = [SDWeiXinPhotoContainerView getContainerSizeWithPicPathStringsArray:_model.img];
}

- (void)layoutGrayDetailView {
    NSMutableAttributedString * text = [[NSMutableAttributedString alloc] initWithString:_model.content];
    text.font = [UIFont systemFontOfSize:14];
    text.lineSpacing = 3;
    
    YYTextContainer * container = [YYTextContainer containerWithSize:CGSizeMake(APP_WIDTH - kDynamicsNormalPadding - kDynamicsPortraitWidthAndHeight - kDynamicsPortraitNamePadding - kDynamicsGrayPicPadding - kDynamicsGrayPicHeight - kDynamicsNameDetailPadding*2 - kDynamicsNormalPadding,kDynamicsGrayBgHeight - kDynamicsGrayPicPadding*2)];
    container.truncationType = YYTextTruncationTypeEnd;
    
    _dspLayout = [YYTextLayout layoutWithContainer:container text:text];
}

#pragma mark ======= 获取个人信息数据 =======
- (void)setUser {
    NSDictionary * dic = @{@"key":[UserManager key]};
    [[HttpRequestManager sharedSingleton] POST:getUserInfoURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            
            self.userNameStr = [[responseObject objectForKey:@"data"] objectForKey:@"name"];
        } else {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
            } else {
                
            }
            [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}


- (void)layoutThumb {
    _thumbCommentHeight = 0;
    _thumbHeight = 0;
    
    NSMutableAttributedString * text = [[NSMutableAttributedString alloc] init];
    for (int i = 0; i < _model.likeArr.count; i++) {
        DynamicsLikeItemModel *model = _model.likeArr[i];
        if (i > 0) {
            [text appendAttributedString:[[NSAttributedString alloc] initWithString:@", "]];
        }
        //点赞人员姓名
        NSMutableAttributedString * nick = [[NSMutableAttributedString alloc] initWithString:model.praise_name];
        nick.font = [UIFont boldSystemFontOfSize:13];
        [nick setColor:[UIColor colorWithRed:69/255.0 green:88/255.0 blue:133/255.0 alpha:1] range:nick.rangeOfAll];
        
        YYTextHighlight * highLight = [YYTextHighlight new];
        WS(weakSelf);
        highLight.tapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            if (weakSelf.clickUserBlock) {
                weakSelf.clickUserBlock(model.praise_id);
            }
        };
        [nick setTextHighlight:highLight range:nick.rangeOfAll];
        [text appendAttributedString:nick];
    }
    UIImage *iconImage = [UIImage imageNamed:@"Like"];
    NSAttributedString *icon = [NSAttributedString attachmentStringWithContent:iconImage contentMode:UIViewContentModeCenter attachmentSize:iconImage.size alignToFont:[UIFont systemFontOfSize:14] alignment:YYTextVerticalAlignmentCenter];
    [text insertString:@" " atIndex:0];
    [text insertAttributedString:icon atIndex:0];
    
    YYTextContainer * container = [YYTextContainer containerWithSize:CGSizeMake(APP_WIDTH - kDynamicsNormalPadding - kDynamicsPortraitWidthAndHeight - kDynamicsPortraitNamePadding - kDynamicsNameDetailPadding*2 - kDynamicsNormalPadding,CGFLOAT_MAX)];
    
    _thumbLayout = [YYTextLayout layoutWithContainer:container text:text];
    
    _thumbHeight += kDynamicsThumbTopPadding;//点赞文字上边距
    _thumbHeight += _thumbLayout.textBoundingSize.height;//点赞文字高度
    _thumbHeight += kDynamicsGrayPicPadding;//点赞文字下边距
    
    _thumbCommentHeight += _thumbHeight;
    
}



#pragma mark ======= 评论内容 =======
- (void)layoutComment {
    
    _thumbCommentHeight = _model.likeArr.count == 0 ?  0 : _thumbCommentHeight;
    _commentHeight = _model.likeArr.count == 0 ? 10 : .5;//是否需要分割线
    for (int i = 0; i < _model.commentArr.count; i++) {
        DynamicsCommentItemModel * model = _model.commentArr[i];
       
            NSMutableAttributedString * text = [[NSMutableAttributedString alloc] init];
            //评论人员姓名
        
            if ((self.userNameStr != nil && _model.likeArr.count == 0 && _model.commentArr.count == 0) || _model.optcomment.count != 0) {
                
                NSMutableAttributedString *nick = [[NSMutableAttributedString alloc] init];
                if (self.userNameStr == nil || [self.userNameStr isEqualToString:@""]) {
                    nick = [nick initWithString:model.discuss_name];
                } else {
                    nick = [nick initWithString:model.discuss_name];
                }
                
                //            NSMutableAttributedString *nick = [[NSMutableAttributedString alloc] initWithString:self.userNameStr];
                nick.font = [UIFont boldSystemFontOfSize:13];
                YYTextHighlight * highLight = [YYTextHighlight new];
                [nick setColor:[UIColor colorWithRed:69/255.0 green:88/255.0 blue:133/255.0 alpha:1] range:nick.rangeOfAll];
                WS(weakSelf);
                highLight.tapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                    if (weakSelf.clickUserBlock) {
                        weakSelf.clickUserBlock(model.discuss_id);
                    }
                };
                [nick setTextHighlight:highLight range:nick.rangeOfAll];
                [text appendAttributedString:nick];
                
                //评论内容
                NSMutableAttributedString * fhText = [[NSMutableAttributedString alloc] initWithString:@"："];
                fhText.font = [UIFont systemFontOfSize:13];
                [text appendAttributedString:fhText];
                if (model.discuss_content == nil) {
                    NSMutableAttributedString * message = [[NSMutableAttributedString alloc] initWithString:model.message];
                    message.font = [UIFont systemFontOfSize:13];
                    [text appendAttributedString:message];
                } else {
                    NSMutableAttributedString * message = [[NSMutableAttributedString alloc] initWithString:model.discuss_content];
                    message.font = [UIFont systemFontOfSize:13];
                    [text appendAttributedString:message];
                }
                
            } else {
                
                NSMutableAttributedString *nick = [[NSMutableAttributedString alloc] initWithString:model.discuss_name];
                nick.font = [UIFont boldSystemFontOfSize:13];
                YYTextHighlight * highLight = [YYTextHighlight new];
                [nick setColor:[UIColor colorWithRed:69/255.0 green:88/255.0 blue:133/255.0 alpha:1] range:nick.rangeOfAll];
                WS(weakSelf);
                highLight.tapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                    if (weakSelf.clickUserBlock) {
                        weakSelf.clickUserBlock(model.discuss_id);
                    }
                };
                [nick setTextHighlight:highLight range:nick.rangeOfAll];
                [text appendAttributedString:nick];
                
                //评论内容
                NSMutableAttributedString * fhText = [[NSMutableAttributedString alloc] initWithString:@"："];
                fhText.font = [UIFont systemFontOfSize:13];
                [text appendAttributedString:fhText];
                NSMutableAttributedString * message = [[NSMutableAttributedString alloc] initWithString:model.discuss_content];
                message.font = [UIFont systemFontOfSize:13];
                [text appendAttributedString:message];
            }
            
            YYTextContainer * container = [YYTextContainer containerWithSize:CGSizeMake(APP_WIDTH - kDynamicsNormalPadding - kDynamicsPortraitWidthAndHeight - kDynamicsPortraitNamePadding - kDynamicsNameDetailPadding*2 - kDynamicsNormalPadding,CGFLOAT_MAX)];
            NSLog(@"%@",text);
            YYTextLayout * layout = [YYTextLayout layoutWithContainer:container text:text];
            _commentHeight += kDynamicsGrayPicPadding;//评论文字上边距
            _commentHeight += layout.textBoundingSize.height;//评论文字高度
            _commentHeight += kDynamicsGrayPicPadding;//评论文字下边距
            [self.commentLayoutArr addObject:layout];
        }
    _thumbCommentHeight += _commentHeight;
}



@end
