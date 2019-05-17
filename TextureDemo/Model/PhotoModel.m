//
//  PhotoModel.m
//  TextureDemo
//
//  Created by zqp on 2019/3/20.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import "PhotoModel.h"

@implementation PhotoModel

+ (PhotoModel *)creatModel:(NSDictionary *)dic {
    
    PhotoModel *model = [PhotoModel new];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
