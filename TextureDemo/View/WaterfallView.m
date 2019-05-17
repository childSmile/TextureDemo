//
//  WaterfallView.m
//  TextureDemo
//
//  Created by zqp on 2019/4/15.
//  Copyright © 2019年 zqp. All rights reserved.
//




#import "WaterfallView.h"


@interface WaterfallView ()

@property (nonatomic , strong) NSArray *arr;
@property (nonatomic , strong) UIView *shadeView;
@property (nonatomic , assign) CGRect sFrame;


@end

@implementation WaterfallView


- (instancetype)initWithFrame:(CGRect)frame arr:(NSArray *)arr {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.arr = arr;
        self.sFrame = frame;
        self.backgroundColor = [UIColor whiteColor];
        
        [self setUIWith:frame];
        
    }
    return self;
    
}

- (UIView *)shadeView {
    
    if (!_shadeView) {
        CGRect frame = self.sFrame;
        UIView *v = [[UIView alloc]initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, kMainScreen_height - frame.origin.y)];
        v.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        _shadeView = v;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [_shadeView addGestureRecognizer:tap];
        _shadeView.userInteractionEnabled = YES;
    }
    
    return _shadeView;
    
}

- (void)tapAction:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dismiss" object:nil];
}

- (void)dismiss {
    
    [self.shadeView removeFromSuperview];
    [self removeFromSuperview];
    
}

- (void)show {
   
    [kWINDOW addSubview:self.shadeView];
    [kWINDOW addSubview:self];

}


- (void)setUIWith:(CGRect)frame {
    
    NSMutableArray *btnArr = [NSMutableArray array];
    NSMutableArray *signals = [NSMutableArray array];
    int j = 1;
    
    for (int i = 0; i < self.arr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnArr addObject:btn];
        btn.backgroundColor = UIColorFromRGB(0xf5f5f5);
        [btn setTitle:self.arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
        [btn setTitleColor:UIColorFromRGB(0xF56D23) forState:UIControlStateSelected];
        btn.titleLabel.font = HPMZFont(37);
        btn.layer.cornerRadius = HPX(14);
        btn.tag = i;
        
        if (i == 0) {
            btn.selected = YES;
        }
        
        //计算宽度 字体宽度 + 两边间距（ 20表示：字体与边框的距离, 可变)
        CGFloat width = [BaseServiceTool textWidthWithText:self.arr[i] font:HPMZFont(37)] + 20;
        if (i != 0) {
            
            UIButton *upBtn = btnArr[i - 1];
            
            //前一个按钮+间距+这个按钮宽度+间距 > 屏宽
            if (CGRectGetMaxX(upBtn.frame) + HPX(72) + width + HPX(35) > kMainScreen_width) {
                btn.frame = CGRectMake(HPX(35), j * HPX(75) + HPX(35) * (j + 1), width, HPX(75));
                j++;
            } else {
                btn.frame = CGRectMake(CGRectGetMaxX(upBtn.frame) + HPX(72), CGRectGetMinY(upBtn.frame), width , HPX(75));
            }
            
        } else {
            
            btn.frame = CGRectMake(HPX(35), HPX(33), width, HPX(75));
            
        }
        
        [self addSubview:btn];
        [signals addObject:[btn rac_signalForControlEvents:UIControlEventTouchUpInside]];
        
    }
    
    self.btnSingals = [signals copy];
    self.buttonsArr = [btnArr copy];
    
    CGFloat height = j * HPX(75) + (j + 1) * HPX(35);
    self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, height);
    
    
}



@end
