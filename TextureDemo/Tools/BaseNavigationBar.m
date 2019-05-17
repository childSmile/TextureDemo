//
//  BaseNavigationBar.m
//  TextureDemo
//
//  Created by zqp on 2019/4/16.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import "BaseNavigationBar.h"


@interface BaseNavigationBar ()

@property (nonatomic , strong) UILabel *titleLabel ;

@end

@implementation BaseNavigationBar

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}


- (void)setUI {
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(StatusHeight/2.0);

    }];
    RAC(self.titleLabel,text) = RACObserve(self, title);
    
   
    
    
    
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:15.0];
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        
        
    }
    return _titleLabel;
}


@end
