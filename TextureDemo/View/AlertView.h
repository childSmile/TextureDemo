//
//  AlertView.h
//  TextureDemo
//
//  Created by zqp on 2019/4/23.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlertView : UIView
//- (instancetype)initWithFrame:(CGRect)frame dic:(NSDictionary *)dic ;
- (void)setupUIWithData:(NSDictionary *)dic;
@property (nonatomic , strong) RACSignal *singal;

@end

NS_ASSUME_NONNULL_END
