//
//  WPopupMenu.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "WPopupMenu.h"

#define WScreenWidth [UIScreen mainScreen].bounds.size.width
#define WScreenHeight [UIScreen mainScreen].bounds.size.height
#define WMainWindow  [UIApplication sharedApplication].keyWindow
#define W_SAFE_BLOCK(BlockName, ...) ({ !BlockName ? nil : BlockName(__VA_ARGS__); })

#pragma mark - /////////////
#pragma mark - private cell

@interface WPopupMenuCell : UITableViewCell

@property (nonatomic, assign) BOOL isShowSeparator;
@property (nonatomic, strong) UIColor * separatorColor;

@end

@implementation WPopupMenuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _isShowSeparator = YES;
        _separatorColor = [UIColor lightGrayColor];
        [self setNeedsDisplay];
    }
    return self;
}

- (void)setIsShowSeparator:(BOOL)isShowSeparator {
    _isShowSeparator = isShowSeparator;
    [self setNeedsDisplay];
}

- (void)setSeparatorColor:(UIColor *)separatorColor {
    _separatorColor = separatorColor;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    if (!_isShowSeparator) return;
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, rect.size.height - 0.5, rect.size.width, 0.5)];
    [_separatorColor setFill];
    [bezierPath fillWithBlendMode:kCGBlendModeNormal alpha:1];
    [bezierPath closePath];
}

@end


@interface  WPopupMenu()<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UIView      * menuBackView;
@property (nonatomic) CGRect                relyRect;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, assign) CGFloat       minSpace;
@property (nonatomic, assign) CGFloat       itemWidth;
@property (nonatomic, strong) NSArray     * titles;
@property (nonatomic, strong) NSArray     * images;
@property (nonatomic) CGPoint               point;
@property (nonatomic, assign) BOOL          isCornerChanged;
@property (nonatomic, strong) UIColor     * separatorColor;
@property (nonatomic, assign) BOOL          isChangeDirection;

@end


@implementation WPopupMenu

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setDefaultSettings];
    }
    return self;
}

#pragma mark - publics
+ (WPopupMenu *)showAtPoint:(CGPoint)point titles:(NSArray *)titles icons:(NSArray *)icons menuWidth:(CGFloat)itemWidth delegate:(id<WPopupMenuDelegate>)delegate {
    WPopupMenu *popupMenu = [[WPopupMenu alloc] init];
    popupMenu.point = point;
    popupMenu.titles = titles;
    popupMenu.images = icons;
    popupMenu.itemWidth = itemWidth;
    popupMenu.delegate = delegate;
    [popupMenu show];
    return popupMenu;
}

+ (WPopupMenu *)showRelyOnView:(UIView *)view titles:(NSArray *)titles icons:(NSArray *)icons menuWidth:(CGFloat)itemWidth delegate:(id<WPopupMenuDelegate>)delegate {
    CGRect absoluteRect = [view convertRect:view.bounds toView:WMainWindow];
    CGPoint relyPoint = CGPointMake(absoluteRect.origin.x + absoluteRect.size.width / 2, absoluteRect.origin.y + absoluteRect.size.height);
    WPopupMenu *popupMenu = [[WPopupMenu alloc] init];
    popupMenu.point = relyPoint;
    popupMenu.relyRect = absoluteRect;
    popupMenu.titles = titles;
    popupMenu.images = icons;
    popupMenu.itemWidth = itemWidth;
    popupMenu.delegate = delegate;
    [popupMenu show];
    return popupMenu;
}

+ (WPopupMenu *)showAtPoint:(CGPoint)point titles:(NSArray *)titles icons:(NSArray *)icons menuWidth:(CGFloat)itemWidth otherSettings:(void (^) (WPopupMenu * popupMenu))otherSetting {
    WPopupMenu *popupMenu = [[WPopupMenu alloc] init];
    popupMenu.point = point;
    popupMenu.titles = titles;
    popupMenu.images = icons;
    popupMenu.itemWidth = itemWidth;
    W_SAFE_BLOCK(otherSetting,popupMenu);
    [popupMenu show];
    return popupMenu;
}

