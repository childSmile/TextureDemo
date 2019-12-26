//
//  TabViewController.m
//  TextureDemo
//
//  Created by zqp on 2019/5/14.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import "TabViewController.h"
#import "PhotoModel.h"
#import "SalesReturnCell.h"
#import "PhotoCollectionViewCell.h"

CGFloat kItemSpace = 8.0;
NSString * const CaculateTotalAmountNoticefication = @"CaculateTotalAmountNoticefication";//计算退款总金额

@interface TabViewController ()<UITableViewDelegate , UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic , strong) NSArray *arr;
@property (nonatomic, strong) DataSourceModel *viewModel;
@property (nonatomic , strong) NSArray *rowHeightArr;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *view1;//退款原因
@property (weak, nonatomic) IBOutlet UIView *view2;//退款说明
@property (weak, nonatomic) IBOutlet UIView *view3;//照片

@property (weak, nonatomic) IBOutlet UILabel *totalAmountL;//预计退还金额
@property (weak, nonatomic) IBOutlet UITextField *returnTextField;//显示退款原因
@property (weak, nonatomic) IBOutlet UIButton *returnResonBtn;//退款原因
@property (weak, nonatomic) IBOutlet UITextView *textView;//退款说明
@property (strong, nonatomic)  UIView *photoView;

@property (nonatomic , strong) NSMutableArray *imgsArr;//存储选择的照片
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view3HeightCon;//多张照片是需要改变高度

@property (nonatomic , strong) UIImagePickerController *imagePicker;
@property (nonatomic , strong) UICollectionView *collectionView; //选择照片的第二种方法 使用collectionview排列
@property (nonatomic, strong) DataSourceModel *viewModel2;
@property (weak, nonatomic) IBOutlet UIButton *submintButton;


@end

@implementation TabViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.imgsArr = [NSMutableArray array];

    [self setupTableView];
    [self setupPhotoView];
    [self setupBottomViews];

}

- (void)setupPhotoView {
    
    [self.view3 addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(HPX(144)));
        make.left.equalTo(@(kItemSpace));
        make.right.equalTo(@(-kItemSpace));
        make.bottom.equalTo(@(-kItemSpace));
    }];
    
    
    UIView *view = [UIView new];
    [self.view3 addSubview:view];
    
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(kItemSpace));
        make.top.equalTo(@(HPX(140)));
        make.width.equalTo(@(HPX(308)));
//        make.height.equalTo(@(HPX(312)));
        make.bottom.equalTo(@(-kItemSpace));
    }];
    view.backgroundColor = UIColorFromRGB(0xF3F4F8);
    view.layer.cornerRadius = 5;
    
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"拍照"]];
    [view addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view.mas_centerX);
        make.centerY.equalTo(view.mas_centerY).offset(-20);
        make.width.equalTo(@(HPX(104)));
        make.height.equalTo(@(HPX(92)));
    }];
    
    
    UILabel *l = [UILabel new];
    [view addSubview:l];
    [l mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(img.mas_centerX);
        make.top.equalTo(img.mas_bottom).offset(8);
    }];
    l.text = @"上传照片\n(最多六张)";
    l.textAlignment = NSTextAlignmentCenter;
    l.font = HPMZFont(35);
    l.textColor = UIColorFromRGB(0x999999);
    l.numberOfLines = 0;
    
    self.photoView = view;
    
    @weakify(self);
    self.viewModel2 = [[DataSourceModel alloc]initWithCellID:NSStringFromClass([PhotoCollectionViewCell class]) configureCellBlock:^(PhotoCollectionViewCell  * cell, id  _Nonnull item, NSIndexPath * _Nonnull indexPath) {
        @strongify(self);
        UIImage *img = self.imgsArr[indexPath.row];
        [cell configWith:img];
        [cell.deleteSingal subscribeNext:^(id x) {
            [self.imgsArr removeObject:img];
            [self layoutView];
        }];
    }];
    
    self.collectionView.dataSource = self.viewModel2;
    RAC(self.viewModel2,dataSource) = RACObserve(self, imgsArr);
    
}

