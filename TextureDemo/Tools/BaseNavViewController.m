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
    
//    [self setUI];
    
    
    // Do any additional setup after loading the view.
}




- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    
    //这个地方有个问题，initWithRootViewController会触发pushViewController
    if (self.viewControllers.count == 0) {
        [super pushViewController:viewController animated:animated];
        return;
    }
    
    
    //1.添加后退按钮
    [self addBackButton:viewController];
    
    // 隐藏tabbar
    viewController.hidesBottomBarWhenPushed =YES;

    // 修正push控制器tabbar上移问题
    if (@available(iOS 11.0, *)){
        
        // 修改tabBra的frame
        
        CGRect frame = self.tabBarController.tabBar.frame;
        
        frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
        
        self.tabBarController.tabBar.frame = frame;
        
    }
    
    [super pushViewController:viewController animated:animated];
    

   
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    
    
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





//寻找底部横线
- (UIImageView *)foundNavigationBarBottomLine:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self foundNavigationBarBottomLine:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}



//显示底部横线
- (void)showNavBarBottomLine {
    UIImageView *bottomLine = [self foundNavigationBarBottomLine:self.navigationBar];
    if (bottomLine) {
        bottomLine.hidden = YES;
    }
    
    UIImageView *navLine = [self.navigationBar.subviews[0] viewWithTag:5757];
    if (navLine) {
        navLine.hidden = NO;
        CGRect bottomLineFrame = bottomLine.frame;
        bottomLineFrame.origin.y = CGRectGetMaxY(self.navigationBar.frame);
        navLine.frame = bottomLineFrame;
    }else {
        CGRect bottomLineFrame = bottomLine.frame;
        bottomLineFrame.origin.y = CGRectGetMaxY(self.navigationBar.frame);
        UIImageView *navLine = [[UIImageView alloc] initWithFrame:bottomLineFrame];
        navLine.tag = 5757;
        navLine.backgroundColor = UIColorFromRGB(0xd6d6d6);
        if (self.navigationBar.subviews.count) {
            [self.navigationBar.subviews[0] addSubview:navLine];
        }else{
            bottomLine.hidden = NO;
        }
    }
}

//隐藏底部横线
- (void)hideNavBarBottomLine {
    UIImageView *bottomLine = [self foundNavigationBarBottomLine:self.navigationBar];
    if (bottomLine) {
        bottomLine.hidden = YES;
    }
    UIImageView *navLine = [self.navigationBar.subviews[0] viewWithTag:5757];
    if (navLine) {
        navLine.hidden = YES;
    }
}


@end
