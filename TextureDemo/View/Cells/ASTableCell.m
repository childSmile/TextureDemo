//
//  ASTableCell.m
//  TextureDemo
//
//  Created by zqp on 2019/3/26.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import "ASTableCell.h"

@interface ASTableCell ()<UITextFieldDelegate>

@property (nonatomic , strong) ASNetworkImageNode *imageNode;
@property (nonatomic , strong) ASTextNode *textNode;
@property (nonatomic , strong) ASTextNode *titleNode;
@property (nonatomic, strong) ASTextNode *weightNode;//规格
@property (nonatomic , strong) ASTextNode *priceNode;//价格
@property (nonatomic , strong) ASDisplayNode *progressNode;//进度条

@property (nonatomic , strong) ASTextNode *progressTextNode;//进度text
@property (nonatomic , strong) ASButtonNode *buyNode;

@property (nonatomic , strong) NSString *text;
@property (nonatomic , assign) float progress;

@property (nonatomic , strong) ASTextNode *salesNode;//销量


@property (nonatomic , strong) ASDisplayNode *numberNode;

@property (nonatomic , strong) NSArray * numbers;

@property (nonatomic , strong) PhotoModel *m;


@end

@implementation ASTableCell



- (instancetype)initWithText:(NSString *)text {
    
    self = [super init];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.text = text;
        [self setUI];
        
    }
    return self;
    
}


- (void)configCellWithItem:(id)item {
    
    if ([item isKindOfClass:[NSString class]]) {
        self.text = item;
    } else if ([item isKindOfClass:[PhotoModel class]]){
        
        self.m = (PhotoModel *)item;
        self.text = self.m.text;
    }
    
    [self setUI];
}


