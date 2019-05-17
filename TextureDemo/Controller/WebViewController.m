//
//  WebViewController.m
//  TextureDemo
//
//  Created by zqp on 2019/4/12.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>

@interface WebViewController ()<WKUIDelegate , WKScriptMessageHandler , WKNavigationDelegate>

@property (nonatomic , strong) WKWebView *webview;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    [self.view addSubview:self.webview];
    
    
    [self setNav];
    
    
}

- (void)setNav {
 
    UIBarButtonItem *rig = [[UIBarButtonItem alloc]initWithTitle:@"oc调用js" style:UIBarButtonItemStyleDone target:self action:@selector(ocToJS)];
    self.navigationItem.rightBarButtonItem = rig;
}

#pragma mark - oc 调用js
- (void)ocToJS {
    
    //changeColor  是 js 的方法名
    NSString *js = [NSString stringWithFormat:@"changeColor('%@')" , @"js参数"];
    [_webview evaluateJavaScript:js completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        NSLog(@"改变html的背景色");
    }];
    
    
    
    //改变字体大小  调用原生js方法
    NSString *jsFont = [NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust='%d%%'" , arc4random()%99 + 100];
    [_webview evaluateJavaScript:jsFont completionHandler:nil];
    
    
}

- (WKWebView *)webview {
    if (!_webview) {
        //创建网页配置对象
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
        //创建设置对象
        WKPreferences *preference = [[WKPreferences alloc]init];
        preference.minimumFontSize = 0;
        preference.javaScriptEnabled = YES;//是否支持javaScript 默认支持
        
        //在iOS上默认NO ， 标识是否允许不经过用户交互由javaScript自动打开窗口
        preference.javaScriptCanOpenWindowsAutomatically = YES;
        config.preferences = preference;
        
        //是使用h5的视频播放器在线播放，还是使用原生的播放器全屏播放
        config.allowsInlineMediaPlayback = YES;
        
        //设置视频是否需要用户手动播放 设置为NO则会允许自动播放
//        config.requiresUserActionForMediaPlayback = YES;
        
        WKUserContentController *userContentController = [[WKUserContentController alloc]init];
        
        //注册一个name为jsToOcNoPrams的js方法
        [userContentController addScriptMessageHandler:self name:@"jsToOcNoPrams"];
        [userContentController addScriptMessageHandler:self name:@"jsToOcWithPrams"];
        config.userContentController = userContentController;
        
        //适配文本大小
        NSString *jsStr = @"var meta = document.createElement('meta');meta.setAttribute('name','viewport');meta.setAttribute('content','width=device-width');document.getElementsByTagName('head')[0].appendChild(meta);";
        
        //用于进行JavaScript注入
        WKUserScript *wkUScript = [[WKUserScript alloc]initWithSource:jsStr injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        [config.userContentController addUserScript:wkUScript];
        
        
        _webview = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_width, kMainScreen_height) configuration:config];
        // UI 代理
        _webview.UIDelegate = self;
        //导航代理
        _webview.navigationDelegate = self;
        //是否u允许手势左滑返回上一级，类似导航控制的左滑返回
        _webview.allowsBackForwardNavigationGestures = YES;
        
        //k可返回的页面列表，存储一打开过的网页
//        WKBackForwardList *backForwardList = [_webview backForwardList];
        
    
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"JStoOC.html" ofType:nil];
        NSString *htmlStr = [[NSString alloc]initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        [_webview loadHTMLString:htmlStr baseURL:nil];
        
    }
    return _webview;
}

/**
  WKNavigationDelegate  主要处理一些跳转、加载处理操作
  WKUIDelegate 主要处理JS脚本，确认框，警告框等等
  WKScriptMessageHandler  主要处理js调用oc方法的一些处理
 
 **/

#pragma mark - WKScriptMessageHandler

//js调用oc方法，在此方法中截取
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"message -- %@" , message.body);
    if ([message.name isEqualToString:@"jsToOcNoPrams"]) {
        NSLog(@"JS调用了OC的方法 没有参数");
    } else if ([message.name isEqualToString:@"jsToOcWithPrams"]) {
        NSDictionary *dic = message.body;
        NSLog(@"JS调用了OC的方法 有参数 -- %@" , dic[@"params"]);
    }
    
}

#pragma mark - WKNavigationDelegate
//页面开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
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
