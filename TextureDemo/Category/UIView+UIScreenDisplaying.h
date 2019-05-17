//
//  UIView+UIScreenDisplaying.h
//  TextureDemo
//
//  Created by zqp on 2019/4/15.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (UIScreenDisplaying)

// 判断View是否显示在屏幕上
- (BOOL)isDisplayedInScreen;

@end

NS_ASSUME_NONNULL_END
