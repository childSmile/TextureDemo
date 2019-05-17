//
//  ShowAnimationView.h
//  TextureDemo
//
//  Created by zqp on 2019/4/10.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShowAnimationView : UIView

- (instancetype)initWithFrame:(CGRect)frame data:(NSArray *)data ;

- (void)showView;
- (void)dismissHintView;

@property (nonatomic , assign) BOOL isShow;

@property (nonatomic , copy) void(^selectBlock)(NSIndexPath *indexPath);

@end

NS_ASSUME_NONNULL_END
