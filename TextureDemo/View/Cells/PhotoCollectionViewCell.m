//
//  PhotoCollectionViewCell.m
//  TextureDemo
//
//  Created by zqp on 2019/5/17.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@interface PhotoCollectionViewCell ()

@end

@implementation PhotoCollectionViewCell



- (void)configWith:(UIImage *)image {
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }

    UIImageView *imgV = [[UIImageView alloc]init];
    imgV.contentMode = UIViewContentModeScaleAspectFit;
    imgV.layer.cornerRadius = 5;
    imgV.userInteractionEnabled = YES;

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [imgV addSubview:btn];
    [btn setBackgroundImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.right.equalTo(@(0));
        make.width.equalTo(@(HPX(72)));
        make.height.equalTo(@(HPX(72)));
    }];
    
    imgV.image = image;
    [self addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    self.deleteSingal = [btn rac_signalForControlEvents:UIControlEventTouchUpInside];

    
}

@end


@interface TitleCollectionViewCell ()

@end

@implementation TitleCollectionViewCell



- (void)configWithTitle:(NSString *)title {
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:btn];
    [btn setBackgroundImage:[UIImage imageNamed:@"标签选中背景"] forState:UIControlStateSelected];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.right.equalTo(@(0));
        make.width.equalTo(@(HPX(245)));
        make.height.equalTo(@(HPX(105)));
    }];

    [btn setTitle:title forState:UIControlStateNormal];
    btn.backgroundColor = UIColorFromRGB(0xf4f4f4);
    [btn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    [btn setTitleColor:UIColorFromRGB(0xff5000) forState:UIControlStateSelected];
    btn.titleLabel.font = HPMZFont(35);
    
}

@end
