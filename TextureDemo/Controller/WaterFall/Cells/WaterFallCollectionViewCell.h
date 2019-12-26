//
//  WaterFallCollectionViewCell.h
//  TextureDemo
//
//  Created by zqp on 2019/12/26.
//  Copyright © 2019 zqp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class GoodsModel;

@interface WaterFallCollectionViewCell : UICollectionViewCell


- (void)configWithItem:(GoodsModel *)m;

@end

NS_ASSUME_NONNULL_END
