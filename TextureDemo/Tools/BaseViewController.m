//
//  BaseViewController.m
//  TextureDemo
//
//  Created by zqp on 2019/4/15.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseNavigationBar.h"
#import "GraphView.h"
#import "AlertView.h"
#import "MyView.h"
#import "Province.h"

#import "TabViewController.h"

@interface BaseViewController ()<UIPickerViewDelegate , UIPickerViewDataSource , UITextFieldDelegate>

@property (nonatomic , strong) BaseNavigationBar *navigationBar;
@property (nonatomic , strong) AlertView *alert;

@property (nonatomic , strong) UIDatePicker *datePickView;
@property (nonatomic , strong) UIPickerView *pickView;
@property (nonatomic , strong) NSArray *dataArr;
@property (nonatomic , strong) NSArray *dataArr2;
@property (nonatomic , assign) NSInteger currentRow;//选中行
@property (weak, nonatomic) IBOutlet UITextField *birthTextField;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;

@property (nonatomic , strong) NSMutableArray *provinces;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavgationBar];
    
    [self setupUI];
    
    // Do any additional setup after loading the view.
}

- (UINavigationBar *)navigationBar {
    if (!_navigationBar) {
        _navigationBar = [[BaseNavigationBar alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_width + StatusHeight,   NavigationHeight)];
        
    }
    return _navigationBar;
    
}


- (void)setupNavgationBar {
    
    [self.view addSubview:self.navigationBar];
    _navigationBar.barTintColor = UIColorFromRGB(0xffffff);
    
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = self.navigationBar.frame;
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:238/255.0 green:114/255.0 blue:135/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:255/255.0 green:175/255.0 blue:126/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0.0),@(1.0f)];
    
    [self.navigationBar.layer insertSublayer:gl atIndex:0];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    
    
    self.navigationBar.title = @"nav封装测试";
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    TabViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([TabViewController class])];
    [self presentViewController:[[UINavigationController alloc]initWithRootViewController:vc] animated:YES completion:nil];
    
    /*
    
    UIView *view = [[UIView alloc]initWithFrame:kWINDOW.bounds];
    view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [kWINDOW addSubview:view];
    view.userInteractionEnabled = YES;
   
    NSDictionary *dic = @{@"title" : @"通知，关于退货事宜" ,
                          @"time" : @"2019.4.23" ,
                          @"content" :@"这里是内容这里是内容这里是内容这里是内这里是内容这里是内容这里是内容这里是内这里是内容这里是内容这里是内容这里是内这里是内容这里是内容这里是内容这里是内容这里是内这里是内容这里是内容这里是内容这里是内这里是内容这里是内容这里是内容这里是内这里是内容这里是内容这里是内容这里是内容这里是内这里是内容这里是内容这里是内容这里是内这里是内容这里是内容这里是内容这里是内这里是内容这里是内容这里是内容这里是内容这里是内这里是内容这里是内容这里是内容这里是内这里是内容这里是内容这里是内容这里是内这里是内容这里是内容这里是内容这里是内容这里是内这里是内容这里是内容这里是内容这里是内这里是内容这里是内容这里是内容这里是内这里是内容这里是内容这里是内容这里是内容这里是内这里是内容这里是内容这里是内容这里是内这里是内容这里是内容这里是内容这里是内这里是内容",
                          };
    
    [kWINDOW addSubview:self.alert];
    [self.alert mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
        make.width.equalTo(@(HPX(863)));
        make.height.equalTo(@(HPX(1114)));
    }];
    
    [self.alert setupUIWithData:dic];
    @weakify(self);
    [self.alert.singal subscribeNext:^(id x) {
        @strongify(self);
        [self.alert removeFromSuperview];
        [view removeFromSuperview];
    }];
    
    [view addGestureTapEventHandle:^(id sender, UITapGestureRecognizer *gestureRecognizer) {
        @strongify(self);
        [self.alert removeFromSuperview];
        [gestureRecognizer.view removeFromSuperview];
    }];
     */
    
    /*
    [kWINDOW addSubview:self.datePickView];
    
    [[self.datePickView rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(UIDatePicker * x) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"yyyy-MM-dd";
        NSString *date = [formatter stringFromDate:x.date];
        NSLog(@"datePickView----%@" , date);
    }];
    */
    
    
   
    
    
    
}

