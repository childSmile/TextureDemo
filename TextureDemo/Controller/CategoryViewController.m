//
//  CategoryViewController.m
//  TextureDemo
//
//  Created by zqp on 2019/4/4.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import "CategoryViewController.h"
#import "ASTableCell.h"
#import "SearchNavView.h"
#import "DataSourceModel.h"
#import "WaterfallView.h"
#import "PhotoModel.h"
#import "CategoryButtonView.h"
#import "CategoryFillerView.h"


static float kBtnWidth = 70;

@interface CategoryViewController ()<ASTableDelegate , ASTableDataSource , UITableViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic , strong) NSArray *titleArr;
@property (nonatomic , strong) NSArray *leftArr;
@property (nonatomic , strong) NSArray *rightArr;

@property (nonatomic , strong) NSArray *dataArr;


@property (nonatomic , strong) ASTableNode *leftTab;
@property (nonatomic , strong) ASTableNode *rightTab;

//@property (nonatomic , strong) LeftViewModel <ASTableDelegate  , ASTableDataSource>*leftModel;

@property (nonatomic , strong) UIScrollView *titleView;
@property (nonatomic , strong) UIButton *currentBtn;
@property (nonatomic , assign) NSInteger currentRow;//当前的left row

@property (nonatomic , strong)DataSourceModel *leftModel;
@property (nonatomic , strong)DataSourceModel *rightModel;

@property (nonatomic , strong) WaterfallView *pullView;

@property (nonatomic , strong) UIButton *pullButton;
@property (nonatomic , strong) NSArray *titleButtons;
@property (nonatomic , strong) UIView *plurView;


@property (nonatomic , strong) NSArray *arr;//综合排序的数据源
@property (nonatomic , strong) CategoryButtonView *titleV;

@property (nonatomic , strong) UITableView *smallTab;
@property (nonatomic , strong) DataSourceModel *smallModel;
@property (nonatomic , assign) NSInteger selectRow;

@property (nonatomic , strong) CategoryFillerView *fillterView;


@end

@implementation CategoryViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *titleArr = @[@"冻品",@"早餐粥铺" , @"便当" , @"饮品" , @"汤面饭" , @"烧烤" , @"麻辣烫系列" ,@"炸鸡汉堡" , @"品牌" , @"其他" ,@"肯德基",@"过桥米线" , @"西餐牛排" , @"日式料理"];
    
    self.titleArr = titleArr;
    
    self.arr = @[@"综合排序" , @"价格", @"销量排序"];
    
    
    NSMutableArray *dataArr = [NSMutableArray array];
    
    for (int i = 0 ; i < titleArr.count ; i++) {
        
        NSMutableArray *arr = [NSMutableArray array];
        for (int j = 0 ; j < arc4random() % (self.titleArr.count - 4) + 4; j ++) {
            [arr addObject:[NSString stringWithFormat:@"%@-%d" , self.titleArr[i] , j]];
        }
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                   @"title" : titleArr[i] ,//标题
                                                                                   @"list" : arr ,   //右边数组
                                                                                   @"row" : @(0) ,    //左边选中row
                                                                                   
                                                                                   }];
        [dataArr addObject:dic];
    }
    
    self.dataArr = [dataArr copy];
    
    self.currentRow = 0;
    self.selectRow = 0;
    
    [self setUI];
    [self setNav];
    
}

- (void)setNav {
    
    SearchNavView *view = [[SearchNavView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_width, NavigationHeight) style:SearchNavStyleNone];
    view.textField.backgroundColor = UIColorFromRGB(0xf5f5f5);
    
//    @weakify(self);
    [view.searchSignal subscribeNext:^(id x) {
//        @strongify(self);
//        [self.navigationController pushViewController:[FirstViewController new] animated:YES];
        
        NSLog(@"进入搜索");
    }];
    [self.view insertSubview:view aboveSubview:self.titleView];
    [self.view bringSubviewToFront:view];
}



