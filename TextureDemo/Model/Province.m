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


+ (NSDictionary *)mj_objectClassInArray{
    return @{@"cityNames" : @"City"};//前边，是属性数组的名字，后边就是类名
    
}

@end


@implementation City



@end
