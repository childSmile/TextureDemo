//
//  BaseNavViewController.m
//  TextureDemo
//
//  Created by zqp on 2019/4/10.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import "BaseNavViewController.h"

@interface BaseNavViewController ()

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
    
    //不是栈底控制器 隐藏
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
   
}






@end
