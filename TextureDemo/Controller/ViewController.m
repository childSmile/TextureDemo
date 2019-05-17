//
//  ViewController.m
//  TextureDemo
//
//  Created by zqp on 2019/3/18.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import <Accelerate/Accelerate.h>
#import "ASCollectionCellNode.h"
#import "ASImageTitltNode.h"
#import "DetialCellNode.h"

#import "DetialViewController.h"

#import "SearchNavView.h"


@interface ViewController ()<ASTableDelegate , ASTableDataSource>

@property (nonatomic , strong) ASTableNode *tableNode;
@property (nonatomic , strong) NSArray *dataArray;

@end

@implementation ViewController

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
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.dataArray = @[
  
  @[@"abstract在骄傲你", @"animals等我还有", @"business", @"cats", @"city", @"food放不进看到回复", @"nightlife", @"fashion",] ,
  
                       @[@"animals等我还有", @"business", @"cats", @"city",] ,
  @[@"abstract在骄傲你", @"animals等我还有", @"business",@"abstract在骄傲你", @"animals等我还有", @"business",] ,
  @[@"abstract在骄傲你", @"animals等我还有", @"business",@"abstract在骄傲你", @"animals等我还有", @"business",] ,
                       @[ @"fashion", @"people", @"nature", @"sports", @"technics"]];
    
    [self.view addSubnode:self.tableNode];
    
    
    
    [self setNav];

    
}


- (void)setNav {

    SearchNavView *view = [[SearchNavView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_width, NavigationHeight)];
    
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = view.frame;
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:238/255.0 green:114/255.0 blue:135/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:255/255.0 green:175/255.0 blue:126/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0.0),@(1.0f)];

    [view.layer insertSublayer:gl atIndex:0];
    
    
    
    @weakify(self);
    [view.searchSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.navigationController pushViewController:[FirstViewController new] animated:YES];
        
        NSLog(@"进入搜索");
    }];
    
    [self.view insertSubview:view aboveSubview:self.tableNode.view];
}



- (ASTableNode *)tableNode {
    
    if (!_tableNode) {
        _tableNode = [[ASTableNode alloc]initWithStyle:UITableViewStylePlain];
        _tableNode.delegate = self;
        _tableNode.dataSource = self;
        _tableNode.backgroundColor = [UIColor whiteColor];
        _tableNode.view.frame = CGRectMake(0, NavigationHeight, kMainScreen_width, kMainScreen_height - NavigationHeight);
        
    }
    return _tableNode;
}

#pragma mark - ASTableDelegate , ASTableDataSource

- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 1;
    }
    return 2;
    
}

- (NSInteger)numberOfSectionsInTableNode:(ASTableNode *)tableNode {
    return 5;
}

- (ASCellNode *)tableNode:(ASTableNode *)tableNode nodeForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        ASCellNode *cell = [[ASCellNode alloc]initWithViewBlock:^UIView * _Nonnull{
            UIView * v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_width, 200)];
            for (int i = 0; i < 8; i ++) {
                ASImageTitltNode *node = [[ASImageTitltNode alloc]initWithImage:@"" title:@""];
                node.frame = CGRectMake(i % 4 * (kMainScreen_width / 4.0), i / 4 * 100, kMainScreen_width / 4.0, 100);
                [v addSubnode:node];
            }
            
            return v;
            
        }];
        return cell;
        
    } else if (indexPath.section == 1) {
        
        ASCellNode *cell = [[ASCellNode alloc]initWithViewBlock:^UIView * _Nonnull{
            UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_width, 200)];
            SDCycleScrollView *sc = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_width, 160)];
            sc.imageURLStringsGroup = @[@"https://beikbank-oss.oss-cn-hangzhou.aliyuncs.com/appBanner/ec7c32cd30ee4db186f913f63a349a32.jpeg" , @"https://beikbank-oss.oss-cn-hangzhou.aliyuncs.com/appBanner/07ad470b604d443bbf4d3185b8b35d40.jpeg"];
            [v addSubview:sc];
            
            UIView *bottomV = [[UIView alloc]init];
            [v addSubview:bottomV];
            [bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(sc.mas_bottom).offset(8);
                make.width.equalTo(@(kMainScreen_width));
                make.height.equalTo(@(30));
                make.bottom.equalTo(@(0));
            }];
            
            bottomV.backgroundColor = UIColorFromRGB(0xf9f9f9);
            
            SDCycleScrollView *sc2 = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(100, 0, kMainScreen_width - 200, 28)];
            [bottomV addSubview:sc2];
            sc2.titlesGroup = @[@"智能机多我的了看懂你家我怕就奇偶if奇偶偶么是找机会差距我hi我会放假哦忘记哦" , @"你家佛几万就看见我已"];
            sc2.imageURLStringsGroup = @[@"" , @""];
            sc2.onlyDisplayText = YES;
            sc2.scrollDirection = UICollectionViewScrollDirectionVertical;
            
            sc.currentPageDotImage = sc2.pageDotImage = [UIImage new];
            
            sc2.backgroundColor = sc2.titleLabelBackgroundColor = [UIColor clearColor];
            sc2.titleLabelTextFont = [UIFont systemFontOfSize:12.0];
            sc2.titleLabelTextColor = [UIColor blackColor];
            
            
            return v;
            
        }];
        return cell;
        
    } else if (indexPath.section == 2 || indexPath.section == 3){
        
        if (indexPath.row == 0) {
            ASCellNode *cell = [[ASCellNode alloc]initWithViewBlock:^UIView * _Nonnull{
                UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_width, 40)];
                v.backgroundColor = [UIColor whiteColor];
                return v;
            }];
            return cell;
        } else {
            
            ASCollectionCellNode *cell = [[ASCollectionCellNode alloc]initWithData:self.dataArray[indexPath.section]];
            
            return cell;
        }

    } else {
        if (indexPath.row == 0) {
            ASCellNode *cell = [[ASCellNode alloc]initWithViewBlock:^UIView * _Nonnull{
                UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_width, 40)];
                v.backgroundColor = [UIColor whiteColor];
                return v;
            }];
            return cell;
        } else {
            
            ASCollectionCellNode *cell = [[ASCollectionCellNode alloc]initWithData:self.dataArray[indexPath.section]];
            
            return cell;
        }
    }
    
}



