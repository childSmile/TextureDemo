//
//  BaseServiceTool.h
//  TextureDemo
//
//  Created by zqp on 2019/4/3.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseServiceTool : NSObject

+ (NSString *)dicToStr:(NSDictionary *)dic;


// 根据输入尺寸修改图片大小，并返回UIImage
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;

// 声明类方法用来计算文本高度
+ (CGFloat)textHeightWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width;

// 声明类方法用来计算图片的高度
+ (CGFloat)imageHeightWithImage:(UIImage *)image;

// 声明类方法用来计算文本宽度
+ (CGFloat)textWidthWithText:(NSString *)text font:(UIFont *)font;



@end

NS_ASSUME_NONNULL_END