- (void)setupBottomViews {
    
    self.view1.layer.shadowColor = self.view2.layer.shadowColor = self.view3.layer.shadowColor =[UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:0.27].CGColor;
    self.view1.layer.shadowOffset = self.view2.layer.shadowOffset =self.view3.layer.shadowOffset = CGSizeMake(0,2);
    self.view1.layer.shadowOpacity = self.view2.layer.shadowOpacity = self.view3.layer.shadowOpacity = 1;
    
    self.view1.layer.borderWidth = self.view2.layer.borderWidth =self.view3.layer.borderWidth = 1;
    self.view1.layer.borderColor = self.view2.layer.borderColor = self.view3.layer.borderColor =  [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    self.view1.layer.cornerRadius = self.view2.layer.cornerRadius = self.view3.layer.cornerRadius = HPX(5);
    
    self.view2.userInteractionEnabled = YES;
    @weakify(self);
    [self.view2 addGestureTapEventHandle:^(id sender, UITapGestureRecognizer *gestureRecognizer) {
        @strongify(self);
        [self.textView becomeFirstResponder];
    }];
    
    
    [[self.returnResonBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        NSArray *arr = @[@"错发", @"质量问题",@"日期/年份不符",@"错买", @"漏发",@"漏发"]; //退货原因
        ZGQActionSheetView *sheet = [[ZGQActionSheetView alloc]initWithOptions:arr completion:^(NSInteger index) {
            NSLog(@"sheet select -- %ld" , index);
            self.returnTextField.text = arr[index] ;
        } cancel:^{
            NSLog(@"cancle") ;
        }] ;
        sheet.gap = 0;
        sheet.cancelTitle = @"关闭";
        [sheet show];
    }];
    
    [self.photoView addGestureTapEventHandle:^(id sender, UITapGestureRecognizer *gestureRecognizer) {
        NSLog(@"选择照片");
        //相册
        //选择相册时，设置UIImagePickerController对象相关属性
        @strongify(self);
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //跳转到UIImagePickerController控制器弹出相册
        [self presentViewController:self.imagePicker animated:YES completion:nil];
    }];

    
    [[self.submintButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"提交");
//        for (Goods *g in self.arr) {
//            for (RecordModel *r in g.arr) {
//                NSLog(@"number -- %@ , amount -- %@" , r.totalNumber , r.totalAmount);
//
//            }
//        }
    }];
    
}

- (UIImagePickerController *)imagePicker {
    if (!_imagePicker) {
        UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.editing = YES;
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        _imagePicker = imagePicker;
    }
    return _imagePicker;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *lay = [[UICollectionViewFlowLayout alloc]init];
        lay.minimumLineSpacing = kItemSpace;
        lay.minimumInteritemSpacing = kItemSpace / 2.0;
        CGFloat w = (kMainScreen_width - 4 * 15) / 3.0;
        lay.itemSize = CGSizeMake(w, w);
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:lay];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([PhotoCollectionViewCell class])];
    }
    return _collectionView;
    
}

#pragma mark - imagePickerController delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

    [picker dismissViewControllerAnimated:YES completion:nil];
    //获取到的图片
    UIImage * image = [info valueForKey:UIImagePickerControllerEditedImage];
    [self.imgsArr addObject:image];
    
    // 方法2 ： 使用collectionview 布局mimage
    [self layoutView];
    
    // 方法 1 ： 直接添加imageViews
//    [self addImageViewsIsAll:NO image:image];


}

