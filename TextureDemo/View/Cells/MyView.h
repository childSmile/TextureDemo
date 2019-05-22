//
//  MyView.h
//  TextureDemo
//
//  Created by zqp on 2019/5/8.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyView : UIView

@end

@interface TitleView : UIView

@property (weak, nonatomic) IBOutlet UIButton *cancleButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;


@end

@interface LineView : UIView

-(instancetype)initColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
