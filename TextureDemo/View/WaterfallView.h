//
//  WaterfallView.h
//  TextureDemo
//
//  Created by zqp on 2019/4/15.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WaterfallView : UIView

- (instancetype)initWithFrame:(CGRect)frame arr:(NSArray *)arr;
@property (nonatomic , strong) NSArray *btnSingals;
@property (nonatomic , strong) NSArray *buttonsArr;


- (void)show;
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