//布局view3
- (void)layoutView {
    
    [self.collectionView reloadData];
    
    
    CGFloat w = CGRectGetWidth(self.photoView.frame);
    CGFloat h = CGRectGetHeight(self.photoView.frame);
    
    self.view3HeightCon.constant = self.imgsArr.count >= 3 ? HPX(820) : HPX(485);
    
    if (self.imgsArr.count == 6) {
        self.photoView.hidden = YES;
        
    } else {
        self.photoView.hidden = NO;
        [self.photoView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(@(HPX(140) + self.imgsArr.count / 3 * (h + kItemSpace)));
            make.width.equalTo(@(w));
            make.height.equalTo(@(h));
            //三张图的时候 换行
            if (self.imgsArr.count == 3) {
                make.left.equalTo(@(8));
                
            } else {
                make.left.equalTo(@((self.imgsArr.count % 3 + 1) * kItemSpace + (self.imgsArr.count % 3) * w));
            }
            
        }];
    }
    
}

/**
 
 isAll : 是否重新添加所有的imageview ，当删除一张的时候 yes , 当添加一张的时候 no
 image : 添加的那张图片，只有当isAll 为 No 的时候才有用
 **/
- (void)addImageViewsIsAll:(BOOL)isAll image:(UIImage *)image{
    
    
    CGFloat w = CGRectGetWidth(self.photoView.frame);
    CGFloat h = CGRectGetHeight(self.photoView.frame);
    
    if (isAll) {
    
        for (UIView *view in self.view3.subviews) {
            if (view.tag >= 1000) {
                [view removeFromSuperview];
            }
        }
    }
    //当添加一张的时候 只用添加一张
    NSInteger count = isAll ? self.imgsArr.count : 1;
    for (int i = 0; i < count; i++) {
        
        UIImageView *imgV = [[UIImageView alloc]initWithImage: isAll  ? self.imgsArr[i] : image];
        imgV.contentMode = UIViewContentModeScaleAspectFit;
        imgV.layer.cornerRadius = 5;
        imgV.userInteractionEnabled = YES;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [imgV addSubview:btn];
        [btn setBackgroundImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(0));
            make.right.equalTo(@(0));
            make.width.equalTo(@(HPX(72)));
            make.height.equalTo(@(HPX(72)));
        }];
        
        @weakify(self);
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton * x) {
            @strongify(self);
            UIImageView *i = (UIImageView *)x.superview;
            [self.imgsArr removeObject:i.image];

            //删除一张后  重新添加所有的imgview
            [self addImageViewsIsAll:YES image:nil];
            
            
        }];
        
        [self.view3 addSubview:imgV];
        
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(isAll ? @(HPX(144) + i / 3 * (h + kItemSpace)) : @(HPX(144) + (self.imgsArr.count - 1)/ 3 * (h + kItemSpace)));
            make.left.equalTo(isAll  ? @(kItemSpace * (i % 3 + 1) + i % 3  * w) : @((self.imgsArr.count - 1) % 3 * w + kItemSpace * (self.imgsArr.count % 3 == 0 ? 3 : self.imgsArr.count % 3)));
            
            make.width.equalTo(@(w));
            make.height.equalTo(@(h));
        }];
        
        
        imgV.tag = 1000 + i;
        
    }
    
    self.view3HeightCon.constant = self.imgsArr.count >= 3 ? HPX(820) : HPX(485);
    
    if (self.imgsArr.count == 6) {
        self.photoView.hidden = YES;
        
    } else {
        self.photoView.hidden = NO;
        [self.photoView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(@(HPX(144) + self.imgsArr.count / 3 * (h + kItemSpace)));
            make.width.equalTo(@(w));
            make.height.equalTo(@(h));
            //三张图的时候 换行
            if (self.imgsArr.count == 3) {
                make.left.equalTo(@(15));
                
            } else {
                make.left.equalTo(@((self.imgsArr.count % 3 + 1) * kItemSpace + (self.imgsArr.count % 3) * w));
            }
            
        }];
    }
    
    [self.view3 layoutIfNeeded];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
    //    _photoBtn.hidden = NO;
    //    _submitBtn.enabled = NO;
}