- (void)setUI {
    
    /*--------------_imageNode-----------------*/
    _imageNode = [[ASNetworkImageNode alloc]init];
    _imageNode.contentMode = UIViewContentModeScaleAspectFit;
    //        _imageNode.backgroundColor = [UIColor yellowColor];
    [self addSubnode:_imageNode];
    _textNode = [[ASTextNode alloc] init];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = 5;
    paragraphStyle.paragraphSpacing = 5;
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    
    NSString *string = [NSString stringWithFormat:@"%@" , _text];
    
    
    /*--------------_textNode-----------------*/
    _textNode.attributedText = [[NSAttributedString alloc]initWithString:string attributes:@{NSForegroundColorAttributeName : [UIColor blackColor] , NSParagraphStyleAttributeName : paragraphStyle}];
    _textNode.maximumNumberOfLines = 3;
    _textNode.truncationMode = NSLineBreakByTruncatingTail;
    
    
    /*--------------_titleNode-----------------*/
    _titleNode = [[ASTextNode alloc]init];
    NSMutableParagraphStyle *titleStyle = [[NSMutableParagraphStyle alloc]init];
    titleStyle.lineSpacing = 5;
    titleStyle.paragraphSpacing = 5;
    
    _titleNode.attributedText = [[NSAttributedString alloc]initWithString:string attributes:@{NSForegroundColorAttributeName : [UIColor blackColor] , NSFontAttributeName : [UIFont systemFontOfSize:15]}];
    
    [self addSubnode:_titleNode];
    
    
    /*--------------_weightNode-----------------*/
    _weightNode = [[ASTextNode alloc]init];
    _weightNode.attributedText = [[NSAttributedString alloc]initWithString:@"规格：500geeeeeeeeeeeeeee" attributes:@{NSForegroundColorAttributeName : [UIColor grayColor] , NSFontAttributeName : [UIFont systemFontOfSize:11]}];
    
    [self addSubnode:_weightNode];
    
    
    /*--------------_salesNode-----------------*/
    _salesNode = [[ASTextNode alloc]init];
    _salesNode.attributedText = [[NSAttributedString alloc]initWithString:@"销量：1000" attributes:@{NSForegroundColorAttributeName : [UIColor grayColor] , NSFontAttributeName : [UIFont systemFontOfSize:11]}];
    
    [self addSubnode:_salesNode];
    
    
    /*--------------_priceNode-----------------*/
    _priceNode = [[ASTextNode alloc]init];
    
    NSString *price = @"￥1.00/包";
    
    NSMutableAttributedString *priceAtt = [[NSMutableAttributedString alloc]initWithString:price];
    [priceAtt addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11] , NSForegroundColorAttributeName :UIColorFromRGB(0x7c7c7c)} range:NSMakeRange(0, price.length)];
    [priceAtt addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18.0] , NSForegroundColorAttributeName : UIColorFromRGB(0xff5c01) , } range:[price rangeOfString:@"1.00"]];
    //NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle)  删除线
    
    _priceNode.attributedText = priceAtt;
    
    [self addSubnode:_priceNode];
    
    
    __block float p = self.progress = (arc4random() % (86 - 1 + 1)+ 1) / 86.0;
    _progressNode = [[ASDisplayNode alloc]initWithViewBlock:^UIView * _Nonnull{
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 86, 7)];
        
        view.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0];
        
        
        UIView *progress = [[UIView alloc]initWithFrame:CGRectMake(0, 0, p * 86 , CGRectGetHeight(view.frame))];
        progress.backgroundColor = [UIColor blueColor];
        
        
        CAGradientLayer *layer = [CAGradientLayer layer];
        layer.frame = progress.frame;
        layer.startPoint = CGPointMake(0, 0 );
        layer.endPoint = CGPointMake(1, 1);
        layer.colors = @[(__bridge id)[UIColor colorWithRed:2/255.0 green:222/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:136/255.0 green:82/255.0 blue:254/255.0 alpha:1.0].CGColor];
        layer.locations = @[@(0.0),@(1.0)];
        
        layer.cornerRadius = view.layer.cornerRadius = progress.layer.cornerRadius = 4.3;
        
        [view addSubview:progress];
        [progress.layer addSublayer:layer];
        
        return view;
        
    }];
    //    [self addSubnode:_progressNode];
    
    _progressTextNode = [[ASTextNode alloc]init];
    NSString *progressStr = [NSString stringWithFormat:@"已抢购%.f%%", self.progress * 100];
    _progressTextNode.attributedText = [[NSAttributedString alloc]initWithString:progressStr attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Regular" size: 9],NSForegroundColorAttributeName: [UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:1.0]}];
    
    //    [self addSubnode:_progressTextNode];
    
    __block BOOL canSelect = !(self.progress == 1.0);
    
    
    ASButtonNode *btn = [[ASButtonNode alloc]init];
    btn.style.preferredSize = CGSizeMake(71, 25);
    btn.backgroundColor =  canSelect ? [UIColor colorWithRed:245/255.0 green:109/255.0 blue:35/255.0 alpha:1.0] : [UIColor grayColor];
    
    btn.cornerRadius = btn.style.preferredSize.height / 2.0;
    _buyNode = btn;

    
    [_buyNode addTarget:self action:@selector(buyAction:) forControlEvents:ASControlNodeEventTouchUpInside];
    
    _buyNode.enabled = canSelect;
    
    [_buyNode setTitle:@"立即加购" withFont:[UIFont fontWithName:@"PingFang-SC-Medium" size: 12] withColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_buyNode setTitle:@"已售空" withFont:[UIFont fontWithName:@"PingFang-SC-Medium" size: 12] withColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    
    [self addSubnode:_buyNode];
    
    NSArray *numbers = @[@"100" , @"200"];
    
    
    ASDisplayNode *n = [[ASDisplayNode alloc]initWithViewBlock:^UIView * _Nonnull{


        UIView *v = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imageNode.frame) + 5, CGRectGetMaxY(self.salesNode.frame) + 5 , kMainScreen_width - 100 - 80 - 15 * 3, 30 * numbers.count)];
        v.backgroundColor = [UIColor whiteColor];

        for (int i = 0;  i < arc4random() % 2 + 1; i++) {
            LittleView *lv = [[LittleView alloc]initWithFrame:CGRectMake(0, i * 30, v.frame.size.width, 30)];
            [v addSubview:lv];
            lv.numberTextField.delegate = self;

            lv.priceLabel.text = numbers[i];
            
//            @weakify(self);
            [[lv.minusBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//                @strongify(self);
                
                if (lv.numberTextField.text.integerValue <= 1) {
                    NSLog(@"已经最少了");
                } else {
                    
                    lv.numberTextField.text = [NSString stringWithFormat:@"%ld" , lv.numberTextField.text.integerValue - 1];
                }
                
                
            }];
            
            [[lv.addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//                @strongify(self);
//                lv.numberLabel.text = [NSString stringWithFormat:@"%ld" , lv.numberLabel.text.integerValue + 1];
                NSLog(@"--------%@" , lv.numberTextField.text);
                lv.numberTextField.text = [NSString stringWithFormat:@"%ld" , lv.numberTextField.text.integerValue + 1];
                self.m.n = lv.numberTextField.text;
            }];
        }


        return v;
    }];

    
    _numberNode = n;
    [self addSubnode:_numberNode];
    _numberNode.hidden = self.m.isSelect.boolValue ? NO : YES;
    _priceNode.hidden = _buyNode.hidden = self.m.isSelect.boolValue;
    
    
    
}
    

