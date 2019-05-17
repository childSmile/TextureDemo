//
//  FirstViewController.m
//  TextureDemo
//
//  Created by zqp on 2019/3/18.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import "FirstViewController.h"
#import "DetialViewController.h"
#import "ASTableCell.h"


@interface FirstViewController ()<ASTableDelegate , ASTableDataSource>

@property (nonatomic , strong) ASTableNode *tableNode;
@property (nonatomic , copy) NSArray *imageCatrgories;

@end

@implementation FirstViewController

- (instancetype)init {
    
    self = [super initWithNode:[[ASTableNode alloc]initWithStyle:UITableViewStylePlain]];
    if (self) {
        
        _imageCatrgories =  @[@"abstract猫咪猫咪猫咪猫咪猫咪么么么么么么么木木木木木么么么么么么么", @"animals", @"business", @"cats", @"city", @"food", @"nightlife", @"fashion", @"people啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦", @"nature", @"sports", @"technics", @"transport"];
    }
    return self;
}

- (void)dealloc
{
    self.node.delegate = nil;
    self.node.dataSource = nil;
}


//- (void)setUI {
//    ViewController *vc = [ViewController new];
//    FirstViewController *vc2 = [FirstViewController new];
//    
//    
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
//    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:vc2];
//    
//    
//    self.viewControllers = @[nav , nav2];
//    
//    UITabBarItem *item = [[UITabBarItem alloc]initWithTitle:@"首页" image:[[UIImage imageNamed:@"tab_home"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab_hligh_home"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    UITabBarItem *item2 = [[UITabBarItem alloc]initWithTitle:@"分类" image:[[UIImage imageNamed:@"tab_all_the_goods"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab_high_all_the_goods"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    self.tabBar.items = @[item , item2];
//    
//    nav.tabBarItem = item;
//    nav2.tabBarItem = item2;
//    
//    
//    
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ASDisplayNodeDefaultPlaceholderColor();
    
    self.node.delegate = self;
    self.node.dataSource = self;
    
    self.title = @"images";
    
    __weak __typeof(self) weakSelf = self;
    self.node.view.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       NSLog(@"header refresh") ;
        [weakSelf.node.view.mj_header endRefreshing];
        
        
    }];
 
    self.node.view.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.imageCatrgories = [self.imageCatrgories arrayByAddingObjectsFromArray:self.imageCatrgories];
//        [weakSelf.node reloadData];
//        [weakSelf.node.view.mj_footer endRefreshing];
        weakSelf.node.view.mj_footer.state = MJRefreshStateNoMoreData;
        
    }];
    
    
    
    // Do any additional setup after loading the view.
}





- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.node deselectRowAtIndexPath:self.node.indexPathForSelectedRow animated:YES];
}

#pragma mark - ASTableDataSource / ASTableDelegate
- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section {
    return  self.imageCatrgories.count;
}

- (ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *image = self.imageCatrgories[indexPath.row];
    
    
    
    return ^{
        
        ASTableCell * cell = [[ASTableCell alloc]initWithText:image];
        cell.buyAction = ^(NSString * _Nonnull str) {
            NSLog(@"str -- %@" , str);
        };
        
        return cell;
        
    };
}


- (NSInteger)numberOfSectionsInTableNode:(ASTableNode *)tableNode {
    return 1;
}


- (ASSizeRange)tableNode:(ASTableNode *)tableNode constrainedSizeForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ASSizeRangeMake(CGSizeMake(kMainScreen_width, 0) , CGSizeMake(kMainScreen_width,  200));
}


- (void)tableNode:(ASTableNode *)tableNode didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    DetialViewController *vc = [[DetialViewController alloc]init];
    vc.imageCategory = self.imageCatrgories[indexPath.row];

    vc.title = [self.imageCatrgories[indexPath.row] capitalizedString];
    [self.navigationController pushViewController:vc animated:YES];
    
    
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
