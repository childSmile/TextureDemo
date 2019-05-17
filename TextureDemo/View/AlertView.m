//
//  AlertView.m
//  TextureDemo
//
//  Created by zqp on 2019/4/23.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import "AlertView.h"


@interface AlertView ()


@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic , strong) UITextView * contentView;
@property (nonatomic , strong) UIButton *okButton;
@property (nonatomic , strong) NSDictionary *dic;

//xib
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UITextView *contextV;
@property (weak, nonatomic) IBOutlet UIButton *btn;


@end

@implementation AlertView

- (void)awakeFromNib {
    
    [super awakeFromNib];
    self.btn.layer.cornerRadius = HPX(16);
}



- (void)setupUIWithData:(NSDictionary *)dic {
    
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.dic = dic;
    
    
    /**
    UILabel *l = [[UILabel alloc]init];
    
    [self addSubview:l];
    [l mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(HPX(53)));
        make.top.equalTo(@(HPX(159)));
        make.right.equalTo(@(-HPX(53)));
        
    }];
    l.font = HPMZFont(59);
    l.textColor = UIColorFromRGB(0x333333);
    l.text = self.dic[@"title"];
    self.titleLabel = l;

    
    UILabel *tl = [UILabel new];
    
    [self addSubview:tl];
    [tl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(l.mas_left).offset(HPX(10));
        make.top.equalTo(l.mas_bottom).offset(HPX(115));
        make.right.equalTo(l.mas_right).offset(-HPX(10));
    }];
    tl.font = HPMZFont(39);
    tl.textColor = UIColorFromRGB(0x666666);
    tl.text = self.dic[@"time"];
    
    self.timeLabel = tl;
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(l.mas_left);
        make.right.equalTo(l.mas_right);
        make.bottom.equalTo(@(-HPX(54)));
        make.height.equalTo(@(HPX(115)));
    }];
    btn.backgroundColor = UIColorFromRGB(0xF67420);
    [btn setTitle:@"好的，朕知道了" forState:UIControlStateNormal];
    [btn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    btn.layer.cornerRadius = HPX(16);
    self.singal = [btn rac_signalForControlEvents:UIControlEventTouchUpInside];
    
    self.okButton = btn;
    
    UITextView *tv = [UITextView new];
    [self addSubview:tv];
    
    [tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tl.mas_left).offset(-HPX(5));
        make.top.equalTo(tl.mas_bottom).offset(HPX(56));
        make.right.equalTo(tl.mas_right)offset(HPX(5));
        make.bottom.equalTo(btn.mas_top).offset(-HPX(54));
    }];
    tv.editable = NO;
//    tv.font = HPMZFont(39);
//    tv.textColor = UIColorFromRGB(0x666666);
//    tv.text = self.dic[@"content"];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    style.lineSpacing = 5;//行间距
    tv.attributedText = [[NSAttributedString alloc]initWithString:self.dic[@"content"] attributes:@{NSParagraphStyleAttributeName : style , NSFontAttributeName : HPMZFont(39) , NSForegroundColorAttributeName:UIColorFromRGB(0x666666)}];
    
    self.contentView = tv;
    */
    
    
    //xib
    self.titleL.text = dic[@"title"];
    self.timeL.text = dic[@"time"];
//    self.contextV.text = dic[@"content"];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    style.lineSpacing = 5;//行间距
    self.contextV.attributedText = [[NSAttributedString alloc]initWithString:self.dic[@"content"] attributes:@{NSParagraphStyleAttributeName : style , NSFontAttributeName : HPMZFont(39) , NSForegroundColorAttributeName:UIColorFromRGB(0x666666)}];
    self.singal = [self.btn rac_signalForControlEvents:UIControlEventTouchUpInside];
                           
    
}


@end
