//
//  SalesReturnCell.m
//  TextureDemo
//
//  Created by zqp on 2019/5/14.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import "SalesReturnCell.h"
#import "TabViewController.h"

@interface SalesReturnCell ()<UIScrollViewDelegate >
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;//团购/ 优惠 类型的图片


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgWidthCon;//图片宽约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleWidthCon;//title宽约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewWidthCon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeiCon;
@property (weak, nonatomic) IBOutlet UIScrollView *sc;
@property (weak, nonatomic) IBOutlet UILabel *numberL;
@property (weak, nonatomic) IBOutlet UILabel *unitL;
@property (weak, nonatomic) IBOutlet UILabel *amountL;

@end

@implementation SalesReturnCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
  
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (void)configItem:(Goods *)model {
    
    // 显示图片 0团，1惠，2秒
    NSArray *imgs = @[@"团" , @"惠" , @"秒"];
    
    
    [self.imgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(HPX(22)));
        make.left.equalTo(@(HPX(16)));
        make.width.equalTo(@(HPX(186)));
        make.height.equalTo(@(HPX(190)));
    }];
    
//    [self.typeImageView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@(kMainScreen_width - HPX(72) - HPX(63) - HPX(33)) );
//
//
//    }];
    
    [self.titleL mas_updateConstraints:^(MASConstraintMaker *make) {
//        
//        if (model.buyType.integerValue > imgs.count) {
//            make.left.equalTo(self.typeImageView.mas_left);
//        } else {
//            
//        }
        make.left.equalTo(self.typeImageView.mas_right).offset(HPX(30));
        make.top.equalTo(self.imgView.mas_top);
//        make.right.equalTo(self.typeImageView.mas_left).offset(-HPX(86));
//        make.width.equalTo(@(kMainScreen_width - CGRectGetMaxX(self.typeImageView.frame) - HPX(30)));
        make.width.equalTo(@(kMainScreen_width - HPX(186) - HPX(84) - HPX(72) - HPX(63)));//这个你自己根据具体大小计算一下 我随便写的
        
//        make.right.equalTo(@(kMainScreen_width - HPX(30) - HPX(30)));
    }];
//    self.titleL.backgroundColor = [UIColor redColor];
    
    self.viewWidthCon.constant = HPX(1510);
    self.viewHeiCon.constant = HPX(230) + (model.arr.count - 1 ) * HPX(60);
    
    
    self.titleL.text = model.title;
    self.typeImageView.image = [UIImage imageNamed:model.buyType.integerValue < imgs.count ? imgs[model.buyType.integerValue] : @""];
    
    self.btnSingals = [NSMutableArray array];
    self.amountSingals = [NSMutableArray array];
    
    //避免复用 先删除
    for (UIView *v in self.subviews) {
        if (v.tag >= 1000) {
            [v removeFromSuperview];
        }
    }
    //避免复用位置不对
    [self.sc setContentOffset:model.offset];
    
    @weakify(self);
    [[self rac_signalForSelector:@selector(scrollViewDidEndDecelerating:) fromProtocol:@protocol(UIScrollViewDelegate)] subscribeNext:^(id x) {
        @strongify(self);
        model.offset = self.sc.contentOffset;
        
    }];
  
    self.sc.delegate = nil;
    self.sc.delegate = self;
    
    self.userInteractionEnabled = YES;
    [self addGestureTapEventHandle:^(id sender, UITapGestureRecognizer *gestureRecognizer) {
        @strongify(self);
        [self endEditing:YES] ;
    }];
    
    
    for (int i = 0; i < model.arr.count; i++) {
        RecordModel *m = model.arr[i];
        
        UILabel *l = [UILabel new];
        [self addSubview:l];
        [l mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.typeImageView.mas_left);
            make.top.equalTo(self.typeImageView.mas_bottom).offset(i * HPX(33) + (i + 1) * HPX(37));
        }];
        l.text = m.text;
        l.textColor = UIColorFromRGB(0x939393);
        l.font = HPMZFont(35);
        l.tag = 1000 + i;
        
       
        
        //退
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.titleL.mas_right);
            make.centerY.equalTo(l.mas_centerY);
            make.width.equalTo(@(HPX(111)));
            make.height.equalTo(@(HPX(55)));
        }];
        
        [btn setTitle:@"退" forState:UIControlStateNormal];
        btn.titleLabel.font = HPMZFont(35);
        [btn setTitleColor:UIColorFromRGB(0xF6551A) forState:UIControlStateNormal];
        btn.layer.cornerRadius = HPX(7);
        btn.layer.borderWidth = HPX(1);
        btn.layer.borderColor = [UIColorFromRGB(0xF6551A) CGColor];
        btn.tag = 1002 + i;
        
        //单价
        UILabel *l2 = [UILabel new];
        [self addSubview:l2];
        [l2 mas_makeConstraints:^(MASConstraintMaker *make) {
            //            make.right.equalTo(self.titleL.mas_right);
            make.right.equalTo(btn.mas_left).offset(- HPX(15));
            make.centerY.equalTo(l.mas_centerY);
        }];
        l2.text = m.price;
        l2.textColor = UIColorFromRGB(0xF6551A);
        l2.font = HPMZFont(43);
        l2.tag = 1001 + i;
        RAC(l2 , text) = [RACObserve(m, price) map:^id(NSString * value) {
            return [NSString stringWithFormat:@"￥%@" ,value] ;
        }];
        
        //数量 可编辑
        UITextField *t = [UITextField new];
        [self addSubview:t];
        [t mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.numberL.mas_centerX);
            make.centerY.equalTo(l.mas_centerY);
            make.width.equalTo(btn.mas_width);
            make.height.equalTo(btn.mas_height);
        }];
        t.text = m.number;
        t.layer.cornerRadius = HPX(7);
        t.layer.borderWidth = HPX(1);
        t.layer.borderColor = [UIColorFromRGB(0x939393) CGColor];
        t.textColor = UIColorFromRGB(0x939393);
        t.font = HPMZFont(43);
        t.textAlignment = NSTextAlignmentCenter;
        t.tag = 1003 + i;
        t.keyboardType = UIKeyboardTypeNumberPad;

        RAC(t , text) = RACObserve(m, number);
        
        
