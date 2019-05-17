//
//  ViewModel.h
//  TextureDemo
//
//  Created by zqp on 2019/4/3.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger , HTTPReauestStatus) {
    HTTPReauestStatusBegin,
    HTTPReauestStatusEnd,
    HTTPReauestStatusError,
};

NS_ASSUME_NONNULL_BEGIN

@interface ViewModel : NSObject


@property (nonatomic , strong) RACCommand *requestData;
@property (nonatomic , assign) HTTPReauestStatus requestStatus;
@property (nonatomic , strong) NSDictionary *data;
@property (nonatomic , strong) NSError *error;


@end

NS_ASSUME_NONNULL_END
