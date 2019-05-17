//
//  DetialViewController.m
//  TextureDemo
//
//  Created by zqp on 2019/3/20.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import "DetialViewController.h"
#import "DetialCellNode.h"



static const NSInteger kImageHeight = 100;
static const NSInteger kItemSpace = 0;

@interface DetialViewController ()<ASCollectionDelegate , ASCollectionDataSource>

@property (nonatomic , strong) NSArray *dataArray;



@end

@implementation DetialViewController

    

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.node.backgroundColor = [UIColor whiteColor];
    self.node.delegate = self;
    
    self.node.dataSource = self;
    
    
}

- (void)dealloc {
    self.node.delegate = nil;
    self.node.dataSource = nil;
}

- (instancetype)init {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    self = [super initWithNode:[[ASCollectionNode alloc]initWithCollectionViewLayout:layout]];
    if (self) {
        layout.minimumLineSpacing = kItemSpace;//每行间距
        layout.minimumInteritemSpacing = kItemSpace;
        

        _dataArray = @[@"abstract在骄傲你", @"animals等我还有", @"business", @"cats", @"city", @"food放不进看到回复", @"nightlife", @"fashion", @"people", @"nature", @"sports", @"technics", @"transport"];
        
    }
    return self;
}
#pragma mark - ASCollectionDelegate  ASCollectionDataSource


- (NSInteger)collectionNode:(ASCollectionNode *)collectionNode numberOfItemsInSection:(NSInteger)section {

    return  _dataArray.count;
}

- (ASCellNodeBlock)collectionNode:(ASCollectionNode *)collectionNode nodeBlockForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *str = self.dataArray[indexPath.row];
    NSLog(@"str --- %@" , str);
    return ^ {
        DetialCellNode *cellNode = [[DetialCellNode alloc]initWithStr:self.dataArray[indexPath.row]];
//        cellNode.imageCategory = self.dataArray[indexPath.row];
//        cellNode.row = indexPath.row;

        [cellNode.carBtn addTarget:self action:@selector(buttonAction:) forControlEvents:ASControlNodeEventTouchUpInside];
        return cellNode;
    };

}

- (ASSizeRange)collectionNode:(ASCollectionNode *)collectionNode constrainedSizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return ASSizeRangeMake(CGSizeMake((kMainScreen_width - kItemSpace * 2) / 3.0 , kImageHeight + 50 ) , CGSizeMake((kMainScreen_width - kItemSpace * 2) / 3.0, 200));
}


- (void)buttonAction:(id)sender {
    
    NSLog(@"buy buy");
}





//- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
//    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
//    [self.node.collectionNode.view.collectionViewLayout invalidateLayout];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
