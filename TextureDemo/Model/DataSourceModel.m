//
//  DataSourceModel.m
//  TextureDemo
//
//  Created by zqp on 2019/4/10.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import "DataSourceModel.h"

@interface DataSourceModel  ()

@property (nonatomic , copy) NSString *cellID;
@property (nonatomic , copy) ConfigureCellBlock cellBlock;

@end

@implementation DataSourceModel

- (instancetype)initWithCellID:(NSString *)cellid configureCellBlock:(ConfigureCellBlock)cellBlock {
    if ([super init]) {
        _cellID = cellid;
        _cellBlock = cellBlock;
    }
    return self;
}
#pragma mark - AStableview

- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (ASCellNode *)tableNode:(ASTableNode *)tableNode nodeForRowAtIndexPath:(NSIndexPath *)indexPath {
    ASCellNode *cell = [[NSClassFromString(self.cellID) alloc]init];
    if (_cellBlock) {
        _cellBlock(cell , self.dataSource[indexPath.row] , indexPath);
    }
    return cell;
}

#pragma mark - AScollectionview

- (ASCellNode *)collectionNode:(ASCollectionNode *)collectionNode nodeForItemAtIndexPath:(NSIndexPath *)indexPath {
    ASCellNode *cell = [[NSClassFromString(self.cellID) alloc]init];
    if (_cellBlock) {
        _cellBlock(cell , self.dataSource[indexPath.row] , indexPath);
    }
    return cell;
}

- (NSInteger)collectionNode:(ASCollectionNode *)collectionNode numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}


#pragma mark - tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellID forIndexPath:indexPath];
    
    if (_cellBlock) {
        _cellBlock(cell, _dataSource[indexPath.row], indexPath);
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

#pragma mark - UICollectionView
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellID forIndexPath:indexPath];
    if (_cellBlock) {
        _cellBlock(cell , self.dataSource[indexPath.row] , indexPath);
    }
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}


@end