+ (WPopupMenu *)showRelyOnView:(UIView *)view titles:(NSArray *)titles icons:(NSArray *)icons menuWidth:(CGFloat)itemWidth otherSettings:(void (^) (WPopupMenu * popupMenu))otherSetting {
    CGRect absoluteRect = [view convertRect:view.bounds toView:WMainWindow];
    CGPoint relyPoint = CGPointMake(absoluteRect.origin.x + absoluteRect.size.width / 2, absoluteRect.origin.y + absoluteRect.size.height);
    WPopupMenu *popupMenu = [[WPopupMenu alloc] init];
    popupMenu.point = relyPoint;
    popupMenu.relyRect = absoluteRect;
    popupMenu.titles = titles;
    popupMenu.images = icons;
    popupMenu.itemWidth = itemWidth;
    W_SAFE_BLOCK(otherSetting,popupMenu);
    [popupMenu show];
    return popupMenu;
}

- (void)dismiss {
    if (self.delegate && [self.delegate respondsToSelector:@selector(WPopupMenuBeganDismiss)]) {
        [self.delegate WPopupMenuBeganDismiss];
    }
    [UIView animateWithDuration: 0.25 animations:^{
        self.layer.affineTransform = CGAffineTransformMakeScale(0.1, 0.1);
        self.alpha = 0;
        _menuBackView.alpha = 0;
    } completion:^(BOOL finished) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(WPopupMenuDidDismiss)]) {
            [self.delegate WPopupMenuDidDismiss];
        }
        self.delegate = nil;
        [self removeFromSuperview];
        [_menuBackView removeFromSuperview];
    }];
}

#pragma mark tableViewDelegate & dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifier = @"ybPopupMenu";
    WPopupMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[WPopupMenuCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.textLabel.numberOfLines = 0;
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = _textColor;
    cell.textLabel.font = [UIFont systemFontOfSize:_fontSize];
    if ([_titles[indexPath.row] isKindOfClass:[NSAttributedString class]]) {
        cell.textLabel.attributedText = _titles[indexPath.row];
    } else if ([_titles[indexPath.row] isKindOfClass:[NSString class]]) {
        cell.textLabel.text = _titles[indexPath.row];
    } else {
        cell.textLabel.text = nil;
    }
    cell.separatorColor = _separatorColor;
    if (_images.count >= indexPath.row + 1) {
        if ([_images[indexPath.row] isKindOfClass:[NSString class]]) {
            cell.imageView.image = [UIImage imageNamed:_images[indexPath.row]];
        } else if ([_images[indexPath.row] isKindOfClass:[UIImage class]]){
            cell.imageView.image = _images[indexPath.row];
        } else {
            cell.imageView.image = nil;
        }
    } else {
        cell.imageView.image = nil;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_dismissOnSelected) [self dismiss];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(WPopupMenuDidSelectedAtIndex:WPopupMenu:)]) {
        
        [self.delegate WPopupMenuDidSelectedAtIndex:indexPath.row WPopupMenu:self];
    }
}

#pragma mark - scrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    WPopupMenuCell *cell = [self getLastVisibleCell];
    cell.isShowSeparator = YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    WPopupMenuCell *cell = [self getLastVisibleCell];
    cell.isShowSeparator = NO;
}

- (WPopupMenuCell *)getLastVisibleCell {
    NSArray <NSIndexPath *>*indexPaths = [self.tableView indexPathsForVisibleRows];
    indexPaths = [indexPaths sortedArrayUsingComparator:^NSComparisonResult(NSIndexPath *  _Nonnull obj1, NSIndexPath *  _Nonnull obj2) {
        return obj1.row < obj2.row;
    }];
    NSIndexPath *indexPath = indexPaths.firstObject;
    return [self.tableView cellForRowAtIndexPath:indexPath];
}

#pragma mark - privates
- (void)show {
    [WMainWindow addSubview:_menuBackView];
    [WMainWindow addSubview:self];
    WPopupMenuCell *cell = [self getLastVisibleCell];
    cell.isShowSeparator = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(WPopupMenuBeganShow)]) {
        [self.delegate WPopupMenuBeganShow];
    }
    self.layer.affineTransform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration: 0.25 animations:^{
        self.layer.affineTransform = CGAffineTransformMakeScale(1.0, 1.0);
        self.alpha = 1;
        _menuBackView.alpha = 1;
    } completion:^(BOOL finished) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(WPopupMenuDidShow)]) {
            [self.delegate WPopupMenuDidShow];
        }
    }];
}

