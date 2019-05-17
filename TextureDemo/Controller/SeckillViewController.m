//
//  SeckillViewController.m
//  TextureDemo
//
//  Created by zqp on 2019/4/11.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import "SeckillViewController.h"
#import "ASTableCell.h"
#import "WebViewController.h"

@interface SeckillViewController ()<ASTableDelegate , ASTableDataSource>

@property (nonatomic , strong) UIScrollView *scrView;
@property (nonatomic , strong) UIView *titleView;
@property (nonatomic , strong) ASTableNode *tab;
@property (nonatomic , strong) NSArray *dataArr;
@property (nonatomic , strong) UILabel *leftLabel;
@property (nonatomic , strong) UILabel *rightLabel;
@property (nonatomic , assign) NSInteger currentIndex;


@end

@implementation SeckillViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(0xf5f5f5);
    
    self.dataArr = @[@{@"date" : @"2019/4/8" , @"flag" : @"1" , @"seckills":@[] , @"time" : @"8:00"} ,
                     @{@"date" : @"2019/4/8" , @"flag" : @"0" , @"seckills":@[], @"time" : @"9:00"} ,
                     @{@"date" : @"2019/4/8" , @"flag" : @"0" , @"seckills":@[], @"time" : @"10:00"},
                     @{@"date" : @"2019/4/8" , @"flag" : @"0" , @"seckills":@[], @"time" : @"11:00"},
                     @{@"date" : @"2019/4/8" , @"flag" : @"0" , @"seckills":@[], @"time" : @"12:00"} ,
                     @{@"date" : @"2019/4/8" , @"flag" : @"0" , @"seckills":@[], @"time" : @"13:00"}];
    
    [self setUI];
}

- (void)setUI {
    
    UIScrollView *sc = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NavigationHeight, kMainScreen_width, HPX(199.0))];
    sc.contentSize = CGSizeMake(kMainScreen_width / 4.0 * self.dataArr.count , HPX(199.0));
    sc.backgroundColor = [UIColor clearColor];
    self.scrView = sc;
    [self.view addSubview:sc];
   
    sc.showsHorizontalScrollIndicator  = NO;
    
    for (int i = 0; i < self.dataArr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * HPX(270.0) , 0, HPX(270),HPX(199));
        [sc addSubview:btn];
        NSDictionary *dic = self.dataArr[i];
        [btn setTitle:[NSString stringWithFormat:@"%@\n%@" , dic[@"date"] , dic[@"time"]] forState:UIControlStateNormal];
        [btn setTitleColor:UIColorFromRGB(0xf56d23) forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        [btn setBackgroundImage:[UIImage imageNamed:@"矩形 655"] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageNamed:@"white"] forState:UIControlStateNormal];
//        btn.backgroundColor = [UIColor whiteColor];
       
        btn.titleLabel.font = HPMZFont(40);
        
        btn.titleLabel.numberOfLines = 0;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        btn.selected = [dic[@"flag"] integerValue] == 1;
        
        btn.tag = i;
        
        if ( [dic[@"flag"] integerValue] == 1) {
            self.currentIndex = i;
        }
        
        
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(sc.frame), kMainScreen_width, HPX(120))];
    [self.view addSubview:v];
    self.titleView = v;
    
    UILabel *leftL = [[UILabel alloc]init];
    leftL.text = @"秒杀抢购中";
    leftL.textColor = UIColorFromRGB(0x333333);
    leftL.font = HPMZFont(40);
    
    [v addSubview:leftL];
    [leftL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(HPX(33)));
        make.centerY.equalTo(v.mas_centerY);
    }];
    
    self.leftLabel = leftL;
    
    UILabel *rigL = [[UILabel alloc]init];
    rigL.textColor = UIColorFromRGB(0xfe4d3b);
    rigL.font = HPMZFont(40);
    
    NSString *rig = @"距结束:00:00:00";
    
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:rig attributes:@{NSFontAttributeName : HPMZFont(40) , NSForegroundColorAttributeName : UIColorFromRGB(0xfe4d3b)}];
    [att addAttributes:@{NSForegroundColorAttributeName : UIColorFromRGB(0x333333)} range:[rig rangeOfString:@"距结束:"]];
    rigL.attributedText = att;
    [v addSubview:rigL];
    [rigL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-HPX(33)));
        make.centerY.equalTo(v.mas_centerY);
    }];
    
    self.rightLabel = rigL;
    
    
    
    [self.view addSubnode:self.tab];
    self.tab.dataSource = self;
    self.tab.delegate = self;
    
    
}


- (void)btnAction:(UIButton *)sender {
    
    for (UIView *v in self.scrView.subviews) {
        if ([v isKindOfClass:[UIButton class]]) {
            if (v == sender) {
                ((UIButton *)v).selected = YES;
            } else {
                 ((UIButton *)v).selected = NO;
            }
        }
    }
    NSLog(@" select -- %ld , reload" , sender.tag);
    self.currentIndex = sender.tag;
    
    
    NSDictionary *dic = self.dataArr[self.currentIndex];
    self.leftLabel.text = [dic[@"flag"] integerValue] == 1 ? @"秒杀抢购中" : @"秒杀即将开始";
    self.rightLabel.text = [dic[@"flag"] integerValue] == 1 ? @"距结束: 00:00:00 " : @"";
}

#pragma mark -ASTableDelegate , ASTableDataSource
- (ASCellNode *)tableNode:(ASTableNode *)tableNode nodeForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    ASTableCell *cell = [[ASTableCell alloc]init];
    [cell configCellWithItem:self.dataArr[indexPath.row][@"time"]];
    
    return cell;
}

- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (void)tableNode:(ASTableNode *)tableNode didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WebViewController *vc = [WebViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - 懒加载
-(ASTableNode *)tab {
    if (!_tab) {
        _tab = [[ASTableNode alloc]initWithStyle:UITableViewStylePlain];
        _tab.frame = CGRectMake(0, CGRectGetMaxY(self.titleView.frame), kMainScreen_width, kMainScreen_height - CGRectGetMaxY(self.titleView.frame));
    }
    return _tab;
}

@end
