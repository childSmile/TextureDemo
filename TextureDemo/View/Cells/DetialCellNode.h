//
//  DetialCellNode.h
//  TextureDemo
//
//  Created by zqp on 2019/3/20.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import "ASCellNode.h"

@interface DetialCellNode : ASCellNode

- (instancetype)initWithStr:(NSString *)str;

@property (nonatomic , assign) NSInteger row;
@property (nonatomic , copy) NSString *imageCategory;
@property (nonatomic , strong) ASNetworkImageNode *imageNode;

@property (nonatomic ,strong) ASButtonNode *carBtn;

- (void)configCell;

@end

