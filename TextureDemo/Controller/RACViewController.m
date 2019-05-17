//
//  RACViewController.m
//  TextureDemo
//
//  Created by zqp on 2019/4/2.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import "RACViewController.h"
#import "ViewModel.h"
#import "DetialCellNode.h"
#import "DataSourceModel.h"



static float kItemSpace = 0.0;

@interface RACViewController ()<ASCollectionDelegate>

@property (nonatomic , strong) ViewModel *viewModel;
@property (nonatomic , strong) UITextView *textView;
@property (nonatomic , strong) UIButton *button;

@property (nonatomic , strong) DataSourceModel *model;
@property (nonatomic , strong) ASCollectionNode *collectionNode;


@end

@implementation RACViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    self.collectionNode = [[ASCollectionNode alloc]initWithCollectionViewLayout:layout];
    
    layout.minimumLineSpacing = kItemSpace;
    layout.minimumInteritemSpacing = kItemSpace;
    layout.itemSize = CGSizeMake((kMainScreen_width - kItemSpace * 2) / 3.0 , 200);
    
    [self.view addSubnode:self.collectionNode];
    self.collectionNode.frame = self.view.bounds;
    
    
    self.model = [[DataSourceModel alloc]initWithCellID:NSStringFromClass([DetialCellNode class]) configureCellBlock:^(DetialCellNode * cell, id  _Nonnull item, NSIndexPath * _Nonnull indexPath) {
        [cell configCell];
        [cell.carBtn addTarget:self action:@selector(buy:) forControlEvents:ASControlNodeEventTouchUpInside];
    }];
    self.model.dataSource = @[@"abstract在骄傲你", @"animals等我还有", @"business", @"cats", @"city", @"food放不进看到回复", @"nightlife", @"fashion", @"people", @"nature", @"sports", @"technics", @"transport"];
    
    self.collectionNode.delegate = self;
    self.collectionNode.dataSource = self.model;
    
}

- (void)collectionNode:(ASCollectionNode *)collectionNode didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"------");
}

- (void)buy:(ASButtonNode *)sender {
    
    NSLog(@"buy");
}

- (void)bindModel {
    
    
    @weakify(self);
    [[RACObserve(_viewModel, requestStatus) skip:1] subscribeNext:^(NSNumber * x) {
        @strongify(self);
        switch ([x integerValue]) {
            case HTTPReauestStatusBegin:
                //显示菊花 开始请求
                [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                
                break;
            case HTTPReauestStatusEnd:
                //菊花消失 显示数据
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                break;
            case HTTPReauestStatusError :
                //菊花消失 显示错误
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                NSLog(@"error -- %@" , self.viewModel.error.localizedDescription);
                break;
                
            default:
                break;
        }
    }];
    
    //2.
    RAC(self.textView , text) = [[RACObserve(_viewModel, data) skip:1] map:^id(NSDictionary * value) {
        //字典转字符串
        return [BaseServiceTool dicToStr:value];
    }];
    
    // 3.
//    _button.rac_command = self.viewModel.requestData; //如果requestData不需要参数， 可以直接这么写 ，这样写传过去的默认是_button
    [[_button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.viewModel.requestData execute:@"1"];
    }];
    
}


- (void)setUI {
    
//    UITextField *nameText = [[UITextField alloc]initWithFrame:CGRectMake(100, 100, 200, 30)];
//    nameText.placeholder = @"请输入姓名";
//    nameText.borderStyle = UITextBorderStyleRoundedRect;
//    [self.view addSubview:nameText];
//
//    UITextField *pwdText = [[UITextField alloc]initWithFrame:CGRectMake(100, 150, 200, 30)];
//    pwdText.placeholder = @"请输入密码";
//    pwdText.borderStyle = UITextBorderStyleRoundedRect;
//    [self.view addSubview:pwdText];
//
    
    UITextView *t = [UITextView new];
    [self.view addSubview:t];
    t.frame = CGRectMake(10, 10, kMainScreen_width - 10, 200);
    self.textView = t;
    
    
    
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [self.view addSubview:nextBtn];
    
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(t.mas_bottom).offset(100);
        make.width.equalTo(t.mas_width);
        make.height.equalTo(@(40));
        make.left.equalTo(t.mas_left);
    }];
    
    self.button = nextBtn;
    
//    RACSignal *btnSignal = [nextBtn rac_signalForControlEvents:UIControlEventTouchUpInside];
//    [btnSignal subscribeNext:^(id x) {
//        NSLog(@"btn click" );
//    }];
    
    //两个同时有信号 1. combineLatest
//    [[RACSignal combineLatest:@[nameText.rac_textSignal , btnSignal]] subscribeNext:^(RACTuple * x) {
//        NSLog(@"1. %@\n2.%@" , x.first, x.second);
//    }];
    
    //
    
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
