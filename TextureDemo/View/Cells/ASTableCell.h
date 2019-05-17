//
//  ASTableCell.h
//  TextureDemo
//
//  Created by zqp on 2019/3/26.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import "ASCellNode.h"

#import "PhotoModel.h"


NS_ASSUME_NONNULL_BEGIN


@interface ASButtonCell : ASCellNode

@property (nonatomic , assign) BOOL isSelected;


- (instancetype)initWithTitle:(NSString *)title indexPath:(NSIndexPath *)indexPath  currentRow:(NSInteger )currentRow;

- (void)configCellWithDic:(NSDictionary *)dic;


@end


@interface ASTableCell : ASCellNode

- (instancetype)initWithText:(NSString *)text ;
@property (nonatomic , copy) void (^buyAction)(NSString * text) ;

- (void) configCellWithItem:(id)item ;

@property (nonatomic , assign) BOOL dd;


@end


@interface LittleView :  UIView
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *danweiLabel;
@property (weak, nonatomic) IBOutlet UIButton *minusBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@property (weak, nonatomic) IBOutlet UITextField *numberTextField;

- (instancetype)initWithFrame:(CGRect)frame open:(BOOL)isOpen;

@end


NS_ASSUME_NONNULL_END
