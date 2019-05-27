//
//  CategoryButtonView.m
//  TextureDemo
//
//  Created by zqp on 2019/5/21.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import "CategoryButtonView.h"

@implementation CategoryButtonView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    
    
    // 排序  筛选  按钮

    
    UIView *lineV = [UIView new];
    [self addSubview:lineV];
    lineV.backgroundColor = UIColorFromRGB(0xebebeb);
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(@(0.5));
        make.height.equalTo(@(HPX(63)));
    }];
    
    UIView *bottomLineV = [UIView new];
    bottomLineV.backgroundColor = UIColorFromRGB(0xebebeb);
    [self addSubview:bottomLineV];
    [bottomLineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(HPX(30));
        make.right.equalTo(self.mas_right).offset(-HPX(30));
        make.bottom.equalTo(self.mas_bottom);
        make.height.equalTo(@(0.5));
        
    }];
    
    
    UIButton *paixuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [paixuBtn setTitle:@"综合排序" forState:UIControlStateNormal];
    [self addSubview:paixuBtn];
    [paixuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(lineV.mas_left);
        make.height.equalTo(self.mas_height);
        make.top.equalTo(@(0));
    }];
    [paixuBtn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
    [paixuBtn setTitleColor:UIColorFromRGB(0xff5000) forState:UIControlStateSelected];
    paixuBtn.titleLabel.font = HPMZFont(35);
    [paixuBtn setImage:[UIImage imageNamed:@"箭头"] forState:UIControlStateNormal];
    [paixuBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleRight imageTitleSpace:5] ;
    paixuBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.sortBtn = paixuBtn;
    
    
    
    UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [self addSubview:selectBtn];
    [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineV.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(self.mas_height);
        make.top.equalTo(@(0));
    }];
    [selectBtn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
    [selectBtn setTitleColor:UIColorFromRGB(0xff5000) forState:UIControlStateSelected];
    selectBtn.titleLabel.font = HPMZFont(35);
    [selectBtn setImage:[UIImage imageNamed:@"筛选"] forState:UIControlStateNormal];
    [selectBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleRight imageTitleSpace:5];
    selectBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.filtterBtn = selectBtn;
    
}



@end