- (void)setupTableView {
    
    self.tableView.layer.shadowColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:0.27].CGColor;
    self.tableView.layer.shadowOffset = CGSizeMake(0,2);
    self.tableView.layer.shadowOpacity = 1;
    
    self.tableView.layer.borderWidth = 1;
    self.tableView.layer.borderColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    self.tableView.layer.cornerRadius = HPX(14);
    
    
    NSMutableArray *array2 = [NSMutableArray array];
    NSMutableArray *array3 = [NSMutableArray array];
    for (int j = 0 ;j < 5 ; j++) {
        Goods *m = [Goods new];
        m.title = @"安井包心鱼豆腐安井安井包心鱼豆鱼豆(2.5kg/包)";
        
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < arc4random() % 3 + 1; i++) {
            RecordModel *m = [RecordModel new];
            m.text = @"3/包*2包";
            m.price = @"23.0";
            m.number = @"2";
            m.unit = @"袋";
            [array addObject:m];
        }
        m.arr = array;
        m.buyType = [NSString stringWithFormat:@"%d" , arc4random() % 3];
        [array2 addObject:m];
        
        CGFloat rowH = HPX(230) +  (m.arr.count - 1) * HPX(60);
        [array3 addObject:@(rowH)];
    }
    
    self.arr = [array2 copy];
    self.rowHeightArr = [array3 copy];
    
    //检测退款总额变化
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:CaculateTotalAmountNoticefication object:nil] subscribeNext:^(id x) {
        CGFloat total = 0;
        for (Goods *g in self.arr) {
            total += g.totalAmount.floatValue;
        }
        self.totalAmountL.text = [NSString stringWithFormat:@"￥%.2f" , total];
        
    }];
    
    
    self.viewModel = [[DataSourceModel alloc]initWithCellID:@"cell" configureCellBlock:^(SalesReturnCell * cell, id  _Nonnull item, NSIndexPath * _Nonnull indexPath) {
        Goods *m = self.arr[indexPath.row];
        [cell configItem:m];
        
      
        [[RACSignal merge:[cell.btnSingals copy]] subscribeNext:^(UIButton * btn) {
            NSLog(@"indexpath -- %ld----点击 -- %ld" ,indexPath.row , btn.tag);
            NSArray *arr = @[@"袋", @"箱",@"包"]; //商品对应的单位数组 从model里取
            NSArray *price = @[@"12", @"34",@"40"]; //商品对应的单价数组 从model里取
            NSArray *numbers = @[@"2", @"3",@"4"]; //商品对应的数量数组 从model里取
            ZGQActionSheetView *sheet = [[ZGQActionSheetView alloc]initWithOptions:arr completion:^(NSInteger index) {
                NSLog(@"sheet select -- %ld" , index);
                [btn setTitle:arr[index] forState:UIControlStateNormal];
                RecordModel *rm = m.arr[btn.tag - 1004];
                rm.price = price[index];
                rm.number = numbers[index];
                
                ((UILabel *)[cell viewWithTag:(1005 + btn.tag - 1004)]).text = [NSString stringWithFormat:@"¥ %.f" , [price[index] floatValue] * [numbers[index] floatValue]];
                
            } cancel:^{
               NSLog(@"cancle") ;
            }] ;
            sheet.needCancelButton = NO;
            [sheet show];
            
        }];
        
        
        [[RACSignal merge:[cell.amountSingals copy]] subscribeNext:^(NSString * amount) {
            NSLog(@"amount --- %@" ,amount);
            NSString *amountStr = [amount stringByReplacingOccurrencesOfString:@"￥" withString:@""];
            if (amountStr.floatValue == 0.0) {
                NSLog(@"金额为0");
            } else {
                NSLog(@"999999");
            }
            
        }];
    }];
    
    self.tableView.dataSource = self.viewModel;
    
    RAC(self.viewModel,dataSource) = RACObserve(self, arr);
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return  [self.rowHeightArr[indexPath.row] floatValue];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self.view endEditing:YES];
}

@end
