//
//  MyView.m
//  TextureDemo
//
//  Created by zqp on 2019/5/8.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import "MyView.h"

@implementation MyView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

@implementation TitleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"TitleView" owner:self options:nil];
        //得到第一个UIView
        self = [nib objectAtIndex:0];
        self.frame = frame;
        
        
    }
    return self;
}

@end


@implementation LineView

-(instancetype)initColor:(UIColor *)color {
    
    if ([super init]) {
        self.backgroundColor = color;
    }
    
    return self;
    
}


- (instancetype)init {
    
    if ([super init]) {
        self.backgroundColor = UIColorFromRGB(0xeeeeee);
    }
    
    return self;
}

@end
