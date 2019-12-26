//
//  SalesReturnCell.h
//  TextureDemo
//
//  Created by zqp on 2019/5/14.
//  Copyright © 2019年 zqp. All rights reserved.
//  退货cell

#import <UIKit/UIKit.h>
#import "PhotoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SalesReturnCell : UITableViewCell

- (void)configItem:(Goods *)model;
@property (nonatomic , strong) NSMutableArray *btnSingals;//单位按钮点击事件
@property (nonatomic , strong) NSMutableArray *amountSingals;


@end

NS_ASSUME_NONNULL_END