- (void)setDefaultSettings {
    _cornerRadius = 5.0;
    _rectCorner = UIRectCornerAllCorners;
    self.isShowShadow = YES;
    _dismissOnSelected = YES;
    _dismissOnTouchOutside = YES;
    _fontSize = 15;
    _textColor = [UIColor blackColor];
    _offset = 0.0;
    _relyRect = CGRectZero;
    _point = CGPointZero;
    _borderWidth = 0.0;
    _borderColor = [UIColor lightGrayColor];
    _arrowWidth = 15.0;
    _arrowHeight = 10.0;
    _BackColor = [UIColor whiteColor];
    _type = WPopupMenuTypeDefault;
    _arrowDirection = WPopupMenuArrowDirectionTop;
    _priorityDirection = WPopupMenuPriorityDirectionTop;
    _minSpace = 10.0;
    _maxVisibleCount = 5;
    _itemHeight = 44;
    _isCornerChanged = NO;
    _showMaskView = YES;
    _menuBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WScreenWidth, WScreenHeight)];
    _menuBackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    _menuBackView.alpha = 0;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(touchOutSide)];
    [_menuBackView addGestureRecognizer: tap];
    self.alpha = 0;
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.tableView];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (void)touchOutSide {
    if (_dismissOnTouchOutside) {
        [self dismiss];
    }
}

- (void)setIsShowShadow:(BOOL)isShowShadow {
    _isShowShadow = isShowShadow;
    self.layer.shadowOpacity = isShowShadow ? 0.5 : 0;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowRadius = isShowShadow ? 2.0 : 0;
}

- (void)setShowMaskView:(BOOL)showMaskView {
    _showMaskView = showMaskView;
    _menuBackView.backgroundColor = showMaskView ? [[UIColor blackColor] colorWithAlphaComponent:0.1] : [UIColor clearColor];
}

- (void)setType:(WPopupMenuType)type {
    _type = type;
    switch (type) {
        case WPopupMenuTypeDark:
        {
            _textColor = [UIColor lightGrayColor];
            _BackColor = [UIColor colorWithRed:0.25 green:0.27 blue:0.29 alpha:1];
            _separatorColor = [UIColor lightGrayColor];
        }
            break;
            
        default:
        {
            _textColor = [UIColor blackColor];
            _BackColor = [UIColor whiteColor];
            _separatorColor = [UIColor lightGrayColor];
        }
            break;
    }
    [self updateUI];
}

- (void)setFontSize:(CGFloat)fontSize {
    _fontSize = fontSize;
    [self.tableView reloadData];
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    [self.tableView reloadData];
}

- (void)setPoint:(CGPoint)point {
    _point = point;
    [self updateUI];
}

- (void)setItemWidth:(CGFloat)itemWidth {
    _itemWidth = itemWidth;
    [self updateUI];
}

- (void)setItemHeight:(CGFloat)itemHeight {
    _itemHeight = itemHeight;
    self.tableView.rowHeight = itemHeight;
    [self updateUI];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    [self updateUI];
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    [self updateUI];
}

- (void)setArrowPosition:(CGFloat)arrowPosition {
    _arrowPosition = arrowPosition;
    [self updateUI];
}

- (void)setArrowWidth:(CGFloat)arrowWidth {
    _arrowWidth = arrowWidth;
    [self updateUI];
}

- (void)setArrowHeight:(CGFloat)arrowHeight {
    _arrowHeight = arrowHeight;
    [self updateUI];
}

- (void)setArrowDirection:(WPopupMenuArrowDirection)arrowDirection {
    _arrowDirection = arrowDirection;
    [self updateUI];
}

- (void)setMaxVisibleCount:(NSInteger)maxVisibleCount {
    _maxVisibleCount = maxVisibleCount;
    [self updateUI];
}

- (void)setBackColor:(UIColor *)BackColor {
    _BackColor = BackColor;
    [self updateUI];
}

- (void)setTitles:(NSArray *)titles {
    _titles = titles;
    [self updateUI];
}

- (void)setImages:(NSArray *)images {
    _images = images;
    [self updateUI];
}

- (void)setPriorityDirection:(WPopupMenuPriorityDirection)priorityDirection {
    _priorityDirection = priorityDirection;
    [self updateUI];
}

- (void)setRectCorner:(UIRectCorner)rectCorner {
    _rectCorner = rectCorner;
    [self updateUI];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    [self updateUI];
}

