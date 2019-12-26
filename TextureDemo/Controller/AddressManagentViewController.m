//
//  AddressManagentViewController.m
//  TextureDemo
//
//  Created by zqp on 2019/12/18.
//  Copyright © 2019 zqp. All rights reserved.
//

#import "AddressManagentViewController.h"
#import "SelectCityViewController.h"

@interface AddressManagentViewController()

@property (nonatomic , strong) NSString *address;
@property (nonatomic , strong) UILabel *tipLabel;
@property (nonatomic , strong) UIButton *selectButton;
@property (nonatomic , strong) UIImageView *noImageView;

@end

@implementation AddressManagentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择收货地址";
    
    [self setupUI];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated ];
    
    [((BaseNavViewController *)self.navigationController) hideNavBarBottomLine];
}


- (void)setupUI {
    
    self.view.backgroundColor = UIColorFromRGB(0xf5f5f5);
    
    //right item
    UIButton *right = [UIButton creatBtnWithTitle:@"管理地址"];
    [right setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:right];
    
    //titleview
    
    UIView *titleV = [UIView new];
    [self.view addSubview:titleV];
    
    [titleV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(HPX(46)));
        make.right.equalTo(@(HPX(-46)));
        make.top.equalTo(@(NavigationHeight + 5));
        make.height.equalTo(@(HPX(126)));
    }];
    titleV.backgroundColor = [UIColor whiteColor];
    titleV.layer.shadowColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:0.27].CGColor;
    titleV.layer.shadowOffset = CGSizeMake(0,2);
    titleV.layer.shadowOpacity = 1;
    titleV.layer.shadowRadius = 14;
    titleV.layer.borderWidth = 1;
    titleV.layer.borderColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1.0].CGColor;
    titleV.layer.cornerRadius = 5;
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"杭州市" forState:UIControlStateNormal];
    [button setAttributedTitle:[[NSAttributedString alloc]initWithString:@"杭州市" attributes:@{NSFontAttributeName:HPMZFont(40),NSForegroundColorAttributeName :UIColorFromRGB(0x000000)}] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"weizhi"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(selectCityAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [button layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleLeft imageTitleSpace:25];
    
    [titleV addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(HPX(15)));
        make.centerY.equalTo(titleV.mas_centerY);
        make.width.equalTo(@(HPX(250)));
        
    }];
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zhangkai"]];
    img.userInteractionEnabled = YES;
    [button addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.left.equalTo(button.mas_right).offset(5);
        make.centerY.equalTo(titleV.mas_centerY);
        make.right.equalTo(button.mas_right).offset(0);
        make.width.equalTo(@(HPX(20)));
        make.height.equalTo(@(HPX(15)));
        
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = UIColorFromRGB(0x666666);
    [titleV addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(img.mas_right).offset(10);
        make.centerY.equalTo(titleV.mas_centerY);
        make.width.equalTo(@(0.5));
        make.height.equalTo(@(HPX(36)));
    }];
    
    
    
    UIView *v = [UIView new];
    [titleV addSubview:v];
    
    
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(line.mas_right).offset(10);
        make.right.equalTo(titleV.mas_right).offset(-10);
        make.top.equalTo(@(0));
        make.bottom.equalTo(@(0));
        
    }];
    
    
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [v addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.edges.equalTo(v).width.insets(UIEdgeInsetsMake(0, 10, 0, 10));
        
    }];
    
    btn.contentMode = UIViewContentModeScaleAspectFit;
    
    UIImageView *imgS = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sousuo"]];
    imgS.userInteractionEnabled = YES;
    [btn addSubview:imgS];
    [imgS mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.left.equalTo(button.mas_right).offset(5);
        make.centerY.equalTo(titleV.mas_centerY);
        make.left.equalTo(btn.mas_left).offset(0);
        make.width.equalTo(@(HPX(43)));
        make.height.equalTo(@(HPX(43)));
        
    }];
    
    UITextField *t = [[UITextField alloc]init];
    [v addSubview:t];
    [t mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(v).width.insets(UIEdgeInsetsMake(0, 30, 0, 25));
    }];
    
    t.placeholder = @"请输入收货地址";
    t.font = [UIFont systemFontOfSize:11.0];
    
    t.layer.cornerRadius = 13;
    t.textColor = [UIColor blackColor];
    
    t.textAlignment = NSTextAlignmentLeft;
    
    UIView *jinggaoV = [UIView new];
    [self.view addSubview:jinggaoV];
    
    jinggaoV.backgroundColor = UIColorFromRGB(0xFFF6D2);
    [jinggaoV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.top.equalTo(titleV.mas_bottom).offset(10);
        make.height.equalTo(@(HPX(115)));
        
    }];
    
    UILabel *l = [UILabel new];
    l.text = @"因各地区商品和配送服务不同，请选择准确的收货地址";
    l.font = HPMZFont(37);
    l.textColor = UIColorFromRGB(0xFF680A);
    [jinggaoV addSubview:l];
    
    [l mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(jinggaoV).width.insets(UIEdgeInsetsMake(0, 10, 0, HPX(50)));
    }];
    
    self.tipLabel = l;
    
    UIButton *close = [UIButton buttonWithType:UIButtonTypeCustom];
    [close setImage:[UIImage imageNamed:@"back1"] forState:UIControlStateNormal];
    [jinggaoV addSubview:close];
    [close mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(jinggaoV).offset(-HPX(36));
        make.width.equalTo(@(HPX(40)));
        make.centerY.equalTo(jinggaoV.mas_centerY);
        
    }];
    
    
    UIImageView *noImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"address"]];
    [self.view addSubview:noImageView];
    [noImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
    }];
    
    
    
    UILabel *noLabel = [UILabel new];
    noLabel.text = @"您还没有收货地址哦~";
    noLabel.font = HPMZFont(40);
    noLabel.textColor = UIColorFromRGB(0x999999);
    [noImageView addSubview:noLabel];
    
    [noLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(noImageView.mas_bottom).offset(HPX(84));
        make.centerX.equalTo(noImageView.mas_centerX);
    }];
    
    
    
    UIButton *selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:selectButton];
    [selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(noLabel.mas_bottom).offset(HPX(90));
        make.centerX.equalTo(noImageView.mas_centerX);
    }];
    [selectButton setBackgroundImage:[UIImage gradientImageWithColors:@[UIColorFromRGB(0xFF8A00),UIColorFromRGB(0xFF680A)] rect:CGRectMake(0, 0, HPX(518), HPX(116)) cornerRadius:HPX(14) corners:UIRectCornerAllCorners] forState:UIControlStateNormal];
    
    [selectButton setTitle:@"+ 新建收货地址" forState:UIControlStateNormal];
    
    [selectButton setAttributedTitle:[[NSAttributedString alloc]initWithString:@"+ 新建收货地址" attributes:@{NSFontAttributeName:HPMZFont(46),NSForegroundColorAttributeName :UIColorFromRGB(0xffffff)}] forState:UIControlStateNormal];
    
    [selectButton addTarget:self action:@selector(selectAddrssAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.noImageView = noImageView;
    self.selectButton = selectButton;
}

-(void)selectAddrssAction:(id)sender {
    
    SelectCityViewController *vc = [SelectCityViewController new];
    vc.selectAddress = ^(NSString * _Nonnull address) {
        NSLog(@"addresss ---- %@" , address);
        self.address = address;
        [self addAddressView];
    };
    [self.navigationController pushViewController:vc animated:  YES];
}

-(void)selectCityAction:(id)sender {
    
    NSLog(@"选择城市");
}

-(void)addAddressView {
    
    self.selectButton.hidden = self.noImageView.hidden = YES;
    for (UIView *subV in self.noImageView.subviews) {
        subV.hidden = YES;
    }
    
    UIView *v = [UIView new];
    [self.view addSubview:v];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.top.equalTo(self.tipLabel.mas_bottom).offset(10);
        make.height.equalTo(@(HPX(199)));
    }];
    v.backgroundColor = UIColorFromRGB(0xffffff);
    UILabel *addressLabel = [UILabel new];
    [v addSubview:addressLabel];
    addressLabel.text = self.address;
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(v.mas_centerX);
        make.centerY.equalTo(v.mas_centerY);
        
    }];
    addressLabel.textColor = UIColorFromRGB(0x999999);
    addressLabel.font = HPMZFont(37);
    
    
}

@end
