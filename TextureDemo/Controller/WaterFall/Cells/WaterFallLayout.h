//
//  WaterFallLayout.h
//  TextureDemo
//
//  Created by zqp on 2019/12/26.
//  Copyright © 2019 zqp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class WaterFallLayout;

@protocol WaterFallLayoutDelegate <NSObject>

@required
/**
 * 每个item的高度
 */
- (CGFloat)waterFallLayout:(WaterFallLayout *)waterFallLayout
  heightForItemAtIndexPath:(NSInteger)indexPath
                 itemWidth:(CGFloat)itemWidth;

@optional

/**
 * 有多少列
 */
- (NSUInteger)columnCountInWaterFallLayout:(WaterFallLayout *)waterFallLayout;

/**
 * 每列之间的间距
 */
- (CGFloat)columnMarginInWaterFallLayout:(WaterFallLayout *)waterFallLayout;

/**
 * 每行之间的间距
 */
- (CGFloat)rowMarginInWaterFallLayout:(WaterFallLayout *)waterFallLayout;

/**
 * 每个item的内边距
 */
- (UIEdgeInsets)edgeInsetdInWaterFallLayout:(WaterFallLayout *)waterFallLayout;

@end


@interface WaterFallLayout : UICollectionViewFlowLayout


@property (nonatomic , weak) id<WaterFallLayoutDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