- (void)setUI {
    
    
    //titleview
    self.titleView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NavigationHeight, kMainScreen_width - 70, 40)];
    [self.view addSubview:self.titleView];
    NSMutableArray *btnArr = [NSMutableArray array];
    for (int i = 0 ; i < self.titleArr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnArr addObject:btn];
        
        CGFloat width = [BaseServiceTool textWidthWithText:self.titleArr[i] font:[UIFont systemFontOfSize:13.0]] + 10;
        if (i != 0) {
            UIButton *upBtn = btnArr[i - 1];
            btn.frame = CGRectMake(HPX(70) + CGRectGetMaxX(upBtn.frame), 0, width, 40);
        } else {
            btn.frame = CGRectMake(HPX(70) , 0, width, 40);
        }
        [self.titleView addSubview:btn];

        [btn setTitle:self.titleArr[i] forState:UIControlStateNormal];
        [btn setTitle:self.titleArr[i] forState:UIControlStateSelected];
        [btn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:13.0];
        btn.tag = i;
       
        
        [btn addTarget:self action:@selector(titleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            btn.selected = YES;

        }
    }
    
    //默认点击第一个
    [self titleBtnAction:self.titleButtons[0]];
    
    
    self.titleButtons = [btnArr copy];
    
    UIButton *lastBtn = self.titleButtons.lastObject; 
    self.titleView.contentSize = CGSizeMake(CGRectGetMaxX(lastBtn.frame) + HPX(70), 40);
    self.titleView.scrollEnabled = YES;
    self.titleView.showsHorizontalScrollIndicator = NO;
    
    
    //pullbutton
    UIButton *pullBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [pullBtn setImage:[UIImage imageNamed:@"图层 1"] forState:UIControlStateNormal];
    [self.view addSubview:pullBtn];
    [pullBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-10));
        make.top.equalTo(self.titleView.mas_top);
        make.bottom.equalTo(self.titleView.mas_bottom);
        make.width.equalTo(@(40));
    }];
    
    [pullBtn addTarget:self action:@selector(pullAction:) forControlEvents:UIControlEventTouchUpInside];
    self.pullButton = pullBtn;
    
    //点击遮罩
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"dismiss" object:nil] subscribeNext:^(id x) {
        self.pullButton.selected = NO;
    }];
    
     @weakify(self);
    [RACObserve(self.pullButton, selected) subscribeNext:^(NSNumber * x) {
        
        @strongify(self);
        if (x.integerValue) {
            [UIView animateWithDuration:1 animations:^{
                self.pullButton.imageView.transform = CGAffineTransformMakeRotation(M_PI);
            }];
            
            NSLog(@"下拉-- " );
            [self.pullView show];
            
        } else {
            [UIView animateWithDuration:1 animations:^{
                self.pullButton.imageView.transform = CGAffineTransformIdentity;
            }];
            
            NSLog(@"收起-- ");
            [self.pullView dismiss];
        }
    }];
    
    //allLabel
    UILabel *allLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, NavigationHeight, kMainScreen_width - 40, self.titleView.frame.size.height)];
    allLabel.text = @"      全部分类";
    [self.view addSubview:allLabel];
    
    allLabel.font = HPMZFont(37);
    allLabel.textColor = UIColorFromRGB(0x666666);
    allLabel.backgroundColor = [UIColor whiteColor];
    
    //allLabel显示与否 与 pullButton 是否选中正好 相反
    RAC(allLabel,hidden) = [RACObserve(self.pullButton, selected) map:^id(NSNumber * value) {
        return @(!value.boolValue);
    }];

    
    //pullview
    [[[RACSignal merge:self.pullView.btnSingals] flattenMap:^RACStream *(UIButton *button) {

        return [RACSignal return:@(button.tag)];
        
    }] subscribeNext:^(NSNumber *index) {
        @strongify(self);
        
        
        [self titleBtnAction:self.titleButtons[index.integerValue]];
        [self.pullView dismiss];
        self.pullButton.selected = NO;
        
        UIButton *btn = self.titleButtons[index.integerValue];
        
        [self.titleView setContentOffset:CGPointMake(CGRectGetMinX(btn.frame) / kMainScreen_width * kMainScreen_width - 15, 0) animated:YES];
        
 
    }];
  
    //line
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.titleView.mas_bottom).offset(-0.5);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@(0.5));
    }];
    
    
    [self setLeftTab];
    [self setRightTabTitle];
    [self setRightTab];
    
}
#pragma mark - 综合排序 筛选
- (void)setRightTabTitle {
    
    // 排序  筛选  按钮
    CategoryButtonView *titleV = [[CategoryButtonView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.leftTab.frame) , CGRectGetMinY(self.leftTab.frame), kMainScreen_width - CGRectGetWidth(self.leftTab.frame), HPX(86))];
    [self.view addSubview:titleV];
    self.titleV = titleV;
    
    //排序
    @weakify(self);
    [[titleV.sortBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton * x) {
        
        @strongify(self);
        x.selected = !x.selected;
        
        if (x.selected) {
            
            [self.view addSubview:self.plurView];
            [self.plurView addSubview:self.smallTab];
            [self.smallTab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@(0));
                make.right.equalTo(@(0));
                make.height.equalTo(@(HPX(88) * self.arr.count));
                make.top.equalTo(@(0));
            }];
            
            [UIView animateWithDuration:1 animations:^{
                x.imageView.transform = CGAffineTransformMakeRotation(M_PI);
            }];
            
            
        } else  {
            
            [UIView animateWithDuration:1 animations:^{
                
                x.imageView.transform = CGAffineTransformIdentity;
                [self.smallTab removeFromSuperview];
                [self.plurView removeFromSuperview];
            }];
            
            
            
        };
    }];
    
    
    self.smallModel = [[DataSourceModel alloc]initWithCellID:NSStringFromClass([TitleCell class]) configureCellBlock:^(TitleCell * cell, id  _Nonnull item, NSIndexPath * _Nonnull indexPath) {
        @strongify(self);
        [cell configCellWithItem:self.arr[indexPath.row] select:indexPath.row == self.selectRow];

    }];
    
    self.smallTab.dataSource = self.smallModel;
   
    RAC(self.smallModel , dataSource) = RACObserve(self, arr);
 
    
    
    //筛选
    [[titleV.filtterBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton * x) {
        @strongify(self);
        
        NSArray *arr  = @[@"安井" , @"海信" , @"正大" ,@"安井" , @"海信" , @"正大" ,@"安井" , @"海信" , @"正大" ,@"安井" , @"海信" , @"正大" ,@"海信" , @"正大" ,@"安井" ,@"海信" , @"正大" ,@"安井" ,@"海信" , @"正大" ,@"安井" ,];
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSString *str in arr) {
            Goods *model = [Goods new];
            model.brandTitle = str;
            model.select = NO;
            [arrM addObject:model];
            model.title = @"【双汇】王中王香肠双汇王中王香肠你知道会玩放假哦我就";
            
        }
        self.fillterView.brandsArr = [arrM copy];
        self.fillterView.goodsArr = [arrM copy];
        [self.fillterView showView];
        
    }];

}


