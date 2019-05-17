//
//  DetialViewController.h
//  TextureDemo
//
//  Created by zqp on 2019/3/20.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import "ASViewController.h"
#import "DetialRootNode.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetialViewController : ASViewController<ASCollectionNode *>

@property (nonatomic , strong) ASCollectionNode *collectionNode;
@property (nonatomic , copy) NSString *imageCategory;
//- (instancetype)initWithImageCategory:(NSString *)imageCategory;

@end

NS_ASSUME_NONNULL_END