- (void)buyAction:( ASButtonNode *)sender {
    
    sender.selected = !sender.selected;

    _priceNode.hidden = _buyNode.hidden = YES;
    _numberNode.hidden = !sender.selected;
//
    self.m.isSelect = @"1";
    
    if (_buyAction) {
        _buyAction(self.text);
    }
    
    
    
}



- (void)layoutDidFinish {
    [super layoutDidFinish];
    
    self.imageNode.URL = [self imageURL];
    
   
}

- (NSURL *)imageURL {
 
    NSString *imageURLString = @"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2276391059,2676039382&fm=26&gp=0.jpg";
    return [NSURL URLWithString:imageURLString];
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    //布局1：图片为背景 文字在图片之上并且居中
//    ASWrapperLayoutSpec *wrapperSpec = [ASWrapperLayoutSpec wrapperWithLayoutElement:_imageNode];
//    ASCenterLayoutSpec *centerSpec = [ASCenterLayoutSpec centerLayoutSpecWithCenteringOptions:ASCenterLayoutSpecCenteringXY sizingOptions:ASCenterLayoutSpecSizingOptionDefault child:_textNode];
//    ASOverlayLayoutSpec *overSpec = [ASOverlayLayoutSpec overlayLayoutSpecWithChild:wrapperSpec overlay:centerSpec];
//    ASBackgroundLayoutSpec *backSpec = [ASBackgroundLayoutSpec backgroundLayoutSpecWithChild:centerSpec background:wrapperSpec];
    // ASOverlayLayoutSpec/ASBackgroundLayoutSpec 的作用：用于组合两个 Element。 在这里 两个效果相同
    
//    return backSpec;
    
    
    //布局2： 左边图片 右边文字
//    self.imageNode.style.preferredSize = CGSizeMake(100, 100);
//    self.textNode.style.preferredSize = CGSizeMake(kMainScreen_width - 100 - 15 * 3, 100);
//
//
//    //水平方向 ：从左到右  间隔15 垂直都居中
//    ASStackLayoutSpec *stackSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal  //水平方向
//                                                                           spacing:15     //  间隔15
//                                                                    justifyContent:ASStackLayoutJustifyContentStart //从左到右
//                                                                        alignItems:ASStackLayoutAlignItemsCenter  //垂直都居中
//                                                                          children:@[self.imageNode , self.textNode]];
//
//
//    //周围边距
//    ASInsetLayoutSpec *insetLayoutSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(15, 15, 15, 15)//上 左 下 右
//                                                                                child:stackSpec];
//
//    return insetLayoutSpec;
    
    
    self.imageNode.style.preferredSize = CGSizeMake(80, 80);
    self.titleNode.style.preferredSize = CGSizeMake(kMainScreen_width- 80 - 15 * 3, [BaseServiceTool textHeightWithText:_text font:[UIFont systemFontOfSize:15.0] width:kMainScreen_width- 80 - 15 * 3]);
    self.progressNode.style.preferredSize = CGSizeMake(86, 7);
    self.buyNode.style.preferredSize = CGSizeMake(71, 25);
    
//    self.numberNode.style.preferredSize = CGSizeMake(kMainScreen_width - 100- 15 * 3, 40);
//    self.numberNode.frame = CGRectMake(CGRectGetMaxX(self.imageNode.frame) + 8, CGRectGetMaxY(self.salesNode.frame) + 8, kMainScreen_width - 100 - 80 - 15 * 3,30 * 2);//
    
    self.numberNode.style.preferredSize = self.m.isSelect.boolValue ? CGSizeMake(kMainScreen_width - 100 - 80 - 15 * 3, 30 * 2) : CGSizeZero;
    

    
//    ASStackLayoutSpec *progressSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
//                                                                              spacing:3
//                                                                       justifyContent:ASStackLayoutJustifyContentStart
//                                                                           alignItems:ASStackLayoutAlignItemsCenter
//                                                                             children:@[_progressNode , _progressTextNode]];
   
    
    ASStackLayoutSpec *bottomSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                                            spacing:20
                                                                    justifyContent:ASStackLayoutJustifyContentSpaceBetween
                                                                         alignItems:ASStackLayoutAlignItemsCenter
                                                                           children:@[_priceNode,  _buyNode]];
    
    
    
    ASCenterLayoutSpec *center =[ASCenterLayoutSpec centerLayoutSpecWithCenteringOptions:ASCenterLayoutSpecCenteringXY
                                                                           sizingOptions:ASCenterLayoutSpecSizingOptionDefault
                                                                                   child:bottomSpec];
    
    
    ASStackLayoutSpec *vSpec = vSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                                                               spacing:8
                                                                        justifyContent:ASStackLayoutJustifyContentStart
                                                                            alignItems:ASStackLayoutAlignItemsStart
                                                                              children:@[_titleNode , _weightNode,_salesNode,_numberNode, center]];
    
    //!_numberNode.hidden
    if (self.m.isSelect.boolValue) {

        vSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                                        spacing:8
                                                 justifyContent:ASStackLayoutJustifyContentStart
                                                     alignItems:ASStackLayoutAlignItemsStart
                                                       children:@[_titleNode , _weightNode,_salesNode,_numberNode]];


    }
    
    ASStackLayoutSpec *hSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                                       spacing:8
                                                                justifyContent:ASStackLayoutJustifyContentStart
                                                                    alignItems:ASStackLayoutAlignItemsStart
                                                                      children:@[_imageNode , vSpec]];
    
    
    return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(15, 5, 15, 5) child:hSpec];
    
    
}


