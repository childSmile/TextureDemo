//
//  WaterFallLayout.m
//  TextureDemo
//
//  Created by zqp on 2019/12/26.
//  Copyright © 2019 zqp. All rights reserved.
//

#import "WaterFallLayout.h"


/** 默认的列数    */
static const CGFloat DefaultColunmCount = 2;
/** 每一列之间的间距    */
static const CGFloat DefaultColunmMargin = 10;

/** 每一行之间的间距    */
static const CGFloat DefaultRowMargin = 10;

/** 内边距    */
static const UIEdgeInsets DefaultEdgeInsets = {10,10,10,10};

@interface WaterFallLayout ()

/**存放所有的布局属性 */
@property (nonatomic , strong) NSMutableArray *attrsArr;
/** 存放所有列的当前高度*/
@property (nonatomic , strong) NSMutableArray *columnHeights;
/** 内容的高度*/
@property (nonatomic , assign) CGFloat contentHeight;

- (NSInteger)columnCount;
-(CGFloat)columnMargin;
-(CGFloat)rowMargin;
-(UIEdgeInsets)edgeInsets;

@end

@implementation WaterFallLayout

#pragma mark - 懒加载
- (NSMutableArray *)attrsArr {
    if (!_attrsArr) {
        _attrsArr = [NSMutableArray array];
    }
    return _attrsArr;
}

- (NSMutableArray *)columnHeights {
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
        
    }
    
    return _columnHeights;
}
#pragma mark - 数据处理
//列数
-(NSInteger)columnCount {
    if ([self.delegate respondsToSelector:@selector(columnCountInWaterFallLayout:)]) {
        return [self.delegate columnCountInWaterFallLayout:self];
    } else {
        return DefaultColunmCount;
    }
}

//列间距
- (CGFloat)columnMargin {
    if ([self.delegate respondsToSelector:@selector(columnMarginInWaterFallLayout:)]) {
        return [self.delegate columnMarginInWaterFallLayout:self];
    }else {
        return DefaultColunmMargin;
    }
}

//行间距
- (CGFloat)rowMargin {
    if ([self.delegate respondsToSelector:@selector(rowMarginInWaterFallLayout:)]) {
        return [self.delegate rowMarginInWaterFallLayout:self];
    }else {
        return DefaultRowMargin;
    }
}

//边内距
- (UIEdgeInsets)edgeInsets {
    if ([self.delegate respondsToSelector:@selector(edgeInsetdInWaterFallLayout:)]) {
        return [self.delegate edgeInsetdInWaterFallLayout:self];
    }else {
        return DefaultEdgeInsets;
    }
}

#pragma mark - 初始化
-(void)prepareLayout {
    [super prepareLayout];
    self.contentHeight = 0;

    [self.columnHeights removeAllObjects];
    
    //设置每列的默认高度
    for (NSInteger i = 0 ; i < DefaultColunmCount; i++) {
        [self.columnHeights addObject:@(DefaultEdgeInsets.top)];
    }
    
    //清除布局属性
    [self.attrsArr removeAllObjects];
    
    //创建布局属性
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        //获取indexpath对应位置上的布局属性
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArr addObject:attrs];
    }
    
    
}


//返回indexpath位置的cell对应的布局属性
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //创建布局属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    //collectionview 宽度
    CGFloat collectionViewW = self.collectionView.frame.size.width;
    
    //设置布局属性frame
    CGFloat cellW = (collectionViewW - self.edgeInsets.left - self.edgeInsets.right - (self.columnCount - 1) * self.columnMargin) / self.columnCount;
    CGFloat cellH = [self.delegate waterFallLayout:self heightForItemAtIndexPath:indexPath.item itemWidth:cellW];
    
    //找出最短的那一列
    NSInteger destColumn = 0;
    CGFloat minColumnHeight = [self.columnHeights[0] doubleValue];
    
    for (int i = 0; i < DefaultColunmCount; i++) {
        CGFloat columH = [self.columnHeights[i] doubleValue];
        if (minColumnHeight > columH) {
            minColumnHeight = columH;
            destColumn = i;
        }
    }
    
    CGFloat cellX = self.edgeInsets.left + destColumn * (cellW + self.columnMargin );
    CGFloat cellY = minColumnHeight;
    if (cellY != self.edgeInsets.top) {
        cellY += self.rowMargin;
    }
    
    attrs.frame = CGRectMake(cellX, cellY, cellW, cellH);
    
    //更新最短那一列的高度
    self.columnHeights[destColumn] = @(CGRectGetMaxY(attrs.frame));
    
    //记录内容的高度 - 即最长那一列的高度
    CGFloat maxColumnH = [self.columnHeights[destColumn] doubleValue];
    if (self.contentHeight < maxColumnH){
        self.contentHeight = maxColumnH;
    }
    
    return attrs;
    
    
}


//决定cell的高度
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attrsArr;
}

//内容的高度
- (CGSize)collectionViewContentSize {
    return CGSizeMake(0, self.contentHeight + self.edgeInsets.bottom);
}

@end
