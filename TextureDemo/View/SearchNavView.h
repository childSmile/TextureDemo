//
//  SearchNavView.h
//  TextureDemo
//
//  Created by zqp on 2019/3/29.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger , SearchNavStyle) {
    SearchNavStyleNone,
    SearchNavStyleLeft,
    SearchNavStyleRight,
    SearchNavStyleCenter,
};

@interface SearchNavView : UIView

//- (instancetype)initWithSearchFrame:(CGRect)frame;

- (instancetype)initWithFrame:(CGRect)frame style:(SearchNavStyle)style;

@property (nonatomic , strong) RACSignal *searchSignal;
@property (nonatomic , strong) UITextField *textField;


@end

NS_ASSUME_NONNULL_END
