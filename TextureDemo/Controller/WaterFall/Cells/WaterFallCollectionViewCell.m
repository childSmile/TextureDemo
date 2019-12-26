//
//  WaterFallCollectionViewCell.m
//  TextureDemo
//
//  Created by zqp on 2019/12/26.
//  Copyright © 2019 zqp. All rights reserved.
//

#import "WaterFallCollectionViewCell.h"
#import "GoodsModel.h"


static CGFloat space = 30;
static CGFloat ImageHeight = 438;

@interface WaterFallCollectionViewCell ()

@property (nonatomic , strong) UIImageView *img;
@property (nonatomic , strong) UILabel *titleL;
@property (nonatomic , strong) UILabel *priceL;
@property (nonatomic , strong) UIButton *addButton;

@end

@implementation WaterFallCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

-(void)setUI {
    
    self.layer.cornerRadius = HPX(30);
    self.backgroundColor = UIColorFromRGB(0xffffff);
    
    UIImageView *img = [[UIImageView alloc]init];
    [self addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(HPX(space)));
        make.left.equalTo(@(HPX(space)));
        make.right.equalTo(@(HPX(-space)));
        make.height.equalTo(@(HPX(ImageHeight)));
    }];
    
    UILabel *l1 = [UILabel new];
    [self addSubview:l1];
    [l1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(img.mas_bottom).offset((HPX(43)));
        make.left.equalTo(img.mas_left);
        make.right.equalTo(img.mas_right);
    }];
    
    l1.numberOfLines = 2;
    l1.font = HPMZFont(40);
    l1.textColor = UIColorFromRGB(0x333333);
    
    UILabel *l2 = [UILabel new];
    [self addSubview:l2];
    [l2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(l1.mas_bottom).offset((HPX(43)));
        make.left.equalTo(img.mas_left);
    }];
    
    l2.font = HPMZFont(46);
    l2.textColor = UIColorFromRGB(0xFF5000);
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
//    btn.backgroundColor = UIColorFromRGB(0xFF5000);
    [self addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(img.mas_right);
        make.centerY.equalTo(l2.mas_centerY);
        make.size.equalTo(@(CGSizeMake(HPX(78), HPX(78))));
    }];
    
    
    self.img = img;
    self.titleL = l1;
    self.priceL = l2;
    self.addButton = btn;
    
    
}


- (void)configWithItem:(GoodsModel *)m {
    
    self.img.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:m.imgUrl]]];
    self.titleL.text = m.title;
    self.priceL.text = [NSString stringWithFormat:@"¥ %@" , m.price];
}

@end
