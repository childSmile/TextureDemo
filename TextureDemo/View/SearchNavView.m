//
//  SearchNavView.m
//  TextureDemo
//
//  Created by zqp on 2019/3/29.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import "SearchNavView.h"



@interface SearchNavView ()

@property (nonatomic , strong)NSArray *items;
@property (nonatomic , strong)UIButton *searchBtn;
@property (nonatomic , strong) UIView *searchView;
@property (nonatomic , assign) SearchNavStyle style;//默认搜索居右

@end

@implementation SearchNavView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        _style = SearchNavStyleRight;
        [self setUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(SearchNavStyle)style {
    
    if ([super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        _style = style;
        [self setUI];
    }
    return self;
}

- (void)setUI {
    
//    UISearchBar *bar = [[UISearchBar alloc]init];
//    [self addSubview:bar];
//
//    @weakify(self);
//    [bar mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self);
//        make.centerY.equalTo(self.mas_centerY).mas_offset(10);
//        if (self.items.count % 2 == 0) {
//            make.centerX.equalTo(self.mas_centerX);
//        }
//        make.height.equalTo(@26);
//        make.width.equalTo(@(kMainScreen_width - 2 * 70));
//    }];
//    bar.placeholder = @"请输入商品名称";
//
//    bar.backgroundImage = [UIImage new];
    
    
//    [bar setPositionAdjustment:UIOffsetMake(CGRectGetWidth(bar.frame) - 30, 0) forSearchBarIcon:UISearchBarIconSearch];
//
//
//    self.searchBar = bar;
    
    CGRect frame = CGRectMake(0, 0, kMainScreen_width - 70 * 2, 26);
    UIView *v = [[UIView alloc]initWithFrame:frame];
    [self addSubview:v];
    @weakify(self);
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerY.equalTo(self.mas_centerY).offset(10);
        make.width.equalTo(@(frame.size.width));
        make.height.equalTo(@(frame.size.height));
        make.centerX.equalTo(self.mas_centerX);
    }];
    v.backgroundColor= [UIColor whiteColor];
    v.layer.cornerRadius = frame.size.height / 2.0;
    
    self.searchView = v;

    UITextField *t = [[UITextField alloc]init];
    [v addSubview:t];
    [t mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(v).width.insets(UIEdgeInsetsMake(0, 10, 0, 25));
    }];
    
    t.placeholder = @"请输入商品名称";
    t.font = [UIFont systemFontOfSize:11.0];

    t.layer.cornerRadius = 13;
    t.textColor = [UIColor blackColor];

    t.textAlignment = NSTextAlignmentCenter;
    
    
    self.textField = t;
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [v addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(@(-8));
//        make.width.equalTo(@15);
//        make.height.equalTo(@15);
//        make.centerY.equalTo(v.mas_centerY);
        
        make.edges.equalTo(v).width.insets(UIEdgeInsetsMake(0, 10, 0, 10));
        
    }];

    btn.contentMode = UIViewContentModeScaleAspectFit;
    
    [btn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    NSLog(@"t  frame -- %@ -- %@" , NSStringFromCGRect(t.frame) , NSStringFromCGRect(v.frame));
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, frame.size.width - 10 - 25, 0, 0);//
    
    self.searchBtn = btn;

    
    self.searchSignal = [self.searchBtn rac_signalForControlEvents:UIControlEventTouchUpInside] ;

    switch (_style) {
        case SearchNavStyleNone:
            {
                [self.searchBtn setImage:[UIImage new] forState:UIControlStateNormal];
                [t mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(v).width.insets(UIEdgeInsetsMake(0, 0, 0, -30));
                }];
            }
            break;
        case SearchNavStyleLeft: {
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, -(frame.size.width - 10 - 25 -10), 0, 0);//
            
            self.textField.textAlignment = NSTextAlignmentLeft;
            t.placeholder = [NSString stringWithFormat:@"        %@" , t.placeholder];
        }
            break;
        case SearchNavStyleCenter: {
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);//
            self.textField.textAlignment = NSTextAlignmentCenter;
        }
            break;
            
        default:
            break;
    }
    
    
    
    
}

@end
