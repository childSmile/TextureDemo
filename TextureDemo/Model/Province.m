//
//  Province.m
//  TextureDemo
//
//  Created by zqp on 2019/5/9.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import "Province.h"

@implementation Province

+ (instancetype)provinceWithDic:(NSDictionary *)dic {
    
    Province *p = [Province new];
    [p setValuesForKeysWithDictionary:dic];
    return p;
}

@end