@end

@interface ASButtonCell ()
@property (nonatomic , copy)NSString *title;
@property (nonatomic , strong) ASButtonNode *button;
@property (nonatomic , assign) NSInteger currentRow;
@property (nonatomic , strong) NSIndexPath *index;


@end

@implementation ASButtonCell

-(instancetype)initWithTitle:(NSString *)title indexPath:(NSIndexPath *)indexPath  currentRow:(NSInteger)currentRow{
    self = [super init];
    if (self) {
        self.title = title;
        self.currentRow = currentRow;
        self.index = indexPath;
        
        [self setUI];
    }
    return self;
}

- (void)configCellWithDic:(NSDictionary *)dic {
    
    self.title = dic[@"title"];
    self.currentRow = [dic[@"currentRow"] integerValue];
    self.index = dic[@"index"];
    [self setUI];
}


- (void)setUI {
    
    
    ASButtonNode *btn = [[ASButtonNode alloc]init];
    
    [self addSubnode:btn];
    
    if (self.index.row == _currentRow) {
        btn.selected = YES;
    }
    [btn setTitle:self.title withFont:[UIFont systemFontOfSize:12.0] withColor:[UIColor grayColor] forState:UIControlStateNormal] ;
    [btn setTitle:self.title withFont:[UIFont systemFontOfSize:12.0] withColor:[UIColor orangeColor] forState:UIControlStateSelected];
   
    _button = btn;
    
    self.button.backgroundColor = self.button.selected ? [UIColor whiteColor] : [UIColor clearColor];
    
}




- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    _button.style.preferredSize = CGSizeMake(80, 40);
    return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsZero child:_button];
}


@end




@implementation LittleView

- (instancetype)initWithFrame:(CGRect)frame open:(BOOL)isOpen{
    self = [super initWithFrame:frame];
    if(self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"LittleView" owner:self options:nil];
        //得到第一个UIView
        self = [nib objectAtIndex:isOpen ? 0 : 1];
        self.frame = frame;
        
        [self setUI];
        
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"LittleView" owner:self options:nil];
        //得到第一个UIView
        self = [nib objectAtIndex:0];
        self.frame = frame;
        
        [self setUI];
        
    }
    return self;
}

- (void)setUI {
//    @weakify(self);
//    [[self.minusBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        @strongify(self);
//
//        if (self.numberLabel.text.integerValue <= 1) {
//            NSLog(@"已经最少了");
//        } else {
//
//            self.numberLabel.text = [NSString stringWithFormat:@"%ld" , self.numberLabel.text.integerValue - 1];
//        }
//    }];
//
//    [[self.addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        @strongify(self);
//
//        self.numberLabel.text = [NSString stringWithFormat:@"%ld" , self.numberLabel.text.integerValue + 1];
//    }];
//
//
//    [[self.buyBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        NSLog(@"bbbb");
//    }];
    
}


@end
