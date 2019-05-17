//
//  DetialRootNode.m
//  TextureDemo
//
//  Created by zqp on 2019/3/20.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import "DetialRootNode.h"
#import "DetialCellNode.h"

static const NSInteger kImageHeight = 200;

@interface DetialRootNode ()<ASCollectionDelegate , ASCollectionDataSource>

@property (nonatomic , copy) NSString *imageCategory;
//@property (nonatomic, strong) ASCollectionNode *collectionNode;

@end

@implementation DetialRootNode

- (instancetype)initWithImageCategory:(NSString *)imageCategory {
    self = [super init];
    if (self) {
        self.automaticallyManagesSubnodes = YES;
        
        _imageCategory = imageCategory;
        UICollectionViewLayout *layout = [[UICollectionViewLayout alloc]init];
        _collectionNode = [[ASCollectionNode alloc]initWithCollectionViewLayout:layout];
        _collectionNode.delegate = self;
        _collectionNode.dataSource = self;
        _collectionNode.backgroundColor = [UIColor redColor];
        
        self.backgroundColor = [UIColor whiteColor];
        [self addSubnode:_collectionNode];
    }
    return self;
}

-(void)dealloc {
    _collectionNode.delegate = nil;
    _collectionNode.dataSource = nil;
    
}

#pragma mark - ASDisplayNode

//- (ASLayoutSpec *)layoutThatFits:(ASSizeRange)constrainedSize {
//    self.collectionNode.style.preferredSize = self.bounds.size;
//    return [ASWrapperLayoutSpec wrapperWithLayoutElement:self.collectionNode];
//}
//- (ASLayout *)calculateLayoutThatFits:(ASSizeRange)constrainedSize {
//    return [ASWrapperLayoutSpec wrapperWithLayoutElement:self.collectionNode];
//}

//- (CGSize)calculatedSize {
//    return  [super calculatedSize];
//}

#pragma mark - ASCollectionDataSource
- (NSInteger)collectionNode:(ASCollectionNode *)collectionNode numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (ASCellNodeBlock)collectionNode:(ASCollectionNode *)collectionNode nodeBlockForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *imag = self.imageCategory;
    return ^ {
        DetialCellNode *node = [[DetialCellNode alloc]init];;
        node.row = indexPath.row;
        node.imageCategory = imag;
        node.style.preferredSize = CGSizeMake(100, 100);
        return node;
    };
}

- (ASSizeRange)collectionNode:(ASCollectionNode *)collectionNode constrainedSizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"frame -- %@" , NSStringFromCGRect(collectionNode.view.frame));
    CGSize imageSize = CGSizeMake(CGRectGetWidth(collectionNode.view.frame), kImageHeight);
//    CGSize imageSize = CGSizeMake(kImageHeight, kImageHeight);
    return ASSizeRangeMake(imageSize , imageSize);
}


@end
