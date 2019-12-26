//
//  ASImageTitltNode.m
//  TextureDemo
//
//  Created by zqp on 2019/3/29.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import "ASImageTitltNode.h"

//static CGFloat kImageSize = Height(40);

@interface ASImageTitltNode ()

@property (nonatomic ,strong) ASTextNode *titleNode;
@property (nonatomic, strong) ASNetworkImageNode *imageNode;
@property (nonatomic , copy) NSString *title;
@property (nonatomic , copy )NSString *imageURL;

@end

@implementation ASImageTitltNode


- (instancetype)initWithImage:(NSString *)image title:(NSString *)title {
    
    self = [super init];
    if (self) {
        
        self.title = title;
        self.imageURL = image ;
        [ self setUI];
    }
    return self;
}


- (void)setUI {
    
    ASNetworkImageNode *image = [[ASNetworkImageNode alloc]init];
    [self addSubnode:image];
    image.URL = [NSURL URLWithString:_imageURL];
    image.contentMode = UIViewContentModeScaleAspectFit;
    _imageNode = image;
    
    ASTextNode *title = [[ASTextNode alloc]init];
    title.attributedText = [[NSAttributedString alloc]initWithString:_title attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Medium" size: 12.0],NSForegroundColorAttributeName: [UIColor colorWithRed:37/255.0 green:37/255.0 blue:37/255.0 alpha:1.0]}];
    [self addSubnode:title];
    _titleNode = title;
    
    
    
    
}


- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    
    _imageNode.style.preferredSize = CGSizeMake(40, 40);
    
    ASStackLayoutSpec *stackSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:8 justifyContent:ASStackLayoutJustifyContentCenter alignItems:ASStackLayoutAlignItemsCenter children:@[_imageNode , _titleNode]];
    return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10, 5, 10, 5) child:stackSpec];
    
}

@end