- (void)setOffset:(CGFloat)offset {
    _offset = offset;
    [self updateUI];
}

- (void)updateUI {
    CGFloat height;
    if (_titles.count > _maxVisibleCount) {
        height = _itemHeight * _maxVisibleCount + _borderWidth * 2;
        self.tableView.bounces = YES;
    } else {
        height = _itemHeight * _titles.count + _borderWidth * 2;
        self.tableView.bounces = NO;
    }
    _isChangeDirection = NO;
    if (_priorityDirection == WPopupMenuPriorityDirectionTop) {
        if (_point.y + height + _arrowHeight > WScreenHeight - _minSpace) {
            _arrowDirection = WPopupMenuArrowDirectionBottom;
            _isChangeDirection = YES;
        } else {
            _arrowDirection = WPopupMenuArrowDirectionTop;
            _isChangeDirection = NO;
        }
    } else if (_priorityDirection == WPopupMenuPriorityDirectionBottom) {
        if (_point.y - height - _arrowHeight < _minSpace) {
            _arrowDirection = WPopupMenuArrowDirectionTop;
            _isChangeDirection = YES;
        }else {
            _arrowDirection = WPopupMenuArrowDirectionBottom;
            _isChangeDirection = NO;
        }
    } else if (_priorityDirection == WPopupMenuPriorityDirectionLeft) {
        if (_point.x + _itemWidth + _arrowHeight > WScreenWidth - _minSpace) {
            _arrowDirection = WPopupMenuArrowDirectionRight;
            _isChangeDirection = YES;
        } else {
            _arrowDirection = WPopupMenuArrowDirectionLeft;
            _isChangeDirection = NO;
        }
    } else if (_priorityDirection == WPopupMenuPriorityDirectionRight) {
        if (_point.x - _itemWidth - _arrowHeight < _minSpace) {
            _arrowDirection = WPopupMenuArrowDirectionLeft;
            _isChangeDirection = YES;
        } else {
            _arrowDirection = WPopupMenuArrowDirectionRight;
            _isChangeDirection = NO;
        }
    }
    [self setArrowPosition];
    [self setRelyRect];
    if (_arrowDirection == WPopupMenuArrowDirectionTop) {
        CGFloat y = _isChangeDirection ? _point.y  : _point.y;
        if (_arrowPosition > _itemWidth / 2) {
            self.frame = CGRectMake(WScreenWidth - _minSpace - _itemWidth, y, _itemWidth, height + _arrowHeight);
        } else if (_arrowPosition < _itemWidth / 2) {
            self.frame = CGRectMake(_minSpace, y, _itemWidth, height + _arrowHeight);
        } else {
            self.frame = CGRectMake(_point.x - _itemWidth / 2, y, _itemWidth, height + _arrowHeight);
        }
    } else if (_arrowDirection == WPopupMenuArrowDirectionBottom) {
        CGFloat y = _isChangeDirection ? _point.y - _arrowHeight - height : _point.y - _arrowHeight - height;
        if (_arrowPosition > _itemWidth / 2) {
            self.frame = CGRectMake(WScreenWidth - _minSpace - _itemWidth, y, _itemWidth, height + _arrowHeight);
        } else if (_arrowPosition < _itemWidth / 2) {
            self.frame = CGRectMake(_minSpace, y, _itemWidth, height + _arrowHeight);
        } else {
            self.frame = CGRectMake(_point.x - _itemWidth / 2, y, _itemWidth, height + _arrowHeight);
        }
    } else if (_arrowDirection == WPopupMenuArrowDirectionLeft) {
        CGFloat x = _isChangeDirection ? _point.x : _point.x;
        if (_arrowPosition < _itemHeight / 2) {
            self.frame = CGRectMake(x, _point.y - _arrowPosition, _itemWidth + _arrowHeight, height);
        } else if (_arrowPosition > _itemHeight / 2) {
            self.frame = CGRectMake(x, _point.y - _arrowPosition, _itemWidth + _arrowHeight, height);
        } else {
            self.frame = CGRectMake(x, _point.y - _arrowPosition, _itemWidth + _arrowHeight, height);
        }
    } else if (_arrowDirection == WPopupMenuArrowDirectionRight) {
        CGFloat x = _isChangeDirection ? _point.x - _itemWidth - _arrowHeight : _point.x - _itemWidth - _arrowHeight;
        if (_arrowPosition < _itemHeight / 2) {
            self.frame = CGRectMake(x, _point.y - _arrowPosition, _itemWidth + _arrowHeight, height);
        } else if (_arrowPosition > _itemHeight / 2) {
            self.frame = CGRectMake(x, _point.y - _arrowPosition, _itemWidth + _arrowHeight, height);
        } else {
            self.frame = CGRectMake(x, _point.y - _arrowPosition, _itemWidth + _arrowHeight, height);
        }
    } else if (_arrowDirection == WPopupMenuArrowDirectionNone) {
        
    }
    
    if (_isChangeDirection) {
        [self changeRectCorner];
    }
    [self setAnchorPoint];
    [self setOffset];
    [self.tableView reloadData];
    [self setNeedsDisplay];
}

