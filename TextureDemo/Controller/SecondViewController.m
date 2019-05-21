//
//  SecondViewController.m
//  TextureDemo
//
//  Created by zqp on 2019/4/10.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import "SecondViewController.h"
#import "ShowAnimationView.h"
#import "DataSourceModel.h"
#import "ASTableCell.h"
#import "DetialViewController.h"
#import "RACViewController.h"
#import "SeckillViewController.h"
#import "TabViewController.h"

@interface SecondViewController ()<ASTableDelegate>

@property (nonatomic , assign) BOOL isOpen;
@property (nonatomic , strong) ShowAnimationView *shadow;
@property(nonatomic , strong) NSArray *arr;
@property (nonatomic , strong) UIButton *titleButton;

@property (nonatomic , strong) ASTableNode *tab;
@property (nonatomic , strong) DataSourceModel *model;


@end

@implementation SecondViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    
}
#pragma mark - 懒加载
- (ShowAnimationView *)shadow {
    if (!_shadow) {
        _shadow = [[ShowAnimationView alloc]initWithFrame:CGRectMake(0, NavigationHeight, kMainScreen_width, kMainScreen_height - NavigationHeight) data:self.arr];
        
        [[_shadow rac_valuesAndChangesForKeyPath:@"isShow" options:NSKeyValueObservingOptionNew observer:self] subscribeNext:^(RACTuple * x) {
            NSLog(@"isshow change  -- %@" , x);
            if ([x.first boolValue]) {
                [UIView animateWithDuration:1 animations:^{
                    self.titleButton.imageView.transform = CGAffineTransformMakeRotation(M_PI);
                }];
                self.isOpen = YES;
                
            } else {
                [UIView animateWithDuration:1 animations:^{
                    self.titleButton.imageView.transform = CGAffineTransformIdentity;
                }];
                self.isOpen = NO;
                
            }
        }];
    }
    return _shadow;
}

- (ASTableNode *)tab {
    if (!_tab) {
        _tab = [[ASTableNode alloc]initWithStyle:UITableViewStylePlain];
        _tab.frame = CGRectMake(0, NavigationHeight, kMainScreen_width, kMainScreen_height - NavigationHeight - TabbarHeight);
    }
    return _tab;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.arr = @[@"滨江" , @"萧山" , @"上城", @"下城"];
    
    [self setNav];
    
    [self setUI];
    
    
}

- (void)setUI {
    
    [self.view addSubnode:self.tab];
    self.model = [[DataSourceModel alloc]initWithCellID:NSStringFromClass([ASTableCell class]) configureCellBlock:^(ASTableCell * cell, id  _Nonnull item, NSIndexPath * _Nonnull indexPath) {
        [cell configCellWithItem:self.model.dataSource[indexPath.row]];
    }];
    self.model.dataSource = @[@"abstract猫咪猫咪猫咪猫咪猫咪么么么么么么么木木木木木么么么么么么么", @"animals", @"business", @"cats", @"city", @"food", @"nightlife", @"fashion", @"people啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦", @"nature", @"sports", @"technics", @"transport"];
    self.tab.dataSource = self.model;
    self.tab.delegate = self;
}

- (void)tableNode:(ASTableNode *)tableNode didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableNode deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"------select row  %ld" , indexPath.row);
//    SeckillViewController *vc = [[SeckillViewController alloc]init];
//    self.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    
    
    TabViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([TabViewController class])];
    //    [self presentViewController:[[UINavigationController alloc]initWithRootViewController:vc] animated:YES completion:nil];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)setNav {
    
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_width, NavigationHeight)];
    
    [self.view insertSubview:v aboveSubview:self.view];
    
    v.backgroundColor = [UIColor whiteColor];
    
    UIView *line = [[UIView alloc]init];
    [v addSubview:line];
    line.backgroundColor = [UIColor lightGrayColor];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(v.mas_left);
        make.right.equalTo(v.mas_right);
        make.bottom.equalTo(v.mas_bottom).offset(-0.5);
        make.height.equalTo(@(0.5));
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [btn setTitle:self.arr[0] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [v addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(v.mas_centerX);
        make.centerY.equalTo(v.mas_centerY).offset(10);
        make.width.equalTo(@(80));
    }];
    
    [btn setImage:[UIImage imageNamed:@"图层 1"] forState:UIControlStateNormal];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -btn.imageView.frame.size.width, 0, btn.imageView.frame.size.width)];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(3, ( btn.titleLabel.frame.size.width + 5 ), 0, - ( btn.titleLabel.frame.size.width + 5 ))];
    
    [btn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.titleButton = btn;
    
}


- (void)selectAction:(UIButton *)sender {

    
    if (!self.isOpen) {
 
        [self.shadow showView];
        
        @weakify(self);
        self.shadow.selectBlock = ^(NSIndexPath * _Nonnull indexPath) {
            @strongify(self);

            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.titleButton setTitle:self.arr[indexPath.row] forState:UIControlStateNormal];
            });

        };
        
    } else {

        [self.shadow dismissHintView];
    }
    
    
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
