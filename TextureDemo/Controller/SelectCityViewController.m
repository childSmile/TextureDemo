//
//  SelectCityViewController.m
//  TextureDemo
//
//  Created by zqp on 2019/12/18.
//  Copyright © 2019 zqp. All rights reserved.
//

#import "SelectCityViewController.h"
#import "Province.h"


@interface SelectCityViewController ()


@property (nonatomic , strong) NSArray *dataArray;

@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic , strong) UIButton *currentButton;


@property (nonatomic , strong) NSString *address;



@end

@implementation SelectCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择城市" ;
    self.view.backgroundColor = UIColorFromRGB(0xffffff);
    
    
    
    [self setupUI];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];

}


-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

}

-(void)setupUI {
    
    NSArray *array = @[@"浙江省",@"北京市",@"天津市"] ;
    NSMutableArray *ps = [NSMutableArray array];
    for (NSString *str in array) {
        Province *p = [Province new];
        p.provinceName = str;
        NSMutableArray *cs = [NSMutableArray array];
        for (int i = 0; i < arc4random() % (7-2) + 2; i ++) {
            City *c = [City new];
            c.cityName = [NSString stringWithFormat:@"%@-city-%d" , str,i];
            NSMutableArray *as = [NSMutableArray array];
            for (int j = 0; j < arc4random() % (8 - 1) + 1; j++) {
                [as addObject:[NSString stringWithFormat:@"%@-area-%d",str,j]];
            }
            c.areaNames = [as copy];
            [cs addObject:c];
        }
        
        p.cityNames = [cs copy];
        [ps addObject:p];
        
    }
    
    self.dataArray = [ps copy];
//    self.heightArr = [NSMutableArray arrayWithCapacity:ps.count];
    
    [self addViews];
    
//    UILabel *titleL = [UILabel new];
//    titleL.text = @"已开放城市列表";
//    titleL.textColor = UIColorFromRGB(0x999999);
//    titleL.font = HPBoldMZFont(40);
//
//    [self.view addSubview:titleL];
//    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@(HPX(80)));
//        make.top.equalTo(@((NavigationHeight + 15)));
//        make.right.equalTo(@(-HPX(80)));
//    }];
    
//    UITableView *tab = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
//    [self.view addSubview:tab];
//    [tab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@(0));
//        make.right.equalTo(@(0));
//        make.bottom.equalTo(@(0));
//        make.top.equalTo(titleL.mas_bottom).offset(HPX(30));
//    }];
//    tab.delegate = self;
//    tab.dataSource = self;
//    tab.tableFooterView = [UIView new];
//    [tab registerClass:[ProvinceTableViewCell class] forCellReuseIdentifier:@"cell"];
//
    
    
    
}




