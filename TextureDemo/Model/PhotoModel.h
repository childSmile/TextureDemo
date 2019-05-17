//
//  PhotoModel.h
//  TextureDemo
//
//  Created by zqp on 2019/3/20.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoModel : NSObject


@property (nonatomic , strong) NSString *text;
@property (nonatomic , strong) NSString *isSelect;

@property (nonatomic , strong) NSString *n;



+ (PhotoModel *)creatModel:(NSDictionary *)dic;

@end




NS_ASSUME_NONNULL_END
