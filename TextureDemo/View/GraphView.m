//
//  GraphView.m
//  TextureDemo
//
//  Created by zqp on 2019/4/19.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import "GraphView.h"


//1弧度= 180/π 度
//1度= π/180 弧度

#define ANGLE_COS(Angle) cos(M_PI / 180 * (Angle))
#define ANGLE_SIN(Angle) sin(M_PI / 180 * (Angle))


@interface GraphView ()

@property (nonatomic , assign) CGFloat radius;//半径

@property (nonatomic , strong) UIBezierPath *bezierPath;
@property (nonatomic , strong) UIBezierPath *valuePath;

@property (nonatomic , strong) NSArray *valuePoints;
@property (nonatomic , strong) NSArray *cornerPointArrs;

@property (nonatomic , strong) CAShapeLayer *shaperLayer;
@property (nonatomic , strong) CAShapeLayer *shapeLayer;
@property (nonatomic , assign) NSInteger valueRankNum;





@end

@implementation GraphView

- (UIBezierPath *)bezierPath {
    if (!_bezierPath) {
        _bezierPath = [UIBezierPath bezierPath];
    }
    return _bezierPath;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        [self getPoints];
        if (!self.valueRankNum) {
            self.valueRankNum = 3;
        }
    }
    return self;
}

- (void)getPoints {
    
    self.values =  @[@(0.3),@(0.7),@(0.4),@(0.6),@(0.7),@(0.4)];
    self.radius = self.bounds.size.width / 2.0 - 30;
    
    //中心坐标
    CGFloat centerX = self.bounds.size.width / 2.0;
    CGFloat centerY = self.bounds.size.height / 2.0;
    
    NSMutableArray *tempValusPoints = [NSMutableArray array];
    NSMutableArray *tempCornerPoints = [NSMutableArray array];
    
    //计算所有点的坐标
    for (int i = 0; i < self.nameArr.count; i++) {
        CGFloat valueRadius = [self.nameArr[i] floatValue] * self.radius;
        CGPoint valuePoint = CGPointMake(centerX - ANGLE_COS(90.0 - 360.0 / self.nameArr.count * i) * valueRadius, centerY - ANGLE_SIN(90.0 - 360.0/self.nameArr.count * i) * valueRadius);
        [tempValusPoints addObject:[NSValue valueWithCGPoint:valuePoint]];
    }
    
    //side corners
    CGFloat rankValue  = self.radius / self.valueRankNum;
    for (int i = 0; i < self.valueRankNum; i++) {
        NSMutableArray *temp = [NSMutableArray array];
        for (int j = 0; j < self.nameArr.count; j++) {
            NSInteger rank = i + 1;
            CGPoint cornerPoint = CGPointMake(centerX - ANGLE_COS(90.0 - 360.0 / self.nameArr.count * j) * rankValue * rank, centerY - ANGLE_SIN(90.0 - 360.0 / self.nameArr.count * j) * rankValue * rank);
            [temp addObject:[NSValue valueWithCGPoint:cornerPoint]];
        }
        [tempCornerPoints addObject:[temp copy]];
    }
    
    self.cornerPointArrs = [tempCornerPoints copy];
    self.valuePoints = [tempValusPoints copy];
    
}

- (NSArray *)getPointWithRadius:(CGFloat)radius {
    NSMutableArray *inCornerPoints = [NSMutableArray array];
    for (int i = 0; i < self.nameArr.count; i++) {
//        CGPoint cornerPoint = CGPointMake(<#CGFloat x#>, <#CGFloat y#>)
    }
    return inCornerPoints;
}

- (void)drawRect:(CGRect)rect {
    
    self.nameArr =  @[@"chinese" , @"math" , @"english" , @"history" , @"pe" , @"physical"];
    self.values =  @[@(0.66),@(0.88),@(0.54),@(0.9),@(0.7),@(0.8)];
    self.radius = self.bounds.size.width / 2.0 - 30;
    
    //一个不透明类型的Quartz 2D 绘画环境，相当于一个画布，你可以在上面任意绘画
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);//线宽
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);//线条颜色
    UIColor *aColor = [UIColor colorWithRed:1 green:0.5 blue:0.2 alpha:0.2];
    CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
    //中心坐标
    CGFloat centerX = self.bounds.size.width / 2.0;
    CGFloat centerY = self.bounds.size.height / 2.0;
//    CGPoint ceter = CGPointMake(centerX, centerY);
    
    //从第一个点开始
    CGContextMoveToPoint(context, centerX, centerY + self.radius);
    
    for (int i = 0; i < self.nameArr.count; i++) {
        CGPoint point = [self getPonitWithIndex:i];
        
        //记录上一个点 并连接这个点
        CGContextAddLineToPoint(context, centerX + point.x, centerY + point.y);
    }
    
    CGContextClosePath(context);//结束一次绘画
    CGContextDrawPath(context, kCGPathFillStroke);//图形内容填充颜色方式（填满）
    CGContextStrokePath(context);//可以不设置
    
    //注释
    for (int i = 1; i < self.nameArr.count + 1; i++) {
        
        CGFloat x = 160 * sinf((i-1) * 2.0 * M_PI / self.nameArr.count);
        
        CGFloat y = 160 * cosf((i-1) * 2.0 * M_PI / self.nameArr.count);
        
        UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
        l.text = self.nameArr[i-1];
        l.center = CGPointMake(centerX + x , centerY + y);
        [self addSubview:l];
    }
    
    
}

- (CGPoint)getPonitWithIndex:(NSInteger)index {
    CGFloat value = [self.values[index] floatValue];
    CGFloat x = 160 * value * sinf((index ) * 2 * M_PI / self.nameArr.count);
    CGFloat y = 160 * value * cosf((index) * 2 * M_PI / self.nameArr.count);
    return CGPointMake(x, y);
}

@end
