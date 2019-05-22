//
//  CategoryFillerView.m
//  TextureDemo
//
//  Created by zqp on 2019/5/21.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import "CategoryFillerView.h"
#import "PhotoCollectionViewCell.h"

@interface CategoryFillerView () <UIGestureRecognizerDelegate , UICollectionViewDelegate>

@property (nonatomic , strong) UICollectionView *brandCollectionView;//品牌的view
@property (nonatomic , strong) UICollectionView *purchasedGoodsCollectionView;//购买过商品的view
@property (nonatomic , strong) DataSourceModel *brandModel;
@property (nonatomic , strong) DataSourceModel *purchasedGoodsModel;

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
    
    
    UILabel *l = [UILabel new];
    [backView addSubview:l];
    [l mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(HPX(20)));
        make.top.equalTo(@(HPX(115)));
    }];
    l.font = HPMZFont(40);
    l.textColor = UIColorFromRGB(0x666666);
    l.text  = @"品牌";
    
    //搜索框 自行添加
    UIView *searchV = [UIView new];
    [backView addSubview:searchV];
    [searchV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(HPX(230)));
        make.centerY.equalTo(l.mas_centerY);
        make.height.equalTo(@(HPX(65)));
        make.width.equalTo(@(HPX(432)));

    }];
    searchV.backgroundColor = UIColorFromRGB(0xf4f4f4);
    searchV.layer.cornerRadius = HPX(32);
    
    UITextField *t = [UITextField new];
    [searchV addSubview:t];
    [t mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(HPX(35)));
        make.top.equalTo(@(0));
        make.right.equalTo(@(-HPX(35)));
        make.bottom.equalTo(@(HPX(0)));
    }];
    t.textColor = UIColorFromRGB(0x666666);
    t.font = HPMZFont(32);
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-(HPX(50))));
        make.centerY.equalTo(l.mas_centerY);
        make.width.equalTo(@(HPX(52)));
        make.height.equalTo(@(HPX(52)));
    }];
    [btn setBackgroundImage:[UIImage imageNamed:@"搜索"] forState:UIControlStateNormal];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"搜索品牌");
    }];
    
    [backView addSubview:self.brandCollectionView];
    [self.brandCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(HPX(20)));
        make.top.equalTo(@(HPX(204)));
        make.right.equalTo(@(-HPX(20)));
        make.height.equalTo(@(HPX(520)));
    }];
    
    @weakify(self);
    self.brandModel = [[DataSourceModel alloc]initWithCellID:NSStringFromClass([TitleCollectionViewCell class]) configureCellBlock:^(TitleCollectionViewCell * cell, id  _Nonnull item, NSIndexPath * _Nonnull indexPath) {
        [cell configWithTitle:self.brandsArr[indexPath.row]];
        [[cell.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            NSLog(@"index -- %ld" , indexPath.row);
            Goods *model = self.brandsArr[indexPath.row];
            model.select = !model.select;
            [self.brandCollectionView reloadData];
        }];
    }];
    self.brandCollectionView.dataSource = self.brandModel;
    RAC(self.brandModel,dataSource) = RACObserve(self, brandsArr);
    
    //价格区间
    PriceView *priceV = [PriceView new];
    [backView addSubview:priceV];
    [priceV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.top.equalTo(self.brandCollectionView.mas_bottom);
        make.height.equalTo(@(HPX(320)));
    }];
    
    
    
    UILabel *l2 = [UILabel new];
    [backView addSubview:l2];
    [l2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(HPX(20)));
        make.top.equalTo(priceV.mas_bottom).offset(HPX(40));
        make.height.equalTo(@(HPX(40)));
    }];
    l2.font = HPMZFont(40);
    l2.textColor = UIColorFromRGB(0x666666);
    l2.text  = @"购买过的商品";
    
    
    [backView addSubview:self.purchasedGoodsCollectionView];
    [self.purchasedGoodsCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(HPX(20)));
        make.top.equalTo(l2.mas_bottom).offset(HPX(50));
        make.right.equalTo(@(-HPX(20)));
        make.height.equalTo(@(HPX(560)));
    }];
    
    self.purchasedGoodsModel = [[DataSourceModel alloc]initWithCellID:NSStringFromClass([PurchasedGoodsCollectionViewCell class]) configureCellBlock:^(PurchasedGoodsCollectionViewCell * cell, id  _Nonnull item, NSIndexPath * _Nonnull indexPath) {
        [cell configWithItem:self.goodsArr[indexPath.row]];

    }];
    self.purchasedGoodsCollectionView.dataSource = self.purchasedGoodsModel;
    RAC(self.purchasedGoodsModel,dataSource) = RACObserve(self, goodsArr);
    
    [[self rac_signalForSelector:@selector(collectionView:didSelectItemAtIndexPath:) fromProtocol:@protocol(UICollectionViewDelegate)] subscribeNext:^(RACTuple *tuple) {
        //tuple.0 collection  tuple.1 indexPath
        NSLog(@"purchasedGoodsCollectionView select--------%@" ,tuple);
    }];
    
    //必须这样设置 才可以代替代理方法 （不知道为啥）
    self.purchasedGoodsCollectionView.delegate = nil;
    self.purchasedGoodsCollectionView.delegate = self;
    
    
    
    BottomView *bottomV = [BottomView new];
    [self addSubview:bottomV];
    [bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.purchasedGoodsCollectionView.mas_bottom);
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(0));
    }];
    
    [[bottomV.resetButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        //重置;
        @strongify(self);
        for (Goods *m in self.brandsArr) {
            m.select = NO;
        }
        [self.brandCollectionView reloadData];
        priceV.minTextField.text = priceV.maxTextField.text = @"";
    }];
    
    [[bottomV.confirmButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        //确定;
        [self dismissHintView];
    }];
    
}


