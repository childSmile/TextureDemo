//
//  Province.h
//  TextureDemo
//
//  Created by zqp on 2019/5/9.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Province : NSObject

@property (nonatomic , strong)NSArray *cities;
@property (nonatomic , strong) NSString *name;
+ (instancetype)provinceWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
