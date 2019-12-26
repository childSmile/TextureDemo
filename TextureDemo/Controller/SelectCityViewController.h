//
//  SelectCityViewController.h
//  TextureDemo
//
//  Created by zqp on 2019/12/18.
//  Copyright © 2019 zqp. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Province;

NS_ASSUME_NONNULL_BEGIN

@interface SelectCityViewController : UIViewController


@property (nonatomic , copy) void (^ selectAddress)(NSString *address);

@end





@interface ButtonView : UIView

@property (nonatomic , strong) NSNumber *cellHeight;
@property (nonatomic , strong) NSArray *buttonSingalsArray;
+(UIView *)creatVieWithArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
