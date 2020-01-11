//
//  NetWork.h
//  DDLife
//
//  Created by 赵越 on 2019/11/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <Foundation/Foundation.h>

//models
#import "XWUploadedImageModel.h"
NS_ASSUME_NONNULL_BEGIN

extern NSString * const kXWalletBaseInterfaceUrl;

extern NSString * const kWXNetWorkResponsePath;

typedef NS_ENUM(NSUInteger, NetWorkMethod) {
    NetWorkMethodPost,
    NetWorkMethodGet,
};


@interface NetWork : NSObject

+ (AFHTTPSessionManager *_Nonnull)sharedNetwork;

//定义网络请求失败类型
typedef NS_ENUM(NSUInteger, URLResponseStatusEnum)
{
    URLResponseStatusSuccess = 200, // 作为底层，请求是否成功只考虑是否成功收到服务器反馈。至于返回的数据是否完整，由上层的controller来决定。
    URLResponseStatusErrorTimeout, // 超时
    URLResponseStatusErrorNoNetwork, // 默认除了超时以外的错误都是无网络错误
    URLResponseStatusFailed  //请求失败
};



/**
 网络请求封装
 
 @param urlStr              接口地址
 @param version             版本号
 @param requestMethod       请求方式
 @param params              请求参数
 @param completionHandler   请求回调
 */
+ (void)dataTaskWithURLString:(NSString *_Nonnull)urlStr
                      version:(NSInteger)version
                requestMethod:(NSString *_Nonnull)requestMethod
                   parameters:(NSDictionary *_Nullable)params
            completionHandler:(void (^_Nonnull)(NSURLResponse * _Nonnull response, id  _Nullable responseObject, URLResponseStatusEnum error))completionHandler;


/**
 网络请求封装
 
 @param path                接口路径
 @param requestMethod       请求方式
 @param version             版本
 @param params              请求参数
 @param completionHandler   请求回调
 */
+ (void)dataTaskWithPath:(NSString *_Nonnull)path
                requestMethod:(NetWorkMethod)requestMethod
                      version:(NSInteger)version
              parameters:( NSDictionary *_Nullable)params
                mapModelClass:(Class _Nullable)mapModelClass
            responsePath:( NSString* _Nullable )responsePath
            completionHandler:(void (^_Nonnull)(id  _Nullable responseObject, NSError * error))completionHandler;

+ (void)uploadImageWithImage:(UIImage *)image completionHandler:(void (^_Nullable)(XWUploadedImageModel *photo, NSError * error))completionHandler;



@end

NS_ASSUME_NONNULL_END
