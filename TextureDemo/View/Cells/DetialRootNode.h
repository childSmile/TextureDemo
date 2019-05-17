//
//  DetialRootNode.h
//  TextureDemo
//
//  Created by zqp on 2019/3/20.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import "ASDisplayNode.h"

@class ASCollectionNode;

NS_ASSUME_NONNULL_BEGIN

@interface DetialRootNode : ASDisplayNode

@property (nonatomic , strong) ASCollectionNode *collectionNode;
- (instancetype)initWithImageCategory:(NSString *)imageCategory;

@end

NS_ASSUME_NONNULL_END
