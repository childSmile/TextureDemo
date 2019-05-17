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


@end

NS_ASSUME_NONNULL_END
