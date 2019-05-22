//
//  UIImage+ImageEffects.h
//  TextureDemo
//
//  Created by zqp on 2019/3/18.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ImageEffects)

-(UIImage*)applyLightEffect;

-(UIImage*)applyExtraLightEffect;

-(UIImage*)applyDarkEffect;

-(UIImage*)applyTintEffectWithColor:(UIColor*)tintColor;

-(UIImage*)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor*)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage*)maskImage;

/**
 生成一张渐变色的图片
 @param colors 颜色数组
 @param rect 图片大小
 @return 返回渐变图片
 */
+ (UIImage *)gradientImageWithColors:(NSArray *)colors rect:(CGRect)rect;
+ (UIImage *)gradientImageWithColors:(NSArray *)colors rect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius;
+ (UIImage *)gradientImageWithColors:(NSArray *)colors rect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius corners:(UIRectCorner)corners;

@end

NS_ASSUME_NONNULL_END
