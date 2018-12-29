//
//  YYCollectionViewLayout.h
//  自定义collectionView
//
//  Created by 杨金发 on 16/9/5.
//  Copyright © 2016年 杨金发. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LINE 2
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define PADDING 10
#define ITEM_WIDTH   (SCREEN_WIDTH-PADDING*(LINE+1))/LINE

@class YYCollectionViewLayout;

@protocol  YYCollectionViewLayoutDelegate <NSObject>

@required

-(CGSize)YYCollectionViewLayoutForCollectionView:(UICollectionView*) collection withLayout:(YYCollectionViewLayout*) layout atIndexPath:(NSIndexPath*)indexPath;

@end


@interface YYCollectionViewLayout : UICollectionViewLayout

@property(nonatomic,weak)id<YYCollectionViewLayoutDelegate> delegate;

@end