- (ASSizeRange)tableNode:(ASTableNode *)tableNode constrainedSizeForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ((indexPath.section == 3 || indexPath.section == 2) && indexPath.row == 0) {
        return ASSizeRangeMake(CGSizeMake(kMainScreen_width, 40));

    } else if (indexPath.section == 4 && indexPath.row == 1) {
        CGSizeMake(kMainScreen_width, kMainScreen_height);
    }
    
        return ASSizeRangeMake(CGSizeMake(kMainScreen_width, 200) );
    
}


- (void)dealloc {
    _tableNode.delegate = nil;
    _tableNode.dataSource = nil;
}





- (void)setupUI {
//    ASImageViewNode *node = [[ASImageViewNode alloc]init];
////    node.style.preferredSize = CGSizeMake(100, 100);
//    node.frame = CGRectMake(100, 100, 50, 50);
//    node.backgroundColor = [UIColor greenColor];
//    [self.view addSubnode:node];
}



//
//- (void)setUI {
//
//
//    /* --- UIView---*/
//    ASDisplayNode *displayNode = [[ASDisplayNode alloc]init];
//    displayNode.backgroundColor = [UIColor redColor];
//    displayNode.frame = CGRectMake(50, 50, 100, 100);
////    NSLog(@" --%@" , displayNode.view);
//    //--<ASDisplayNode-View: 0x7fd63c5011d0; node = <ASDisplayNode: 0x7fd63c704240>; frame = (50 50; 100 100)>
//
////    [self.view addSubnode:displayNode];
//
//
//    ASDisplayNode *node2 = [[ASDisplayNode alloc] init];
//    node2.frame = CGRectMake(200, 50, 100, 100);
//    node2.backgroundColor = [UIColor greenColor];
//
//    node2.borderColor = [[UIColor blueColor]CGColor];
//    node2.clipsToBounds = YES;
//    node2.borderWidth = 3;
////    [self.view addSubnode:node2];
//
//
//    //相当于 block 内部创建的view 把 node 默认的view 替换掉
//    ASDisplayNode *node3 = [[ASDisplayNode alloc] initWithViewBlock:^UIView * _Nonnull{
//        UIView *view = [UIView new];
//        view.backgroundColor = [UIColor redColor];
//        view.frame =CGRectMake(50, 50, 100, 100);
//        return  view;
//    }];
//    node3.backgroundColor = [UIColor greenColor]; // 这样设置 会把上边的red  更换掉
////    NSLog(@"node3 === %@" , node3.view);
//    //node3 === <UIView: 0x7fa933505c70; frame = (50 50; 100 100); layer = <CALayer: 0x6000023b5640>>
//
////    [self.view addSubnode:node3];
//
//    /* --- UIButton---*/
//    ASButtonNode *btnNode = [[ASButtonNode alloc] init];
//    btnNode.frame = CGRectMake(100, 100, 100, 50);
//    btnNode.borderWidth = 1;
//    btnNode.borderColor = [[UIColor blackColor]CGColor];
//    [btnNode setTitle:@"下一个" withFont:nil withColor:[UIColor blackColor] forState:ASControlStateNormal];
//
//    [btnNode addTarget:self action:@selector(btnAction:) forControlEvents:ASControlNodeEventTouchUpInside];
//
////    btnNode.contentVerticalAlignment = ASVerticalAlignmentTop; //垂直方向
////    btnNode.contentHorizontalAlignment = ASHorizontalAlignmentLeft;//水平方向
//
//    [self.view addSubnode:btnNode];
//
//
//    /* --- UILabel  UITextView---*/
//
//     ASTextNode *textnode = [[ASTextNode alloc] init];
//
////    textnode.backgroundColor = [UIColor redColor];
//
//    //    NSDictionary *attrs = @{ NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:12.0f] };
//    //    NSAttributedString *string = [[NSAttributedString alloc] initWithString:@"Hey, here's some text." attributes:attrs];
//
//    //1.使用 NSAttributedString  进行初始化  没有text属性 只能通过 attributedText 赋值
////    textnode.attributedText = string;
//    textnode.frame = CGRectMake(15, 200, kMainScreen_width - 30, 500);
//
//
//    //2. 富文本 设置一个短连接
//    textnode.linkAttributeNames = @[NSLinkAttributeName];
//
//    NSString *blurb = @"kittens courtesy placekitten.com \U0001F638";
//    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:blurb];
//    [string addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f] range:NSMakeRange(0, blurb.length)];
//    [string addAttributes:@{
//                            NSLinkAttributeName: [NSURL URLWithString:@"http://placekitten.com/"],//点击可以跳转到这个链接  类似于创建一个超链接
//                            NSForegroundColorAttributeName: [UIColor grayColor],
//                            NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle | NSUnderlinePatternDot),//网址  带有虚线下划线
//                            }
//                    range:[blurb rangeOfString:@"placekitten.com"]];
////    textnode.attributedText = string;
//    textnode.userInteractionEnabled = YES;
//    textnode.delegate = self;// 必须添加代理  打开 用户交互
//
//
//    //3.NSMutableParagraphStyle  设置 textview 里的 行间距、段落间距、缩进等
//    NSString *someLongString = @"ASTextNode uses Text Kit internally to calculate the amount to shrink needed to result in the specified maximum number of lines. Unfortunately,  in certain cases this will result in the text shrinking too much in the above example; Instead of 4 lines of text, 3 lines of text and a weird gap at the bottom will show up. To get around this issue for now, you have to set the truncationMode explicitly to NSLineBreakByTruncatingTail on the text node:";
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
//    paragraphStyle.lineSpacing = 10; //行间距
//    paragraphStyle.paragraphSpacing = 10;//段落间距
//    UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:15.0];
//    NSDictionary *att = @{
//                          NSFontAttributeName : font,
//                          NSParagraphStyleAttributeName : paragraphStyle
//                          };
//
//    textnode.maximumNumberOfLines = 4;//最多显示行数
//    textnode.truncationMode = NSLineBreakByTruncatingTail;// eg: abc...
//    textnode.attributedText = [[NSAttributedString alloc]initWithString:someLongString attributes:att];
//
////    [self.view addSubnode:textnode];
//
//
//    /* --- UIImage --- */
//    ASImageNode *imageNode = [[ASImageNode alloc]init];
//    imageNode.backgroundColor = [UIColor redColor];
//    imageNode.frame = CGRectMake(20, 100, 200, 200);
//    imageNode.image = [UIImage imageNamed:@"pic"];
//    imageNode.contentMode = UIViewContentModeScaleAspectFill;
//
//    //1.加一层毛玻璃效果
////    imageNode.imageModificationBlock = ^UIImage * _Nullable(UIImage * _Nonnull image) {
////        UIImage *newImage = [image applyBlurWithRadius:30 tintColor:[UIColor colorWithWhite:0.5 alpha:0.1] saturationDeltaFactor:1.8 maskImage:nil];
////        return newImage ? : image;
////    };
//
////    2. UIViewContentModeScaleAspectFill  图片会默认放大 填充整个区域，有部分可能会被裁减掉，这是可以通过设置cropRect 移动图像，默认是CGRectMake(0.5, 0.5, 0.0, 0.0) ，0.5 是百分比,设置为0 0 会直接从图片的0 0 显示，0.5 0.5 是中间，1.0  1.0  是最右边
////    imageNode.cropRect = CGRectMake(0, 0, 0, 0);
//
//
////    [self.view addSubnode:imageNode];
//
//
//    //3. url 图片
//    ASNetworkImageNode *urlImageNode = [[ASNetworkImageNode alloc]init];
//    urlImageNode.URL = [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1552905599642&di=29bcb3216338400b0ee8229705901577&imgtype=0&src=http%3A%2F%2Fimg4q.duitang.com%2Fuploads%2Fitem%2F201505%2F03%2F20150503183309_L8vKY.thumb.700_0.jpeg"];
//    urlImageNode.frame = CGRectMake(100, 100, 50, 50);
//
////    [self.view addSubnode:urlImageNode];
//
//
//}
//
//
//
//
//- (void)btnAction:(ASButtonNode *)sender {
//    FirstViewController *vc = [FirstViewController new];
//    [self.navigationController pushViewController:vc animated:YES];
//}
//
//// 点击跳转链接 的代理方法
///**
// 类似的代理方法还有
// – textNode:longPressedLinkAttribute:value:atPoint:textRange:   长按
//
// – textNode:shouldHighlightLinkAttribute:value:atPoint:
//
// – textNode:shouldLongPressLinkAttribute:value:atPoint:
//
// */
//- (void)textNode:(ASTextNode *)textNode tappedLinkAttribute:(NSString *)attribute value:(NSURL *)URL atPoint:(CGPoint)point textRange:(NSRange)textRange {
//
//    // the link was tapped, open it
//    [[UIApplication sharedApplication] openURL:URL options:@{} completionHandler:nil];
//}




@end
