//
//  UIButton+Extend.h
//  TextureDemo
//
//  Created by zqp on 2019/5/16.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,ButtonEdgeInsetsStyle)
{
    ButtonEdgeInsetsStyleTop,//image在上，label在下
    ButtonEdgeInsetsStyleLeft,//image在左,label在右
    ButtonEdgeInsetsStyleBottom,//image在下，label在上
    ButtonEdgeInsetsStyleRight//image在右,label在左
};


NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Extend)

/**
 *  设置button内部的image和title的布局样式
 *
 *  @param style 布局样式
 *  @param space 间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(ButtonEdgeInsetsStyle)style imageTitleSpace:(CGFloat)space;

+ (UIButton *)creatBackBtn;

@end

NS_ASSUME_NONNULL_END