- (void)configDatePickView {
    UIView *view = [[UIView alloc]initWithFrame:kWINDOW.bounds];
    view.backgroundColor = [UIColor clearColor];
    [kWINDOW addSubview:view];
    view.userInteractionEnabled = NO;
    
    
    [kWINDOW addSubview:self.datePickView];
    @weakify(self);
    [[self.datePickView rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(UIDatePicker * x) {
        @strongify(self);
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"yyyy-MM-dd";
        NSString *date = [formatter stringFromDate:x.date];
        NSLog(@"datePickView----%@" , date);
        self.birthTextField.text = date;
        
        [self.datePickView removeFromSuperview];
        [view removeFromSuperview];
    }];
    
    self.birthTextField.inputView = self.datePickView;
}


- (void)configPickView {
    
    UIView *view = [[UIView alloc]initWithFrame:kWINDOW.bounds];
    view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [kWINDOW addSubview:view];
    view.userInteractionEnabled = YES;
    
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, kMainScreen_height - HPX(747), kMainScreen_width, kMainScreen_height - HPX(747))];
    [kWINDOW addSubview:v];
    
    v.backgroundColor = UIColorFromRGB(0xf6f6f6);
    TitleView *titleV = [[TitleView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_width, HPX(127))];
    @weakify(self);
    [[titleV.cancleButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        NSLog(@"cancle -- %@" , self.pickView);
        
        [self.pickView removeFromSuperview];
        [v removeFromSuperview];
        [view removeFromSuperview];
    }];
    
    [[titleV.confirmButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        NSLog(@"comfirm -- %@" , self.dataArr[self.currentRow]) ;
        
        NSInteger cityIndex = [self.pickView selectedRowInComponent:1];
        Province *p = self.provinces[self.currentRow];
        
        self.cityTextField.text =  [NSString stringWithFormat:@" %@ - %@" , p.name , p.cities[cityIndex]];
        [self.pickView removeFromSuperview];
        [v removeFromSuperview];
        
        [view removeFromSuperview];
    }];
    
    
    [v addSubview:self.pickView];
    [v addSubview:titleV];
    [self.pickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleV.mas_bottom);
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(-HPX(361)));
    }];
    
    
    
    self.pickView.dataSource = self;
    self.pickView.delegate = self;
    
    self.dataArr = [NSArray array];
    self.dataArr2 = [self.provinces copy];
    
    self.cityTextField.inputView = self.pickView;
    
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (textField == _birthTextField) {
        [self configDatePickView];
    } else if (textField == _cityTextField) {
        [self configPickView];
    }
    
}


/**
 *  是否允许用户输入文字
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return NO;
}


#pragma mark - UIPickerView delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (component == 0) {
        return self.provinces.count;
    }
    Province *p = self.provinces[_currentRow];
    return p.cities.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {

    if (component == 0) {
        Province *p = self.provinces[row];
        return p.name;
    } else {
        Province *p = self.provinces[_currentRow];
        return p.cities[row];
    }


}
// 设置PickerView分割线属性&字体属性
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
//{
//
//    // 设置分割线的颜色
//    for(UIView *singleLine in pickerView.subviews)
//    {
//        if (singleLine.frame.size.height < 1)
//        {
//            singleLine.backgroundColor = UIColorFromRGB(0xc3c3c3);
//        }
//    }
//
//    // 设置文字的属性
//
//    UILabel *pickerLabel = [[UILabel alloc] init];
//    pickerLabel.textAlignment = NSTextAlignmentCenter;
//    pickerLabel.textColor = [UIColor blackColor];
//    pickerLabel.font = [UIFont systemFontOfSize:18];
//    if (component == 0) {
//        Province *p = self.dataArr2[row];
//        pickerLabel.text = p.name;
//    } else {
//        Province *p = self.dataArr[_currentRow];
//        pickerLabel.text = p.cities[row];
//    }
//    // pickerLabel.font = [UIFont boldSystemFontOfSize:30];// ------加粗字体
//
//    return pickerLabel;
//}

//返回指定列的宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == 0) {
        return kMainScreen_width / 3.0;
    }
    return kMainScreen_width * 2 / 3.0;

}

//显示的标题字体、颜色等属性
// 与  - (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view  不能同时使用 否则失效
/*
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:self.dataArr2[row] attributes:@{NSForegroundColorAttributeName : [UIColor grayColor]}];
        return str;
    }
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:self.dataArr[row] attributes:@{NSForegroundColorAttributeName : [UIColor redColor]}];
    return str;
}
 */

//被选择的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
        _currentRow = [pickerView selectedRowInComponent:0];
        [pickerView reloadComponent:1];
    }
    Province *p = self.provinces[_currentRow];
    self.dataArr = p.cities;
    
//    NSLog(@"select -- %@" , self.dataArr[row]);

    
}


#pragma mark - 懒加载
- (UIPickerView *)pickView {
    
    if (!_pickView) {
        _pickView = [[UIPickerView alloc]init];
        _pickView.backgroundColor = [UIColor whiteColor];

        
    }
    return _pickView;
    
    
}

- (UIDatePicker *)datePickView {
    if (!_datePickView) {
        _datePickView = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, kMainScreen_height - 200, kMainScreen_width, 200)];
        _datePickView.datePickerMode = UIDatePickerModeDate;
        _datePickView.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];//显示h中文
        _datePickView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];;
        
    }
    return _datePickView;
}

- (AlertView *)alert {
    if (!_alert) {
//        AlertView *v = [[AlertView alloc]init];
        
        //获得nib视图数组
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"AlertView" owner:self options:nil];
        //得到第一个UIView
        AlertView * v = [nib objectAtIndex:0];
        
        _alert = v;
        
    }
    return _alert;
}

- (NSMutableArray *)provinces {
    
    if (!_provinces) {
        _provinces = [NSMutableArray array];
        NSString *filePath = [[NSBundle mainBundle]pathForResource:@"Province" ofType:@"plist"];
        NSArray *data = [NSArray arrayWithContentsOfFile:filePath];
        for (NSDictionary *dic in data) {
            Province *p = [Province provinceWithDic:dic];
            [_provinces addObject:p];
        }
    
    }
    return _provinces;
    
}



- (void)setupUI {
   
    
    self.birthTextField.delegate = self;
    self.cityTextField.delegate = self;
    
}

- (void)back:(UIBarButtonItem *)item {
    
    NSLog(@"back ");
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
