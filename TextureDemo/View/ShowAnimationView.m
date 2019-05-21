//
//  ShowAnimationView.m
//  TextureDemo
//
//  Created by zqp on 2019/4/10.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import "ShowAnimationView.h"

@interface ShowAnimationView ()<ASTableDelegate , ASTableDataSource , UIGestureRecognizerDelegate>

@property (nonatomic , strong) UIView * contentView;
@property (nonatomic , strong) ASTableNode *tab;
@property (nonatomic , strong) NSArray *dataArr;
@property (nonatomic , assign) NSInteger currentRow;
@property (nonatomic , assign) CGFloat width;
@property (nonatomic , strong)NSString *cellid;

@end

@implementation ShowAnimationView

- (instancetype)initWithFrame:(CGRect)frame data:(NSArray *)data {
    self = [super initWithFrame:frame];
    if (self) {
        self.dataArr = data;
        self.width = frame.size.width;
        [self layoutSubViews];
    }
    return self;
}



- (void)layoutSubViews {
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissHintView)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
   
    ASTableNode *tab = [[ASTableNode alloc]initWithStyle:UITableViewStylePlain];
    [self addSubview:tab.view];
    tab.delegate = self;
    tab.dataSource = self;
    
    
    tab.frame = CGRectMake(0, 0, self.width, self.dataArr.count * 30);
    NSLog(@"-----%f" , self.width);
    tab.view.scrollEnabled = NO;
    self.tab = tab;
}

#pragma mark - ASTableDelegate , ASTableDataSource
- (ASCellNode *)tableNode:(ASTableNode *)tableNode nodeForRowAtIndexPath:(NSIndexPath *)indexPath {
    ASTextCellNode *cell = [[ASTextCellNode alloc]init];
    NSString *str = self.dataArr[indexPath.row];
    cell.text = str;
    
    cell.textAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:13.0] , NSForegroundColorAttributeName : indexPath.row == self.currentRow ? [UIColor orangeColor] : [UIColor blackColor]};
    cell.textInsets = UIEdgeInsetsMake(8, (kMainScreen_width - str.length * 13) / 2.0, 0, -(kMainScreen_width - str.length * 13) / 2.0);
    return cell;
}

- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (NSInteger)numberOfSectionsInTableNode:(ASTableNode *)tableNode {
    return 1;
}

- (ASSizeRange)tableNode:(ASTableNode *)tableNode constrainedSizeForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ASSizeRangeMake(CGSizeMake(kMainScreen_width, 30));
}

#pragma mark - 解决手势冲突

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    NSLog(@" ---- %@" , NSStringFromClass([touch.view class]));
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"_ASDisplayView"] ) {
        return NO;
    } else {
        
        return YES;
    }
    
}


- (void)tableNode:(ASTableNode *)tableNode didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableNode deselectRowAtIndexPath:indexPath animated:YES];
    
    [self dismissHintView];
    self.isShow = NO;
    
    self.currentRow = indexPath.row;
    
    if (_selectBlock) {
        _selectBlock(indexPath);
    }
}



- (void)dismissHintView {
    
    self.isShow = NO;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)showView {
    
    self.isShow = YES;
    
    [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:self];
    
    self.alpha = 0.0;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.alpha = 1.0;
        [self.tab reloadData];
    } completion:nil];
}


@end
