//
//  WaterFallViewController.m
//  TextureDemo
//
//  Created by zqp on 2019/12/26.
//  Copyright © 2019 zqp. All rights reserved.
//

#import "WaterFallViewController.h"
#import "WaterFallLayout.h"
#import "GoodsModel.h"
#import "WaterFallCollectionViewCell.h"


static CGFloat ImageViewHeight = 438;


@interface WaterFallViewController ()<WaterFallLayoutDelegate , UICollectionViewDataSource>

@property (nonatomic , strong) NSMutableArray *goods;
@property (nonatomic , weak) UICollectionView *collectionView;
@property (nonatomic , assign) NSInteger columnCount;

@end

@implementation WaterFallViewController


#pragma mark - 懒加载
- (NSMutableArray *)goods {
    if (!_goods) {
        _goods = [NSMutableArray array];
    }
    return _goods;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initialize];
    [self setupCollectionView];
    [self loadData];
    
    
    // Do any additional setup after loading the view.
}

//初始化
-(void)initialize {
    self.title = @"瀑布流";
    
    
}

-(void)setupCollectionView {
    WaterFallLayout *layout = [[WaterFallLayout alloc]init];
    layout.delegate = self;
    
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
//    layout.estimatedItemSize = CGSizeMake((kMainScreen_width - 3 * 20) / 2, HPX(500));
    
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds
                                                         collectionViewLayout:layout];
    
    collectionView.backgroundColor = UIColorFromRGB(0xf5f5f5);
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    
    [collectionView registerClass:[WaterFallCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    self.collectionView = collectionView;
    
    
}

- (void)loadData {
    
    for (int i = 0; i < 7; i++) {
        GoodsModel *m = [GoodsModel new];
        m.title = i % 3 == 1 ? @"吧啦吧啦吧啦吧" : @"布鲁布楼布鲁布鲁布鲁布鲁布鲁布鲁布鲁布鲁布鲁布鲁布鲁布鲁布鲁布鲁布鲁";
        m.imgUrl = @"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2276391059,2676039382&fm=26&gp=0.jpg";
        m.price = [NSString stringWithFormat:@"%d" ,i + 100];
        [self.goods addObject:m];
    }
    
    [self.collectionView reloadData];
    
}


# pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.goods.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WaterFallCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSLog(@"index -- %ld" , indexPath.row);
    [cell configWithItem:self.goods[indexPath.row]];
    return cell;
}





#pragma mark - WaterFallLayoutDelegate
-(CGFloat)waterFallLayout:(WaterFallLayout *)waterFallLayout heightForItemAtIndexPath:(NSInteger)indexPath itemWidth:(CGFloat)itemWidth {
    
    
    GoodsModel *m = self.goods[indexPath];
    CGFloat itemH = HPX(ImageViewHeight) + HPX(43) * 5 + HPX(40);
    CGFloat h = [BaseServiceTool textWidthWithText:m.title font:HPMZFont(40)];
    if (h > itemWidth) {
        itemH = itemH + HPX(40);
    }
    
    return itemH;
    
    
}


- (CGFloat)rowMarginInWaterFallLayout:(WaterFallLayout *)waterFallLayout {
    return 20;
}

- (NSUInteger)columnCountInWaterFallLayout:(WaterFallLayout *)waterFallLayout {

    return 2;
}

@end
