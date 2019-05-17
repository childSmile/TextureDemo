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


@end



//@interface RecordModel : NSObject
//
//@property (nonatomic , strong) NSString *text;//3/包*2包
//@property (nonatomic , strong) NSString *price;//单价
//@property (nonatomic , strong) NSString *number;//数量
//@property (nonatomic , strong) NSString *unit;//单位 0包/1袋
//
//@end

NS_ASSUME_NONNULL_END
