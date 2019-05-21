//
//  CategoryFillerView.h
//  TextureDemo
//
//  Created by zqp on 2019/5/21.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CategoryFillerView : UIView

- (void)dismissHintView ;

- (void)showView ;

@property (nonatomic , strong) NSArray *brandsArr;
@property (nonatomic , strong) NSArray *goodsArr;

@end

NS_ASSUME_NONNULL_END