- (void)setRelyRect {
    if (CGRectEqualToRect(_relyRect, CGRectZero)) {
        return;
    }
    if (_arrowDirection == WPopupMenuArrowDirectionTop) {
        _point.y = _relyRect.size.height + _relyRect.origin.y;
    } else if (_arrowDirection == WPopupMenuArrowDirectionBottom) {
        _point.y = _relyRect.origin.y;
    } else if (_arrowDirection == WPopupMenuArrowDirectionLeft) {
        _point = CGPointMake(_relyRect.origin.x + _relyRect.size.width, _relyRect.origin.y + _relyRect.size.height / 2);
    } else {
        _point = CGPointMake(_relyRect.origin.x, _relyRect.origin.y + _relyRect.size.height / 2);
    }
}


- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    if (_arrowDirection == WPopupMenuArrowDirectionTop) {
        self.tableView.frame = CGRectMake(_borderWidth, _borderWidth + _arrowHeight, frame.size.width - _borderWidth * 2, frame.size.height - _arrowHeight);
    } else if (_arrowDirection == WPopupMenuArrowDirectionBottom) {
        self.tableView.frame = CGRectMake(_borderWidth, _borderWidth, frame.size.width - _borderWidth * 2, frame.size.height - _arrowHeight);
    } else if (_arrowDirection == WPopupMenuArrowDirectionLeft) {
        self.tableView.frame = CGRectMake(_borderWidth + _arrowHeight, _borderWidth , frame.size.width - _borderWidth * 2 - _arrowHeight, frame.size.height);
    } else if (_arrowDirection == WPopupMenuArrowDirectionRight) {
        self.tableView.frame = CGRectMake(_borderWidth , _borderWidth , frame.size.width - _borderWidth * 2 - _arrowHeight, frame.size.height);
    }
}

- (void)changeRectCorner {
    if (_isCornerChanged || _rectCorner == UIRectCornerAllCorners) {
        return;
    }
    BOOL haveTopLeftCorner = NO, haveTopRightCorner = NO, haveBottomLeftCorner = NO, haveBottomRightCorner = NO;
    if (_rectCorner & UIRectCornerTopLeft) {
        haveTopLeftCorner = YES;
    }
    if (_rectCorner & UIRectCornerTopRight) {
        haveTopRightCorner = YES;
    }
    if (_rectCorner & UIRectCornerBottomLeft) {
        haveBottomLeftCorner = YES;
    }
    if (_rectCorner & UIRectCornerBottomRight) {
        haveBottomRightCorner = YES;
    }
    
    if (_arrowDirection == WPopupMenuArrowDirectionTop || _arrowDirection == WPopupMenuArrowDirectionBottom) {
        
        if (haveTopLeftCorner) {
            _rectCorner = _rectCorner | UIRectCornerBottomLeft;
        } else {
            _rectCorner = _rectCorner & (~UIRectCornerBottomLeft);
        }
        if (haveTopRightCorner) {
            _rectCorner = _rectCorner | UIRectCornerBottomRight;
        } else {
            _rectCorner = _rectCorner & (~UIRectCornerBottomRight);
        }
        if (haveBottomLeftCorner) {
            _rectCorner = _rectCorner | UIRectCornerTopLeft;
        } else {
            _rectCorner = _rectCorner & (~UIRectCornerTopLeft);
        }
        if (haveBottomRightCorner) {
            _rectCorner = _rectCorner | UIRectCornerTopRight;
        } else {
            _rectCorner = _rectCorner & (~UIRectCornerTopRight);
        }
        
    } else if (_arrowDirection == WPopupMenuArrowDirectionLeft || _arrowDirection == WPopupMenuArrowDirectionRight) {
        if (haveTopLeftCorner) {
            _rectCorner = _rectCorner | UIRectCornerTopRight;
        } else {
            _rectCorner = _rectCorner & (~UIRectCornerTopRight);
        }
        if (haveTopRightCorner) {
            _rectCorner = _rectCorner | UIRectCornerTopLeft;
        } else {
            _rectCorner = _rectCorner & (~UIRectCornerTopLeft);
        }
        if (haveBottomLeftCorner) {
            _rectCorner = _rectCorner | UIRectCornerBottomRight;
        } else {
            _rectCorner = _rectCorner & (~UIRectCornerBottomRight);
        }
        if (haveBottomRightCorner) {
            _rectCorner = _rectCorner | UIRectCornerBottomLeft;
        } else {
            _rectCorner = _rectCorner & (~UIRectCornerBottomLeft);
        }
    }
    _isCornerChanged = YES;
}

