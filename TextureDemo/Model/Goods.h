//
//  Goods.h
//  TextureDemo
//
//  Created by zqp on 2019/5/14.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Goods : NSObject

@property (nonatomic , strong) NSString *title;
@property (nonatomic , strong) NSArray *arr;
@property (nonatomic , strong) NSString *buyType;//购买类型  显示图片 0团，1惠，2秒

@property (nonatomic , strong) NSString *brandTitle;//标签title
@property (nonatomic , assign) BOOL select;//是否选中
@property (nonatomic , strong) NSString *totalAmount;//这个cell的总金额
@property (nonatomic , assign) CGPoint offset;

@end



NS_ASSUME_NONNULL_END
