//
//  UIViewController+CommonFunc.m
//  DDLife
//
//  Created by 赵越 on 2019/11/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "UIViewController+CommonFunc.h"
#import "PromptUtils.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "BaseTabBarController.h"
#import "UpdateView.h"

@implementation UIViewController (CommonFunc)

#pragma- 网络请求提示器
- (void)loading{
    
    [self endViewEditing];
    [PromptUtils loading];
}

- (void)lodingMsg:(NSString *)msg{
    
    [PromptUtils loadingWithMsg:msg];
}

//结束页面编辑
- (void)endViewEditing
{
    [self.view endEditing:YES];
}

#pragma 隐藏网络请求指示器
- (void)hideLoading {
    
    [PromptUtils hideLoading];
    [self hideStatusLoading];
}

#pragma mark - 气泡提示
//气泡提示
- (void)promptMsg:(NSString *)msg{
    
    [self hideStatusLoading];
    [self.view endEditing:YES];
    [PromptUtils promptMsg:msg];
}

//气泡提示 with block
- (void)promptMsg:(NSString *)msg promptCompletion:(void (^)(void))promptCompletion{
    
    [self hideStatusLoading];
    
    [PromptUtils promptMsg:msg promptCompletion:^{
        promptCompletion();
    }];
    
}

- (void)promptMsgOnWindow:(NSString *)msg{
    
    [self hideStatusLoading];
    [self.view endEditing:YES];
    
    [PromptUtils promptMsg:msg];
}

- (void)promptReqSuccess:(NSString *)msg{
    
    [PromptUtils promptSuccess:msg promptCompletion:^{}];
    
}

- (void)promptReqSuccess:(NSString *)msg promptCompletion:(void (^)(void))promptCompletion{
    
    [self hideStatusLoading];
    [PromptUtils promptSuccess:msg promptCompletion:^{
        promptCompletion();
    }];
    
}

//请求超时
- (void)promptRequestTimeOut{
    
    [self hideStatusLoading];
    [self promptMsg:TIP_NETWORK_TIMEOUT];
    
}

//网络请求失败
- (void)promptNetworkFailed{
    
    [self promptMsg:TIP_NETWORK_NO_CONNECTION];
}

#pragma mark - 状态栏网络请求
//显示状态栏网络请求
- (void)showStatusLoading{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

//隐藏状态栏网络请求
- (void)hideStatusLoading{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}


- (void)addViewEndEditTap{
    
    //点击空白处取消编辑状态
    UITapGestureRecognizer *TapGesturRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endViewEditing)];
    TapGesturRecognizer.delegate = self;
    TapGesturRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:TapGesturRecognizer];
}


+ (UIViewController*)currentViewController {
    
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (1) {
        
        if ([vc isKindOfClass:[UITabBarController class]]) {
            
            vc = ((UITabBarController*)vc).selectedViewController;
            
        }
        
        if ([vc isKindOfClass:[UINavigationController class]]) {
            
            vc = ((UINavigationController*)vc).visibleViewController;
            
        }
        
        if (vc.presentedViewController) {
            
            vc = vc.presentedViewController;
            
        }else{
            
            break;
        }
        
    }
    
    return vc;
}


- (void)completeLoginWithToken:(NSString *)token {
    
    [UserData saveToken:token];
    AppDelegate *appDelegate = (AppDelegate *)([UIApplication sharedApplication].delegate);
    [appDelegate setRootViewController];
    
}

- (void)presentLoginVC {
    
    LoginViewController *login = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginViewController"];
    BaseNavigationController *loginNavi = [[BaseNavigationController alloc] initWithRootViewController:login];
    
    [[UIViewController currentViewController] presentViewController:loginNavi animated:YES completion:^{
        
    }];
}

- (void)logout {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:AppLanguageStringWithKey(@"提示") message:AppLanguageStringWithKey(@"是否确定退出") preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *done = [UIAlertAction actionWithTitle:AppLanguageStringWithKey(@"确定") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [UserData removeTokenAndPhone];
        AppDelegate *appDelegate = (AppDelegate *)([UIApplication sharedApplication].delegate);
        [appDelegate setRootViewController];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:AppLanguageStringWithKey(@"取消") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:done];
    [alert addAction:cancel];
    
    [[UIViewController currentViewController] presentViewController:alert animated:YES completion:^{
    }];
    
}

- (void)showTextFieldAlertWithHandler:(void(^)(NSString *psd))handler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:AppLanguageStringWithKey(@"提示") message:AppLanguageStringWithKey(@"请输入支付密码") preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:AppLanguageStringWithKey(@"取消") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:AppLanguageStringWithKey(@"确定") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        //获取第1个输入框；
        UITextField *tf = alert.textFields.firstObject;
        if (!tf.text.length) {
            [self promptMsg:AppLanguageStringWithKey(@"请输入支付密码")];
        } else {
            if (handler) {
                handler(tf.text);
            }
        }

    }]];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {

        textField.placeholder = AppLanguageStringWithKey(@"请输入支付密码");

        textField.secureTextEntry = YES;

    }];
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

- (void)p_showUpdateView {
    
    NSString *currentVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    [NetWork dataTaskWithPath:@"app_update" requestMethod:NetWorkMethodPost version:0 parameters:nil mapModelClass:nil responsePath:kWXNetWorkResponsePath completionHandler:^(id  _Nullable responseObject, NSError * _Nonnull error) {

        if (error) {
            [self promptMsg:error.localizedDescription];
        }
        else {
            NSString *iosVersion = responseObject[@"ios_version"];
            if ([currentVersion compare:iosVersion]==NSOrderedAscending) {
                //需要更新
                [UpdateView showUpdateViewWithVersion:iosVersion content:responseObject[@"desc"] block:^{
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:responseObject[@"ios_url"]]];
                }];
            }
            
        }
    }];
}

@end


@implementation UINavigationController (ShouldPopOnBackButton)

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    
    if([self.viewControllers count] < [navigationBar.items count]) {
        return YES;
    }
    
    BOOL shouldPop = YES;
    UIViewController* vc = [self topViewController];
    if([vc respondsToSelector:@selector(navigationShouldPopOnBackButton)]) {
        shouldPop = [vc navigationShouldPopOnBackButton];
    }
    
    if(shouldPop) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self popViewControllerAnimated:YES];
        });
    } else {
        // 取消 pop 后，复原返回按钮的状态
        for(UIView *subview in [navigationBar subviews]) {
            if(0. < subview.alpha && subview.alpha < 1.) {
                [UIView animateWithDuration:.25 animations:^{
                    subview.alpha = 1.;
                }];
            }
        }
    }
    return NO;
}

@end