#pragma mark - left tab
- (void)setLeftTab {
    
    //leftTab
    self.leftTab = [[ASTableNode alloc]initWithStyle:UITableViewStylePlain];
    self.leftTab.frame = CGRectMake(0, CGRectGetMaxY(self.titleView.frame), 100, kMainScreen_height - 40 - NavigationHeight);
    [self.view addSubview:self.leftTab.view];
    self.leftTab.delegate = self;
    //    self.leftTab.dataSource = self;
    self.leftTab.view.estimatedRowHeight = 40;
    self.leftTab.view.tableFooterView = [UIView new];
    self.leftTab.view.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.leftTab.backgroundColor = UIColorFromRGB(0xf1f2f4);
    
    self.leftModel = [[DataSourceModel alloc]initWithCellID:NSStringFromClass([ASButtonCell class]) configureCellBlock:^(ASButtonCell * cell, id  _Nonnull item, NSIndexPath * _Nonnull indexPath) {
        
        
        NSDictionary *dic = self.dataArr[self.currentBtn.tag];
        NSInteger currentRow = [[dic valueForKey:@"row"] integerValue];
        NSDictionary *dic2 = @{
                               @"title" : self.leftArr[indexPath.row],
                               @"currentRow" : @(currentRow) ,
                               @"index" : indexPath
                               
                               };
        
        [cell configCellWithDic:dic2];
    }];
    
    self.leftTab.dataSource = self.leftModel;
    
    RAC(self.leftModel,dataSource) = RACObserve(self, leftArr);
}

#pragma mark - right tab
- (void)setRightTab {
    
    //rightTab
    self.rightTab = [[ASTableNode alloc]initWithStyle:UITableViewStylePlain];
    self.rightTab.frame = CGRectMake(CGRectGetMaxX(self.leftTab.frame), CGRectGetMaxY(self.titleV.frame), kMainScreen_width - CGRectGetWidth(self.leftTab.frame), kMainScreen_height - 40 - NavigationHeight - CGRectGetHeight(self.titleV.frame));
    [self.view addSubview:self.rightTab.view];
    self.rightTab.delegate = self;
    
    self.rightTab.view.tableFooterView = [UIView new];
    
    self.rightModel = [[DataSourceModel alloc]initWithCellID:NSStringFromClass([ASTableCell class]) configureCellBlock:^(ASTableCell * cell, id  _Nonnull item, NSIndexPath * _Nonnull indexPath) {
        [cell configCellWithItem:self.rightArr[indexPath.row]];
        cell.buyAction = ^(NSString * _Nonnull str) {
            PhotoModel *m = self.rightArr[indexPath.row];
            NSLog(@"isSelect -- %@ " ,m  );
            //            [self.rightTab reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [self.rightTab reloadData];
            
        };
        
    }];
    self.rightTab.dataSource = self.rightModel;
    
    RAC(self.rightModel,dataSource) = RACObserve(self, rightArr) ;
    
    self.rightTab.view.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.rightTab reloadData];
        [self.rightTab.view.mj_header endRefreshing];
    }];
}