- (UICollectionView *)brandCollectionView {
    
    if (!_brandCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = HPX(23);
        layout.minimumInteritemSpacing = 1;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;

        layout.itemSize = CGSizeMake(HPX(245), HPX(105));
        _brandCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _brandCollectionView.backgroundColor = [UIColor whiteColor];
        [_brandCollectionView registerClass:[TitleCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([TitleCollectionViewCell class])];
        
    }
    return _brandCollectionView;
}

- (UICollectionView *)purchasedGoodsCollectionView {
    
    if (!_purchasedGoodsCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = HPX(30);
        layout.minimumInteritemSpacing = HPX(10);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        layout.itemSize = CGSizeMake(HPX(300), HPX(400));
        _purchasedGoodsCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _purchasedGoodsCollectionView.backgroundColor = [UIColor whiteColor];
        [_purchasedGoodsCollectionView registerClass:[PurchasedGoodsCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([PurchasedGoodsCollectionViewCell class])];
//        _purchasedGoodsCollectionView.delegate = self;
        
    }
    return _purchasedGoodsCollectionView;
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
        [self.brandCollectionView reloadData];
        [self.purchasedGoodsCollectionView reloadData];
    } completion:nil];
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    NSLog(@"touch view class-%@" , [touch.view class]);
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"CategoryFillerView"]) {
        
        return YES;
    }else {
        
        [self endEditing:YES];
        return NO;
    }
    
}



@end




@implementation PriceView 

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if(self) {
//        self.backgroundColor = [UIColor redColor];
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    
    LineView *topL = [LineView new];
    [self addSubview:topL];
    [topL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.top.equalTo(@(HPX(40)));
        make.height.equalTo(@(0.5));
    }];
    
    UILabel *l = [UILabel new];
    [self addSubview:l];
    [l mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(HPX(20)));
        make.top.equalTo(topL.mas_bottom).offset(HPX(40));
        make.height.equalTo(@(HPX(40)));
    }];
    l.font = HPMZFont(40);
    l.textColor = UIColorFromRGB(0x666666);
    l.text = @"价格区间（元）";
    
    
    UITextField *minT = [UITextField new];
    [self addSubview:minT];
    [minT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(l.mas_left);
        make.top.equalTo(l.mas_bottom).offset(HPX(50));
        make.bottom.equalTo(@(-HPX(66)));
        make.width.equalTo(@(HPX(325)));
    }];
    minT.textColor = UIColorFromRGB(0x666666);
    minT.placeholder = @"最低价";
    minT.textAlignment = NSTextAlignmentCenter;
    
    UITextField *maxT = [UITextField new];
    [self addSubview:maxT];
    [maxT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-HPX(20)));
        make.top.equalTo(minT.mas_top);
        make.bottom.equalTo(minT.mas_bottom);
        make.width.equalTo(minT.mas_width);
    }];
    maxT.textColor = UIColorFromRGB(0x666666);
    maxT.placeholder = @"最高价";
    maxT.textAlignment = NSTextAlignmentCenter;
    
    minT.font = maxT.font = HPMZFont(35);
    minT.backgroundColor = maxT.backgroundColor = UIColorFromRGB(0xf6f6f6);
    minT.layer.cornerRadius = maxT.layer.cornerRadius = HPX(40);
    
    
    self.minTextField = minT;
    self.maxTextField = maxT;
    
    LineView *line = [[LineView alloc]initColor:UIColorFromRGB(0xcacaca)];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@(HPX(52)));
        make.height.equalTo(@(0.5));
        make.centerY.equalTo(minT.mas_centerY);
        
    }];
    
    
    
    LineView *bottpmL = [LineView new];
    [self addSubview:bottpmL];
    [bottpmL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(HPX(0)));
        make.height.equalTo(@(0.5));
    }];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self endEditing:YES];
}


@end


@implementation BottomView

-(instancetype)init {
    
    self= [super init];
    if (self) {
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    
    UIButton *btnR = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:btnR];
    [btnR mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(@(-HPX(66)));
        make.centerY.equalTo(self.mas_centerY).offset(-HPX(10));
        make.width.equalTo(@(HPX(255)));
        make.height.equalTo(@(HPX(100)));
    }];

    
    [btnR setTitle:@"确定" forState:UIControlStateNormal];
    btnR.titleLabel.font = HPMZFont(46);
    [btnR setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    UIImage *imgR = [UIImage gradientImageWithColors:@[UIColorFromRGB(0XFF7A00),UIColorFromRGB(0xFE560A)] rect:CGRectMake(0, 0, HPX(255), HPX(100)) cornerRadius:HPX(43) corners:UIRectCornerTopRight | UIRectCornerBottomRight];
    
    [btnR setBackgroundImage:imgR forState:UIControlStateNormal];
    
    UIButton *btnL = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:btnL];
    [btnL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.right.equalTo(btnR.mas_left).offset(1);
        make.centerY.equalTo(btnR.mas_centerY);
        make.width.equalTo(btnR.mas_width);
        make.height.equalTo(btnR.mas_height);
    }];
    
    [btnL setTitle:@"重置" forState:UIControlStateNormal];
    btnL.titleLabel.font = HPMZFont(46);
    [btnL setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    UIImage *imgL = [UIImage gradientImageWithColors:@[UIColorFromRGB(0XFFC500),UIColorFromRGB(0xFF9402)] rect:CGRectMake(0, 0, HPX(255), HPX(100)) cornerRadius:HPX(43) corners:UIRectCornerTopLeft | UIRectCornerBottomLeft];
    
    [btnL setBackgroundImage:imgL forState:UIControlStateNormal];
   
    self.resetButton = btnL;
    self.confirmButton = btnR;
    
    
}


@end
