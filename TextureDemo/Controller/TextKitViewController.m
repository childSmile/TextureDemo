//
//  TextKitViewController.m
//  TextureDemo
//
//  Created by zqp on 2019/6/3.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import "TextKitViewController.h"

@interface TextKitViewController ()

@end

@implementation TextKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUI];
    
}

- (void)setUI{
    
  
    
    
    //Text storage 管理者一系列的NSLayoutManager 对象，当它的字符或者属性改变时会通知到自己所管理的layout Manager对象以便他们作出相应的反应在layout manager上面是一个NSTextContainer对象，用于为layout manager定义坐标系和一些几何特性。例如，如果你想UITextView中的文本环绕在一张图片四周，你可以给text container设定一个排除路径(exclusion path)。
    
    
    //NSTextContainer  创建一个文本区块，文本d内容将这个区块进行渲染
    /**
     
     //初始化方法 设置区块的尺寸
     - (instancetype)initWithSize:(CGSize)size;
     //与其绑定的layoutManager 需要注意，不是设置这个属性 使用[NSLayoutManager addTextContainer:]方式来进行绑定
     @property(nullable, assign, NS_NONATOMIC_IOSONLY) NSLayoutManager *layoutManager;
     //替换绑定的布局管理类对象
  
     @property(NS_NONATOMIC_IOSONLY) CGSize size;
     //设置从区块中剔除某一区域
     @property(copy, NS_NONATOMIC_IOSONLY) NSArray<UIBezierPath *> *exclusionPaths;
     //设置截断模式 需要注意 这个属性的设置只是会影响此区块的最后一行的截断模式
     @property(NS_NONATOMIC_IOSONLY) NSLineBreakMode lineBreakMode;
     //设置每行文本左右空出的间距
   
     
     exclusionPaths
     **/
    NSTextContainer *container = [[NSTextContainer alloc]initWithSize:CGSizeMake(300, 500)];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(200, 200) radius:40 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    container.exclusionPaths = @[path];
    container.lineBreakMode = NSLineBreakByCharWrapping;
    
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc]init];
    [layoutManager addTextContainer:container]; //绑定的layoutManager
    
    NSTextStorage *storage = [[NSTextStorage alloc]initWithString:@""];
    [storage addLayoutManager:layoutManager];
    
    UITextView *textView = [[UITextView alloc]initWithFrame:self.view.bounds textContainer:container];
//    [self.view addSubview:textView];
    textView.backgroundColor = UIColorFromRGB(0xf6f6f6);
    textView.textColor = UIColorFromRGB(0x999999);
    textView.font = [UIFont systemFontOfSize:13];
    
    
    //NSTextAttachment  文本附件 ，NSTextAttachment 并不直接参与富文本的渲染和布局，渲染和布局依然是由NSMutableAttributedString来完成， NSAttributedString类中提供了方法将NSTextAttachment所描述的内容转换为NSAttributedString示例。
    //eg1.与label合用 ，图文混排
    NSTextAttachment *attach = [[NSTextAttachment alloc]init];
    
    //设置显示的图片
    attach.image = [UIImage imageNamed:@"pic"];
    //设置尺寸
    attach.bounds = CGRectMake(0, 0, 120, 60);
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:@"fffegeg wfwfw fjwo解耦方位角为奇偶if鸡尾酒范围我偶家我if急哦我挤我来咯哦积分if噢噢噢噢   宫崎勤匹配噼噼啪啪  皮皮开辟人多陪我IP我 决斗我"];
    
    //创建文本 将图片通过attach创建 并转化为富文本
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithAttributedString:[NSAttributedString attributedStringWithAttachment:attach]];
    
    //将图片放在文本的哪个地方
    [attri insertAttributedString:att atIndex:2];
    
    //可以设置在Label 中实现图文混排
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 280, 540)];
    label.backgroundColor = [UIColor grayColor];
    label.numberOfLines = 0;
    label.attributedText = attri;
//    [self.view addSubview:label];
    
    
    //eg2. 与textview合用
    
    //创建一个数组存放附件
    NSMutableArray *attArray = [NSMutableArray array];
    //创建附件数据
    [attArray addObject:attach];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
