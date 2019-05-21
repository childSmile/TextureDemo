//
//  UIButton+Extend.m
//  TextureDemo
//
//  Created by zqp on 2019/5/16.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import "UIButton+Extend.h"

@implementation UIButton (Extend)


- (void)layoutButtonWithEdgeInsetsStyle:(ButtonEdgeInsetsStyle)style imageTitleSpace:(CGFloat)space
{
    //1、得到imageView和titleLabel的宽、高
    CGFloat imageWidth = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    CGFloat labelWidth = 0;
    CGFloat labelHeight = 0;
    if([UIDevice currentDevice].systemVersion.floatValue >=8.0)
    {
        //由于iOS8中titleLabel的size为0，分开设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    }
    else
    {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    //2、声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    //3、根据style和space设置
    switch (style) {
        case ButtonEdgeInsetsStyleTop:
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, -imageHeight-space/2.0, 0);
            break;
        case ButtonEdgeInsetsStyleLeft:
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, space/2.0);
            break;
        case  ButtonEdgeInsetsStyleBottom:
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, -imageWidth, 0);
            break;
        case  ButtonEdgeInsetsStyleRight:
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWidth - space/2.0, 0, imageWidth+space/2.0);
            break;
        default:
            break;
    }
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}


+ (UIButton *)creatBackBtn {
    
    //11- 13  修改返回按钮大小  在iOS11 上返回按钮较小
    UIImage *image = [UIImage imageNamed:@"btn_back_item"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = (CGRect){
        .origin.x = 0,
        .origin.y = 0,
        .size.width = 70,
        .size.height = 44
    };
    
    [button setImage:image forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;//设置按钮的图片位置居左
    
    return button;
    
}


@end
