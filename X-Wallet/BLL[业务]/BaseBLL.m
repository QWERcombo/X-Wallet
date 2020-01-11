//
//  BaseBLL.m
//  DDLife
//
//  Created by 赵越 on 2019/11/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseBLL.h"

@implementation BaseBLL

#pragma mark--根据不同类型进行网络请求
- (void)executeTaskWithDic:(NSDictionary *)requestDic
                   version:(NSInteger)version
             requestMethod:(NSString *)requestMethod
                    apiUrl:(NSString *)apiUrl
                 onSuccess:(onSuccess)onSuccess
             onNetWorkFail:(onNetWorkFail)onNetWorkFail
          onRequestTimeOut:(onRequestTimeOut)onRequestTimeOut{
    
    [NetWork dataTaskWithURLString:apiUrl
                           version:version
                     requestMethod:requestMethod
                        parameters:requestDic
                 completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, URLResponseStatusEnum error) {
        
        //请求超时
        if (error == URLResponseStatusErrorTimeout) {
            onRequestTimeOut();
            return;
        }
        //网络请求失败
        if (error == URLResponseStatusErrorNoNetwork) {
            if (responseObject) {
                
                onNetWorkFail(responseObject[@"message"]);
            } else {
                onNetWorkFail(TIP_NETWORK_NO_CONNECTION);
            }
            return;
        }
        
        if (responseObject == nil) {
            
            onNetWorkFail(TIP_RESPONSE_DATA_ERR);
            return;
        }
        //请求成功
        onSuccess(responseObject);
        
    }];
    
}



#pragma mark--AFN图片上传(文件)
- (void)uploadWithapiUrl:(NSString *)apiUrl
                 version:(NSInteger)version
                imageArr:(NSArray *)imageArr
                 nameArr:(NSArray *)nameArr
                  parDic:(NSDictionary *)parDic
           uploadSuccess:(void (^)(id responseObject))uploadSuccess
           onNetWorkFail:(onNetWorkFail)onNetWorkFail
        onRequestTimeOut:(onRequestTimeOut)onRequestTimeOut {
    
    AFHTTPSessionManager *manager = [NetWork sharedNetwork];
    manager.requestSerializer.timeoutInterval = NETWORKING_TIMEOUT_SECONDS;
    
//    [manager.requestSerializer setValue:NETWORK_HEADER_VERSION(version) forHTTPHeaderField:@"Accept"];
    
    
    //请求网络数据,获取个人信息
    [manager POST:apiUrl parameters:parDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // formData: 专门用于拼接需要上传的数据(AFN文件上传)
        /*
         Data: 需要上传的数据
         name: 服务器参数的名称
         fileName: 文件名称
         mimeType: 文件的类型
         */
        for (UIImage *image in imageArr) {
            
            NSData *data = UIImageJPEGRepresentation(image, 1.0);
            [formData appendPartWithFileData:data name:[nameArr objectAtIndex:[imageArr indexOfObject:image]] fileName:@"image" mimeType:@"image/jpeg"];//png或者jpg]图片 路径 名称和类型
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         if ([responseObject isKindOfClass:[NSData class]]) {
             NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
             NSLog(@"++++%@", dict);
             uploadSuccess(dict);
         }
         else
         {
             uploadSuccess(responseObject);
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         
         if (error.code == NSURLErrorTimedOut) {
             onRequestTimeOut();
         }
         else{
             onNetWorkFail(TIP_NETWORK_NO_CONNECTION);
         }
     }];
    
    
}


- (void)analyseResult:(NSDictionary *)resultDic
           bllSuccess:(bllSuccess)bllSuccess
            bllFailed:(bllFailed)bllFailed{
    
    NSString *code = [NSString stringWithFormat:@"%@", [resultDic objectForKey:@"err_code"]];
    NSString *rspMsg = [resultDic objectForKey:@"err_info"];
    
    
    if ([code isEqualToString:RSP_SUCCESS]) {
        //成功的回调
        bllSuccess();
        
    } else {
        //失败回调
        bllFailed(rspMsg);
    }
    
}

@end
