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


@property (nonatomic , strong)NSArray *cityNames;
@property (nonatomic , strong) NSString *provinceName;

@end


@interface City : NSObject

@property (nonatomic , strong)NSArray *areaNames;
@property (nonatomic , strong) NSString *cityName;

@end

NS_ASSUME_NONNULL_END
