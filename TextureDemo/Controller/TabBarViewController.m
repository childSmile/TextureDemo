//
//  TabBarViewController.m
//  TextureDemo
//
//  Created by zqp on 2019/3/28.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import "TabBarViewController.h"
#import "FirstViewController.h"
#import "ViewController.h"
#import "RACViewController.h"
#import "CategoryViewController.h"
#import "SecondViewController.h"
#import "BaseNavViewController.h"
#import "BaseViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    // Do any additional setup after loading the view.
}

- (void)setUI {
    ViewController *vc = [ViewController new];
    FirstViewController *vc2 = [FirstViewController new];
    RACViewController *vc3 = [RACViewController new];
    CategoryViewController *vc4 = [CategoryViewController new];
    SecondViewController *vc5 = [SecondViewController new];
    BaseViewController *vc6 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([BaseViewController class])];
    
    
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:vc2];
    UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:vc3];
    UINavigationController *nav4 = [[UINavigationController alloc]initWithRootViewController:vc4];
    UINavigationController *nav5 = [[UINavigationController alloc]initWithRootViewController:vc5];
    
    BaseNavViewController *nav6 = [[BaseNavViewController alloc]initWithRootViewController:vc6];
    
    
    
    self.viewControllers = @[nav  , nav4 , nav5 , nav6];
    
    UITabBarItem *item = [[UITabBarItem alloc]initWithTitle:@"首页" image:[[UIImage imageNamed:@"tab_home"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab_hligh_home"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    UITabBarItem *item2 = [[UITabBarItem alloc]initWithTitle:@"分类" image:[[UIImage imageNamed:@"tab_all_the_goods"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab_high_all_the_goods"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    UITabBarItem *item3 = [[UITabBarItem alloc]initWithTitle:@"RAC测试" image:[[UIImage imageNamed:@"tab_all_the_goods"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab_high_all_the_goods"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
    UITabBarItem *item4 = [[UITabBarItem alloc]initWithTitle:@"分类" image:[[UIImage imageNamed:@"tab_all_the_goods"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab_high_all_the_goods"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    UITabBarItem *item5 = [[UITabBarItem alloc]initWithTitle:@"课程预定" image:[[UIImage imageNamed:@"tab_all_the_goods"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab_high_all_the_goods"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    UITabBarItem *item6 = [[UITabBarItem alloc]initWithTitle:@"nav" image:[[UIImage imageNamed:@"tab_all_the_goods"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab_high_all_the_goods"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
    nav.tabBarItem = item;
    nav2.tabBarItem = item2;
    nav3.tabBarItem = item3;
    nav4.tabBarItem = item4;
    nav5.tabBarItem = item5;
    nav6.tabBarItem = item6;
    
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor] , NSFontAttributeName : [UIFont systemFontOfSize:12.0]} forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor orangeColor] , NSFontAttributeName : [UIFont systemFontOfSize:12.0]} forState:UIControlStateSelected];
    

    [self.tabBarController setHidesBottomBarWhenPushed:YES];
    
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
