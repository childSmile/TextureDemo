//
//  DataSourceModel.h
//  TextureDemo
//
//  Created by zqp on 2019/4/10.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ConfigureCellBlock) (id cell , id item, NSIndexPath *indexPath);

@interface DataSourceModel : NSObject <ASTableDataSource ,ASCollectionDataSource ,UITableViewDataSource,UICollectionViewDataSource >

@property (nonatomic , strong) NSArray *dataSource;

- (instancetype)initWithCellID:(NSString *)cellid configureCellBlock:(ConfigureCellBlock)cellBlock;


@end

NS_ASSUME_NONNULL_END
