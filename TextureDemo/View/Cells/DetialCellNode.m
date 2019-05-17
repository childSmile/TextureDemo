//
//  DetialCellNode.m
//  TextureDemo
//
//  Created by zqp on 2019/3/20.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import "DetialCellNode.h"
static const NSInteger kImageHeight = 100;

@interface DetialCellNode ()

@property (nonatomic, strong) ASTextNode *titleNode;
@property (nonatomic , strong) ASTextNode *salesNode;
@property (nonatomic , strong) ASTextNode *priceNode;


@end


@implementation DetialCellNode

- (instancetype)initWithStr:(NSString *)str {
    self = [super init];
    if (self) {
        
       
        self.imageCategory = str;
        [self setUI];

        
        self.borderColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1.0].CGColor;
        self.borderWidth = 0.5;
        
        
        self.backgroundColor = [UIColor whiteColor];
    }
    
    
    return self;
}


- (void)configCell {
    
    self.borderColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1.0].CGColor;
    self.borderWidth = 0.5;
    
    
    self.backgroundColor = [UIColor whiteColor];
    [self setUI];
}

- (void)setUI {
    
    _imageNode = [[ASNetworkImageNode alloc]init];
    //        _imageNode.backgroundColor = ASDisplayNodeDefaultPlaceholderColor();
            _imageNode.backgroundColor = [UIColor whiteColor];
    _imageNode.contentMode = UIViewContentModeScaleAspectFit;
    _imageNode.borderColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1.0].CGColor;
    _imageNode.borderWidth = 2;
    
    [self addSubnode:_imageNode];
    
    
    
    _titleNode = [[ASTextNode alloc]init];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    style.lineSpacing = 2;
    style.lineBreakMode = NSLineBreakByTruncatingTail;
    
    _titleNode.maximumNumberOfLines = 2;
    //规格:60g*15串*10包/箱123456789012 华清源（新奥尔良）腿排（100g*10片/包）
    _titleNode.attributedText = [[NSAttributedString alloc]initWithString:@"规格:60g*15串*10包/箱777777777 "
                                                               attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:9.0],
                                                                            NSForegroundColorAttributeName: [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0],
                                                                            NSParagraphStyleAttributeName : style}];
    [self addSubnode:_titleNode];
    
    _salesNode = [[ASTextNode alloc]init];
    _salesNode.attributedText = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@" 月销量%d件" , arc4random() % (200 - 10 + 1) + 10]
                                                               attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Medium" size: 8],NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:112/255.0 blue:60/255.0 alpha:1.0]}];
    [self addSubnode:_salesNode];
    
    _priceNode = [[ASTextNode alloc]init];
    NSString *price = @"￥15.90/箱uuuuuuuuuuuuuu";
    
    NSMutableAttributedString *priceAtt = [[NSMutableAttributedString alloc]initWithString:price];
    [priceAtt addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Medium" size: 13.5] ,NSForegroundColorAttributeName: [UIColor blackColor]} range:NSMakeRange(0, price.length)];
    
    [priceAtt addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Medium" size: 9], NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]} range:[price rangeOfString:@"/箱"]];
    _priceNode.truncationMode = NSLineBreakByTruncatingTail;
    
    _priceNode.attributedText = priceAtt;
    [self addSubnode:_priceNode];
    
    
    _carBtn = [[ASButtonNode alloc]init];
    [_carBtn setImage:[UIImage imageNamed:@"car"] forState:UIControlStateNormal];
    [self addSubnode:_carBtn];
    
}

#pragma mark - ASDisplayNode
- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    self.imageNode.style.preferredSize = CGSizeMake(constrainedSize.min.width, kImageHeight);
    self.titleNode.style.preferredSize = CGSizeMake(self.imageNode.style.preferredSize.width, 25);
    self.priceNode.style.preferredSize = CGSizeMake(self.imageNode.style.preferredSize.width / 2.0, 15);
    ASStackLayoutSpec *hSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:20 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter children:@[_priceNode,_carBtn]];
    ASInsetLayoutSpec *iSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(-4, 0, 0, 0) child:hSpec];
    
    ASStackLayoutSpec *spec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                                                      spacing:5
                                                               justifyContent:ASStackLayoutJustifyContentStart
                                                                   alignItems:ASStackLayoutAlignItemsStart
                                                                     children:@[self.imageNode , _titleNode,_salesNode , iSpec]];
    return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(8, 8, 8, 8) child:spec];
}

- (void)layoutDidFinish {
    [super layoutDidFinish];
    
    self.imageNode.URL = [self imageURL];
  
}

- (NSURL *)imageURL {
    
    NSString *imageURLString = @"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2276391059,2676039382&fm=26&gp=0.jpg";
    return [NSURL URLWithString:imageURLString];
}



@end