//        RACChannelTo(m,number) = RACChannelTo(t,text);
//        RACChannelTo(t,text) = RACChannelTo(m,number);
//        [t.rac_textSignal subscribe:RACChannelTo(m,number)];
//        [t.rac_textSignal subscribeNext:^(NSString * x) {
//            if (x.integerValue > 5) {
//                x = @"5";
//            }
//        }];
        
        
        //单位
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn2];
        [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.unitL.mas_centerX);
            make.centerY.equalTo(l.mas_centerY);
            make.width.equalTo(@(HPX(111)));
            make.height.equalTo(@(HPX(55)));
        }];
        
        
        // model 里 的单位 作为默认值
        [btn2 setTitle:m.unit forState:UIControlStateNormal];
        [btn2 setImage:[UIImage imageNamed:@"下拉"] forState:UIControlStateNormal];
        //调整 title 和 image 位置
        [btn2 layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleRight imageTitleSpace:HPX(0)];
        btn2.titleLabel.font = HPMZFont(35);
        [btn2 setTitleColor:UIColorFromRGB(0x939393) forState:UIControlStateNormal];
        btn2.layer.cornerRadius = HPX(7);
        btn2.layer.borderWidth = HPX(1);
        btn2.layer.borderColor = [UIColorFromRGB(0x939393) CGColor];
        btn2.tag = 1004 + i;
        [self.btnSingals addObject:[btn2 rac_signalForControlEvents:UIControlEventTouchUpInside]];
        
        //金额
        UILabel *l3 = [UILabel new];
        [self addSubview:l3];
        [l3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.amountL.mas_centerX);
            make.centerY.equalTo(l.mas_centerY);
            
        }];
        l3.text = m.price;
        l3.textColor = UIColorFromRGB(0xF6551A);
        l3.font = HPMZFont(43);
        l3.tag = 1005 + i;
        
        // 编辑 点击 设置 RACObserve(m, number)
          
        
        RAC(l3,text) = [RACSignal combineLatest:@[t.rac_textSignal, RACObserve(m, price)] reduce:^id(NSString *number, NSString *price){

            
            if (number.integerValue > 5  ) {
                number = @"5";
            } else if (number.integerValue < 0 ) {
                number = @"1";
            }

            t.text = number;

            
            m.totalAmount = [NSString stringWithFormat:@"%ld" ,  number.integerValue * price.integerValue];
            m.totalNumber = number;
            m.number = number;

            
            //整个cell的总金额
            CGFloat total = 0;
            for (RecordModel *m in model.arr) {
                total += m.totalAmount.floatValue;
            }
            model.totalAmount = [NSString stringWithFormat:@"%.2f" , total];
            
            //通知计算退款总金额
            [[NSNotificationCenter defaultCenter] postNotificationName:CaculateTotalAmountNoticefication object:nil];
            
            return [NSString stringWithFormat:@"￥%ld" ,  number.integerValue * price.integerValue];;
        }];
        
        [self.amountSingals addObject:RACObserve(l3, text)];
       
        
        
        
        @weakify(self);
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            
            [self.sc setContentOffset:CGPointMake(self.sc.contentSize.width - self.sc.bounds.size.width, 0) animated:YES];
            model.offset = CGPointMake(self.sc.contentSize.width - self.sc.bounds.size.width, 0);
        }];
        
    }
    
   
    
    
    

}



@end
