//
//  BaseNavViewController.m
//  TextureDemo
//
//  Created by zqp on 2019/4/10.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import "BaseNavViewController.h"

@interface BaseNavViewController ()

@property (nonatomic , strong) UIView *bar;

@end

@implementation BaseNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    
    
    // Do any additional setup after loading the view.
}


- (void)setUI {
    
    self.navigationBar.hidden = YES;
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    
    //1.添加后退按钮
    [self addBackButton:viewController];
    
    
    //这个地方有个问题，initWithRootViewController会触发pushViewController
    if (self.viewControllers.count == 0) {
        [super pushViewController:viewController animated:animated];
        return;
    } else {
        
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed =YES;
    }
    

    
    // 修正push控制器tabbar上移问题
    if (@available(iOS 11.0, *)){
        
        // 修改tabBra的frame
        
        CGRect frame = self.tabBarController.tabBar.frame;
        
        frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
        
        self.tabBarController.tabBar.frame = frame;
        
    }
    
    [super pushViewController:viewController animated:animated];
    self.navigationBar.hidden = NO;

   
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    self.navigationBar.hidden = YES;
    
    // 修正push控制器tabbar上移问题
    if (@available(iOS 11.0, *)){
        
        // 修改tabBra的frame
        
        CGRect frame = self.tabBarController.tabBar.frame;
        
        frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
        
        self.tabBarController.tabBar.frame = frame;
        
    }
    
   return  [super popViewControllerAnimated:animated];
}

//2 自定义后退按钮
- (void)addBackButton:(UIViewController *)viewController {
    
    UIButton *btn = [UIButton creatBackBtn];
    [btn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
}


- (void)backClick {
    [self popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated

{
    
    [super viewWillAppear:animated];
    
    if (self.childViewControllers.count == 1) {
        
        self.navigationController.navigationBar.hidden = YES;
        
        self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    } else {
        
        self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    }
    
    
}




@end
