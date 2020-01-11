//
//  UIViewController+CommonFunc.h
//  DDLife
//
//  Created by 赵越 on 2019/11/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppLanguageManager.h"



NS_ASSUME_NONNULL_BEGIN

/**
 ViewController常用方法 方便控制器直接调用
 */

@protocol BackButtonHandlerProtocol <NSObject>

@optional
// 重写下面的方法以拦截导航栏返回按钮点击事件，返回 YES 则 pop，NO 则不 pop
- (BOOL)navigationShouldPopOnBackButton;

@end

@interface UIViewController (CommonFunc)<UIGestureRecognizerDelegate,BackButtonHandlerProtocol>

/**
 *  网络请求指示器
 */
- (void)loading;
- (void)lodingMsg:(NSString *)msg;

/**
 *  隐藏网络请求指示器
 */
- (void)hideLoading;


/**
 *  气泡提示
 *
 *  @param msg 提示信息
 */
- (void)promptMsg:(NSString *)msg;

- (void)promptReqSuccess:(NSString *)msg;

/**
 *  气泡提示 with block
 *
 *  @param msg 提示信息
 */
- (void)promptMsg:(NSString *)msg promptCompletion:(void (^)(void))promptCompletion;

- (void)promptReqSuccess:(NSString *)msg promptCompletion:(void (^)(void))promptCompletion;

//气泡提示在UIWindow上
- (void)promptMsgOnWindow:(NSString *)msg;

/**
 *  网络请求超时提示
 */
- (void)promptRequestTimeOut;

/**
 *  网络请求失败提示
 */
- (void)promptNetworkFailed;

/**
 *  显示状态栏的网络请求
 */
- (void)showStatusLoading;

/**
 *  隐藏状态栏的网络请求
 */
- (void)hideStatusLoading;

/**
 *  结束编辑 收起键盘
 */
- (void)addViewEndEditTap;



/**
 获取当前控制器
 */
+ (UIViewController *)currentViewController;

/** 完成登录 */
- (void)completeLoginWithToken:(NSString *)token;

/** 跳转登录 */
- (void)presentLoginVC;

/** 退出登录 */
- (void)logout;

//带输入框的弹窗
- (void)showTextFieldAlertWithHandler:(void(^)(NSString *psd))handler;

//更新提示
- (void)p_showUpdateView;

@end

NS_ASSUME_NONNULL_END
