//
//  Config.h
//  DDLife
//
//  Created by 赵越 on 2019/11/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#ifndef Config_h
#define Config_h


//        ------ 静态配置 ------

// 定义网络请求超时时间
#define NETWORKING_TIMEOUT_SECONDS  20.0f
// 气泡提示时间
#define PROMPT_TIME  2.0f
// 轮播图时间
#define CAROUSEL_TIME  5.0f
// 短信倒计时时间为 60s
#define SEND_SMS_CODE_COUNTDOWN  60.0f


// 获取屏幕的宽度及高度
#define SCREEN_WIDTH    ([[UIScreen mainScreen]bounds].size.width)
#define SCREEN_HEIGHT   ([[UIScreen mainScreen]bounds].size.height)


//GET
#define NETWORK_TYPE_GET    @"GET"
//POST
#define NETWORK_TYPE_POST   @"POST"
//PUT
#define NETWORK_TYPE_PUT    @"PUT"


//语言转换
#define Language_Exchang(string)  NSLocalizedString(string, nil)

//手机系统版本
#define CurrentIOSVersion  ([[[UIDevice currentDevice] systemVersion] floatValue])

//判断是否是ipad
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//判断iPhoneX，Xs（iPhoneX，iPhoneXs）
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXsMax
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size)&& !isPad : NO)
//判断iPhoneX所有系列
#define IS_PhoneXAll (IS_IPHONE_X || IS_IPHONE_Xr || IS_IPHONE_Xs_Max)
//导航栏高度
#define NAV_BAR_HEIGHT              (IS_PhoneXAll ? 88.0 : 64.0)
//底部操作栏高度
#define Home_Indicator_HEIGHT       (IS_PhoneXAll ? 34.0 : 0.0)
//状态栏高度
#define STATUS_HEIGHT               ([UIApplication sharedApplication].statusBarFrame.size.height)


//打印Log
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif





#endif /* Config_h */
