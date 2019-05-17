//
//  ASCollectionCellNode.m
//  TextureDemo
//
//  Created by zqp on 2019/3/28.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import "ASCollectionCellNode.h"
#import "DetialCellNode.h"


@interface ASCollectionCellNode  ()<ASCollectionDelegate , ASCollectionDataSource>

@property (nonatomic , strong) NSArray *datdArray;
@property (nonatomic , strong) ASCollectionNode *collectionNode;
@property (nonatomic , strong) id currentCellClass;

@end

@implementation ASCollectionCellNode

- (instancetype)initWithData:(NSArray *)array {
    self = [super init];
    if (self) {
        self.datdArray = array;
        [self setUI];
    }
    return self;
}

- (instancetype)initWithData:(NSArray *)array cellClass:(id)cellClass {
    
    if ([self initWithData:array]) {
        self.currentCellClass = cellClass;
    }
    return self;
    
}

- (void)setUI {
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    ASCollectionNode *node = [[ASCollectionNode alloc]initWithCollectionViewLayout:flow];
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    if ([_currentCellClass isKindOfClass:[DetialCellNode class]]) {
//
//    } else if ([_currentCellClass isKindOfClass:[ASIamgeTitleNode class]]) {
//
//        _collectionNode.view.scrollEnabled = NO;
//    }
    flow.minimumLineSpacing = 0;
    flow.minimumInteritemSpacing = 0;
    
    _collectionNode = node;
    [self addSubnode:_collectionNode];
    
    _collectionNode.delegate = self;
    _collectionNode.dataSource = self;
    
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    
    
        _collectionNode.style.preferredSize = CGSizeMake(self.datdArray.count * (kMainScreen_width / 3.0), 200);
        return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(0 , 0, 0, 0) child:_collectionNode];
  
}



- (NSInteger)collectionNode:(ASCollectionNode *)collectionNode numberOfItemsInSection:(NSInteger)section {
    
    return self.datdArray.count;
}


- (ASCellNode *)collectionNode:(ASCollectionNode *)collectionNode nodeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
        DetialCellNode *cell = [[DetialCellNode alloc]initWithStr:@""];
//    [cell.carBtn addTarget:self action:@selector(buy:) forControlEvents:ASControlNodeEventTouchUpInside];
    
    
        return cell;
 
}

- (void)buy:(id)sender {
    NSLog(@"12344555");
}

- (void)collectionNode:(ASCollectionNode *)collectionNode didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"777777777777");
}

- (ASSizeRange)collectionNode:(ASCollectionNode *)collectionNode constrainedSizeForItemAtIndexPath:(NSIndexPath *)indexPath {

        
        return ASSizeRangeMake(CGSizeMake(kMainScreen_width / 3.0, 100), CGSizeMake(kMainScreen_width /3.0, 200));
   
}

@end
