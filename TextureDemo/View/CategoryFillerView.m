//
//  CategoryFillerView.m
//  TextureDemo
//
//  Created by zqp on 2019/5/21.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import "CategoryFillerView.h"
#import "PhotoCollectionViewCell.h"

@interface CategoryFillerView () <UIGestureRecognizerDelegate>

@property (nonatomic , strong) UICollectionView *brandCollectionView;//品牌的view
@property (nonatomic , strong) UICollectionView *purchasedGoodsCollectionView;//购买过商品的view

@end

@implementation CategoryFillerView

- (instancetype)initWithFrame:(CGRect)frame  {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutSubViews];
    }
    return self;
    
}
- (void)layoutSubViews {
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissHintView)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
    UIView *backView = [UIView new];
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(0));
        make.width.equalTo(@(HPX(800)));
        make.top.equalTo(@(0));
        make.bottom.equalTo(@(0));
    }];
    backView.backgroundColor = [UIColor whiteColor];
    
    self.brandsArr = @[@"安井" , @"海信" , @"正大" ,@"安井" , @"海信" , @"正大" ,@"安井" , @"海信" , @"正大" ,@"安井" , @"海信" , @"正大" ,];
    
    
    [backView addSubview:self.brandCollectionView];
    [self.brandCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(@(HPX(204)));
        make.right.equalTo(@(0));
        make.height.equalTo(@(520));
    }];
    DataSourceModel *m1 = [[DataSourceModel alloc]initWithCellID:NSStringFromClass([TitleCollectionViewCell class]) configureCellBlock:^(TitleCollectionViewCell * cell, id  _Nonnull item, NSIndexPath * _Nonnull indexPath) {
        [cell configWithTitle:self.brandsArr[indexPath.row]];
    }];
    self.brandCollectionView.dataSource = m1;
    RAC(m1,dataSource) = RACObserve(self, brandsArr);
    [self.brandCollectionView reloadData];
    
    
}

- (UICollectionView *)brandCollectionView {
    
    if (!_brandCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 2;
        layout.minimumInteritemSpacing = 2;
        _brandCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _brandCollectionView.backgroundColor = [UIColor redColor];
        [_brandCollectionView registerClass:[TitleCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([TitleCollectionViewCell class])];
//        _brandCollectionView.delegate = self;
    }
    return _brandCollectionView;
}

- (void)dismissHintView {
    
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)showView {
    
//    self.isShow = YES;
    
    [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:self];
    
    self.alpha = 0.0;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.alpha = 1.0;
//        [self.tab reloadData];
    } completion:nil];
}


@end
