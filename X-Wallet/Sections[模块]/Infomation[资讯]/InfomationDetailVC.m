//
//  InfomationDetailVC.m
//  X-Wallet
//
//  Created by mac on 2019/11/22.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "InfomationDetailVC.h"
#import "InfomationBLL.h"
#import <WebKit/WebKit.h>

@interface InfomationDetailVC ()<WKNavigationDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *label0;
@property (strong, nonatomic) WKWebView *wkWebView;


@end

@implementation InfomationDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = AppLanguageStringWithKey(@"资讯详情");
    self.label0.backgroundColorPicker = IXColorPickerWithRGB(0xF4F1FE,0x161E31,0xF4F1FE,0xF4F1FE);
    self.titleLab.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    
    [self loading];
    [[InfomationBLL sharedInfomationBLL] executeTaskWithDic:@{} version:1 requestMethod:NETWORK_TYPE_POST apiUrl:[NSString stringWithFormat:@"articles/news/%@", self.inf_id] onSuccess:^(NSDictionary * _Nonnull resultDic) {
        [self hideLoading];
        
        [self initUIWithDic:resultDic];
    } onNetWorkFail:^(NSString * _Nonnull msg) {
        [self promptMsg:msg];
    } onRequestTimeOut:^{
        [self promptRequestTimeOut];
    }];
    
}

- (void)initUIWithDic:(NSDictionary *)dic {
    
    self.titleLab.text = dic[@"data"][@"title"];
    self.timeLab.text = dic[@"data"][@"created_at"];
    
    
//    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";

    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:@"" injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];

    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    wkWebConfig.userContentController = wkUController;

    // 创建设置对象
    WKPreferences *preference = [[WKPreferences alloc]init];
    // 设置字体大小(最小的字体大小)
    preference.minimumFontSize = 15;
    // 设置偏好设置对象
    wkWebConfig.preferences = preference;
    
    self.wkWebView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:wkWebConfig];
    self.wkWebView.navigationDelegate = self;
    [self.view addSubview:self.wkWebView];
    [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLab.mas_bottom).offset(10);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    [self.wkWebView loadHTMLString:dic[@"data"][@"contents"] baseURL:nil];
}


- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    // 改变网页内容背景颜色
    if ([[IXColorMgr defaultMgr].curVersion isEqualToString:@"white"]) {
        [self.wkWebView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.background='#ffffff'"completionHandler:nil];
    } else {
        [self.wkWebView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.background='#0E1824'"completionHandler:nil];
    NSString *pStr = @"var objs = document.getElementsByTagName('p');\n"
        "for(var i=0; i<objs.length; i++) {\n"
        "objs[i].style.backgroundColor='#0E1824';} \n";
        [self.wkWebView evaluateJavaScript:pStr completionHandler:nil];
    NSString *divStr = @"var objs = document.getElementsByTagName('div');\n"
        "for(var i=0; i<objs.length; i++) {\n"
        "objs[i].style.backgroundColor='#0E1824';} \n";
        [self.wkWebView evaluateJavaScript:divStr completionHandler:nil];
    NSString *spanStr = @"var objs = document.getElementsByTagName('span');\n"
        "for(var i=0; i<objs.length; i++) {\n"
        "objs[i].style.backgroundColor='#0E1824';} \n";
        [self.wkWebView evaluateJavaScript:spanStr completionHandler:nil];
    }
    //改变网页内容文字颜色
    [self.wkWebView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#999999'"completionHandler:nil];
    
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
