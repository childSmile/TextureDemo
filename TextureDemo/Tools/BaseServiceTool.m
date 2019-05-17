//
//  BaseServiceTool.m
//  TextureDemo
//
//  Created by zqp on 2019/4/3.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import "BaseServiceTool.h"

@interface BaseServiceTool ()

//@property (nonatomic , strong) AFHTTPSessionManager *sessionManager;

@end

@implementation BaseServiceTool

+ (NSString *)dicToStr:(NSDictionary *)dic {
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    
    NSString * str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
  
    return str;
}

+ (AFHTTPSessionManager *)sessionManager {
    
    AFHTTPSessionManager * sessionManager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:@""]];
    sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    return sessionManager;
}

+ (RACSignal *)fetechData {
    @weakify(self);
    RACSignal *fetchData = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        NSURLSessionDataTask *task = [[self sessionManager] GET:@"" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [subscriber sendError:error];
        }];
        return [RACDisposable disposableWithBlock:^{
            if (task.state != NSURLSessionTaskStateCompleted) {
                [task cancel];
            }
        }];
    }] replayLazily];
    return fetchData;
}


// 根据输入尺寸修改图片大小，并返回UIImage
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}


// 计算文本高度
+ (CGFloat)textHeightWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width {
    
    // iOS7.0中求文本高度的方法，返回一个CGRect的高度
    
    // 第一个参数
    CGSize size = CGSizeMake(width, 10000);
    
    // 第二个参数：设置以行高为单位
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil];
    
    return rect.size.height;
}

// 计算图片高度
+ (CGFloat)imageHeightWithImage:(UIImage *)image {
    
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    //    float scile = height / width;
    //
    //    float screenH = [UIScreen mainScreen].bounds.size.width;
    
    
    NSLog(@"%f", width);
    //    return  scile * screenH;
    return height / width * [UIScreen mainScreen].bounds.size.width;
}

// 计算文本宽度
+ (CGFloat)textWidthWithText:(NSString *)text font:(UIFont *)font {
    
    // iOS7.0中求文本高度的方法，返回一个CGRect的高度
    
    // 第一个参数
    CGSize size = CGSizeMake(100000, 25);
    
    // 第二个参数：设置以行高为单位
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil];
    
    return rect.size.width;
}


@end