- (void)setOffset {
    if (_itemWidth == 0) return;
    
    CGRect originRect = self.frame;
    
    if (_arrowDirection == WPopupMenuArrowDirectionTop) {
        originRect.origin.y += _offset;
    } else if (_arrowDirection == WPopupMenuArrowDirectionBottom) {
        originRect.origin.y -= _offset;
    } else if (_arrowDirection == WPopupMenuArrowDirectionLeft) {
        originRect.origin.x += _offset;
    } else if (_arrowDirection == WPopupMenuArrowDirectionRight) {
        originRect.origin.x -= _offset;
    }
    self.frame = originRect;
}

- (void)setAnchorPoint {
    if (_itemWidth == 0) return;
    
    CGPoint point = CGPointMake(0.5, 0.5);
    if (_arrowDirection == WPopupMenuArrowDirectionTop) {
        point = CGPointMake(_arrowPosition / _itemWidth, 0);
    } else if (_arrowDirection == WPopupMenuArrowDirectionBottom) {
        point = CGPointMake(_arrowPosition / _itemWidth, 1);
    } else if (_arrowDirection == WPopupMenuArrowDirectionLeft) {
        point = CGPointMake(0, (_itemHeight - _arrowPosition) / _itemHeight);
    } else if (_arrowDirection == WPopupMenuArrowDirectionRight) {
        point = CGPointMake(1, (_itemHeight - _arrowPosition) / _itemHeight);
    }
    CGRect originRect = self.frame;
    self.layer.anchorPoint = point;
    self.frame = originRect;
}

- (void)setArrowPosition {
    if (_priorityDirection == WPopupMenuPriorityDirectionNone) {
        return;
    }
    if (_arrowDirection == WPopupMenuArrowDirectionTop || _arrowDirection == WPopupMenuArrowDirectionBottom) {
        if (_point.x + _itemWidth / 2 > WScreenWidth - _minSpace) {
            _arrowPosition = _itemWidth - (WScreenWidth - _minSpace - _point.x);
        } else if (_point.x < _itemWidth / 2 + _minSpace) {
            _arrowPosition = _point.x - _minSpace;
        } else {
            _arrowPosition = _itemWidth / 2;
        }
        
    } else if (_arrowDirection == WPopupMenuArrowDirectionLeft || _arrowDirection == WPopupMenuArrowDirectionRight) {
        //        if (_point.y + _itemHeight / 2 > YBScreenHeight - _minSpace) {
        //            _arrowPosition = _itemHeight - (YBScreenHeight - _minSpace - _point.y);
        //        }else if (_point.y < _itemHeight / 2 + _minSpace) {
        //            _arrowPosition = _point.y - _minSpace;
        //        }else {
        //            _arrowPosition = _itemHeight / 2;
        //        }
    }
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath *bezierPath = [WPopupMenuPath W_bezierPathWithRect:rect rectCorner:_rectCorner cornerRadius:_cornerRadius borderWidth:_borderWidth borderColor:_borderColor backgroundColor:_BackColor arrowWidth:_arrowWidth arrowHeight:_arrowHeight arrowPosition:_arrowPosition arrowDirection:_arrowDirection];
    [bezierPath fill];
    [bezierPath stroke];
}

@end