-(void)addViews {
    
    
    
    
    UILabel *titleL = [UILabel new];
       titleL.text = @"已开放城市列表";
       titleL.textColor = UIColorFromRGB(0x999999);
       titleL.font = HPBoldMZFont(40);
       
       [self.view addSubview:titleL];
       [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo(@(HPX(80)));
           make.top.equalTo(@((NavigationHeight + 15)));
           make.right.equalTo(@(-HPX(80)));
       }];
    
  
    
    NSMutableArray *pvs = [NSMutableArray array];
        NSMutableArray *ypvs = [NSMutableArray array];
        [ypvs addObject:@(0)];
        for (int i = 0; i < self.dataArray.count; i++) {
            Province *p = self.dataArray[i];
            
            UIView *pView = [UIView new];
            pView.tag = 200 + i;
            
            UILabel *pL = [UILabel new];
            pL.text = [NSString stringWithFormat:@"- %@ -" , p.provinceName];
            pL.textColor = UIColorFromRGB(0x333333);
            pL.font = HPBoldMZFont(43);
            
            [pView addSubview:pL];
            [pL mas_makeConstraints:^(MASConstraintMaker *make) {

                make.left.equalTo(@(HPX(0)));
                make.top.equalTo(@(10));
                make.right.equalTo(@(HPX(80)));
                make.height.equalTo(@(HPX(44)));
            }];
            
            NSMutableArray *btns = [NSMutableArray array];
            
            for (int j = 0;  j < p.cityNames.count; j ++) {
                City *c = p.cityNames[j];
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                [btn setTitle:c.cityName forState:UIControlStateNormal];
                [btns addObject:btn];
                
                CGFloat y = HPX(44) + 10 ;
                CGFloat h = HPX(86);
                CGFloat space = HPX(30);
                 CGFloat width = [BaseServiceTool textWidthWithText:c.cityName font:HPMZFont(40)] + 20;
                 if (j != 0) {
                     UIButton *upBtn = btns[j - 1];
                     //前一个按钮+间距+这个按钮宽度+间距 > 屏宽
                     if (CGRectGetMaxX(upBtn.frame) + space + width + space > kMainScreen_width ) {
                         btn.frame = CGRectMake(HPX(0),  y + space * (j + 1), width, h);

                     } else {
                         btn.frame = CGRectMake(CGRectGetMaxX(upBtn.frame) + space , CGRectGetMinY(upBtn.frame), width , h);
                     }
                     
                 } else {
                     btn.frame = CGRectMake(HPX(0) , y + space, width, h);
                 }
                 [pView addSubview:btn];

                 [btn setTitle:c.cityName forState:UIControlStateNormal];
                 [btn setTitle:c.cityName forState:UIControlStateSelected];
                 [btn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
                 [btn setTitleColor:UIColorFromRGB(0xFF7F2F) forState:UIControlStateSelected];
                btn.layer.cornerRadius = HPX(43);
                btn.backgroundColor = UIColorFromRGB(0xf5f5f5);
                
                 btn.titleLabel.font = HPMZFont(40);
                 btn.tag = j + 100;
//                [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton * x) {
//                    NSLog(@"btn -- %ld" , x.tag);
//                }];
                
                 
                 [btn addTarget:self action:@selector(cityBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//                 if (i== 0 && j == 0) {
//                     btn.selected = YES;
//                 }
                
               
            }
            
            
            [self.view addSubview:pView];
            
            
            UIButton *lastBtn = btns[p.cityNames.count - 1];
            CGFloat h = CGRectGetMaxY(lastBtn.frame);
            
            CGFloat y = 0;
            if(i != 0) {
                
                y = [[ypvs valueForKeyPath:@"@sum.floatValue"] floatValue];
            } else {
                y = 0;
            }
            [ypvs addObject:@(h)];
            
            [pView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(titleL.mas_left);
                make.right.equalTo(titleL.mas_right);
                make.top.equalTo(titleL.mas_bottom).offset(20 + y );
                make.height.equalTo(@(h + HPX(30)));
            }];
           
            
            [pvs addObject:pView];
        }
    
    @weakify(self);
    [self.view addGestureTapEventHandle:^(id sender, UITapGestureRecognizer *gestureRecognizer) {
        @strongify(self);
        for (UIView * v in self.view.subviews) {
            if ([v isKindOfClass:[ButtonView class]] && v.tag > 300) {
                [v removeFromSuperview];
            }
        }
        
        self.currentButton.selected = NO;
    }];
    
}

-(void)cityBtnAction:(UIButton *)sender {
    
    
    if (self.currentButton) {
        self.currentButton.selected = NO;
        
        for (UIView *v in sender.superview.subviews) {
            if ([v isKindOfClass:[UIButton class]] && v.tag >= 100) {
                ((UIButton *)v).selected = NO;
            }
        }
        
    }
    
    
    sender.selected = YES;
    self.currentButton = sender;
    
    
    for (UIView * v in self.view.subviews) {
        if ([v isKindOfClass:[ButtonView class]] && v.tag > 300) {
            [v removeFromSuperview];
        }
    }
    
    Province *p = self.dataArray[sender.superview.tag - 200];
    City *c = p.cityNames[sender.tag - 100];
    
    self.address = [NSString stringWithFormat:@"%@%@" , p.provinceName,c.cityName];
    
    ButtonView *aView = (ButtonView *)[ButtonView creatVieWithArray:c.areaNames];
    CGFloat h = [aView.cellHeight floatValue];
    aView.tag = 300 + sender.tag;

    
    [self.view addSubview:aView];
    [aView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.top.equalTo(sender.mas_bottom).offset(5);
        make.height.equalTo(@(h));
    }];
    
    @weakify(self);
    [[[RACSignal merge:aView.buttonSingalsArray] flattenMap:^RACStream *(UIButton *button) {

           return [RACSignal return:@(button.tag)];
           
       }] subscribeNext:^(NSNumber *index) {
           @strongify(self);
           
           self.address = [NSString stringWithFormat:@"%@%@" , self.address , c.areaNames[index.integerValue]];
           if (self->_selectAddress) {
               self->_selectAddress(self.address);
           }
           [self.navigationController popViewControllerAnimated:YES];
    
       }];
    
    
    
}







/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end


@implementation ButtonView




+ (ButtonView *)creatVieWithArray:(NSArray *)array{
    
     ButtonView *pView = [ButtonView new];
        pView.backgroundColor = UIColorFromRGB(0xf5f5f5);
        pView.layer.cornerRadius = 5;
        
        
        NSMutableArray *btns = [NSMutableArray array];
    NSMutableArray *btnSingals = [NSMutableArray array];
        
        for (int j = 0;  j < array.count; j ++) {
            NSString *area = array[j];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:area forState:UIControlStateNormal];
            [btns addObject:btn];
            
            CGFloat y = 0 ;
            CGFloat h = HPX(86);
            CGFloat space = HPX(30);
            CGFloat width = [BaseServiceTool textWidthWithText:area font:HPMZFont(40)] + 20;
            if (j != 0) {
                UIButton *upBtn = btns[j - 1];
                //前一个按钮+间距+这个按钮宽度+间距 > 屏宽
                if (CGRectGetMaxX(upBtn.frame) + space + width + space > kMainScreen_width - 30 ) {
                    btn.frame = CGRectMake(space, CGRectGetMaxY(upBtn.frame)  + space, width, h);
                    
                } else {
                    btn.frame = CGRectMake(CGRectGetMaxX(upBtn.frame) + space , CGRectGetMinY(upBtn.frame), width , h);
                }
                
            } else {
                btn.frame = CGRectMake(space , y + space, width, h);
            }
            [pView addSubview:btn];
            
            [btn setTitle:area forState:UIControlStateNormal];
            [btn setTitle:area forState:UIControlStateSelected];
            [btn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
            [btn setTitleColor:UIColorFromRGB(0xFF7F2F) forState:UIControlStateSelected];
            btn.layer.cornerRadius = HPX(43);
            btn.backgroundColor = UIColorFromRGB(0xffffff);
            
            btn.titleLabel.font = HPMZFont(40);
            btn.tag = j;
            [btnSingals addObject:[btn rac_signalForControlEvents:UIControlEventTouchUpInside]];
                  
            
//            if ( j == 0) {
//                btn.selected = YES;
//            }
//
            
        }
    
    pView.buttonSingalsArray = [btnSingals copy];
    
        
        UIButton *lastBtn = btns[array.count - 1];
        CGFloat h = CGRectGetMaxY(lastBtn.frame);
        
        pView.cellHeight = @(h + 10);
    
        
        
        return pView;
    
}

@end


