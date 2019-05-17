//
//  ViewModel.m
//  TextureDemo
//
//  Created by zqp on 2019/4/3.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import "ViewModel.h"

@implementation ViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self subcribeCommandSignals];
    }
    return self;
}

- (RACCommand *)requestData {
    if (!_requestData) {
        @weakify(self);
        _requestData = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(NSString * input) {
            @strongify(self);
//            NSDictionary *body = @{@"code" : input};
            //进行网络操作，同事将这个操作封装成信号返回
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                //网络请求
                if ([input isEqualToString: @"1"]) {
                    [subscriber sendNext:[self getData]];
                    [subscriber sendCompleted];
                    
                } else {
                    [subscriber sendError:nil];
                }
                return nil;
            }];
        }];
    }
    return _requestData;
}


- (NSDictionary *)getData {
    return @{@"11" : @"333" , @"333" : @"rrrrr"};
}

- (void)subcribeCommandSignals {
    
    @weakify(self);
    //订阅外层信号
    [self.requestData.executionSignals subscribeNext:^(RACSignal *innerSignal) {
        @strongify(self);
        //订阅内部信号
        [innerSignal subscribeNext:^(NSDictionary * x) {
            self.data = x;
            self.requestStatus = HTTPReauestStatusEnd;
        }];
        
        self.error = nil;
        self.requestStatus = HTTPReauestStatusBegin;
    }];
    
    //订阅errors信号
    [self.requestData.errors subscribeNext:^(NSError * x) {
        @strongify(self);
        self.error = x;
        self.data = nil;
        self.requestStatus = HTTPReauestStatusError;
        
    }];
    
    
}


@end