- (WaterfallView *)pullView {
    if (!_pullView) {
        _pullView = [[WaterfallView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleView.frame), kMainScreen_width, 0) arr:self.titleArr];
        
    }
    return _pullView;
}


- (void)pullAction:(UIButton *)sender {
    sender.selected = !sender.selected;
  
}

- (void)titleBtnAction:(UIButton *)sender {
    
    
    for (UIButton *btn in self.titleButtons) {
        if (btn.tag == sender.tag) {
            btn.selected = YES;
        } else {
            btn.selected = NO;
        }
    }
    
    for (UIButton *btn in self.pullView.buttonsArr) {
        if (btn.tag == sender.tag) {
            btn.selected = YES;
        } else {
            btn.selected = NO;
        }
    }
    
    self.currentBtn = sender;
    
    NSDictionary *dic = self.dataArr[sender.tag];
    self.leftArr = [dic valueForKey:@"list"];
    
    self.rightArr = [self getRight:sender.tag];
    
    [self.leftTab reloadData];
    [self.rightTab reloadData];
    
    
}

- (NSArray *)getRight:(NSInteger)index {
    
    NSMutableArray *arr = [NSMutableArray array];
    
    NSDictionary *dic = self.dataArr[index];
    
    NSInteger currentRow = [[dic valueForKey:@"row"] integerValue];
    
    for (int i = 0 ; i < arc4random() % (self.titleArr.count ) + 4; i ++) {
        
        PhotoModel *m = [PhotoModel creatModel:@{
                                                 @"text" : [NSString stringWithFormat:@"%@-%d" , self.leftArr[currentRow] , i] ,
                                                 @"isSelect" : @"0" ,
                                                 
                                                 }];
        
        [arr addObject:m];
        
    }
    return [arr copy];
}

#pragma mark - ASTableDelegate , ASTableDataSource


- (void)tableNode:(ASTableNode *)tableNode didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableNode deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableNode == self.leftTab) {
        NSMutableDictionary *dic = self.dataArr[self.currentBtn.tag];
        [dic setValue:@(indexPath.row) forKey:@"row"];

        self.rightArr = [self getRight:indexPath.row];
        [self.leftTab reloadData];
        [self.rightTab.view.mj_header beginRefreshing];
        
        self.selectRow = 0;
        [self dissmissTab];
       
    }
  
}

- (void)dissmissTab {
    

    [self.titleV.sortBtn setTitle:self.arr[self.selectRow] forState:UIControlStateNormal];
    self.titleV.sortBtn.selected = NO;
    [UIView animateWithDuration:1 animations:^{

        self.titleV.sortBtn.imageView.transform = CGAffineTransformIdentity;
        [self.smallTab reloadData];
        [self.smallTab removeFromSuperview];
        [self.plurView removeFromSuperview];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    
    self.selectRow = indexPath.row;
    [self dissmissTab];
    
    
    //排序 刷新 righ tab
    [self.rightTab reloadData];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return HPX(88);
}




#pragma mark - 懒加载
- (UIView *)plurView {
    
    if (!_plurView) {
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.rightTab.frame), CGRectGetMinY(self.rightTab.frame), CGRectGetWidth(self.rightTab.frame), CGRectGetHeight(self.rightTab.frame) - TabbarHeight)];
        view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        _plurView.userInteractionEnabled = YES;
        _plurView = view;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dissmissTab)];
        tap.delegate = self; //解决手势 和 cell 点击 冲突
        [_plurView addGestureRecognizer:tap];
 
    }
    return _plurView;
    
}


- (UITableView *)smallTab {
    
    if (!_smallTab) {
        UITableView *tab = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [tab registerClass:[TitleCell class] forCellReuseIdentifier:NSStringFromClass([TitleCell class])];
        tab.delegate = self;
        _smallTab = tab;
        
    }
    return _smallTab;
}

- (CategoryFillerView *)fillterView {
    
    if (!_fillterView) {
        _fillterView = [[CategoryFillerView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _fillterView;
    
}


#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(nonnull UITouch *)touch{
    
    NSLog(@"touch view class-%@" , [touch.view class]);
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        
        return NO;
    }else {
        
        return YES;
    }
}


@end
