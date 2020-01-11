//
//  NetWork.m
//  DDLife
//
//  Created by 赵越 on 2019/11/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "NetWork.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "UserData.h"
#import "NSData+XWCore.h"

NSString * const kXWalletBaseInterfaceUrl = @"http://api.xwallet.vip/api/";

NSString * const kWXNetWorkResponsePath = @"data";

@implementation NetWork

+ (NetWork *)sharedSelf {
    
    static NetWork *network = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        network = [[self alloc] init];
//        network.taskArray = [NSMutableArray array];
    });
    
    return network;
    
}

+ (AFHTTPSessionManager *)sharedNetwork{
    
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        
        manager = [AFHTTPSessionManager manager];
        
        AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
        [serializer setRemovesKeysWithNullValues:YES];
        serializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",@"image/jpeg",@"image/png",@"application/octet-stream", @"text/json", @"text/javascript", nil];
        manager.responseSerializer = serializer;
        
        //JSON请求
        AFJSONRequestSerializer *request = [AFJSONRequestSerializer serializer];   manager.requestSerializer = request;
        
//        [manager.requestSerializer setValue:NETWORK_HEADER_CONTET_TYPE forHTTPHeaderField:@"Content-Type"];
    });
    
    NSString *token = [UserData getToken];
    if (token.length) {
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    }

    return manager;
}

+ (void)dataTaskWithPath:(NSString *)path requestMethod:(NetWorkMethod)requestMethod version:(NSInteger)version parameters:(NSDictionary * _Nullable)params mapModelClass:(Class  _Nullable __unsafe_unretained)mapModelClass responsePath:(NSString * _Nullable)responsePath completionHandler:(void (^ _Nonnull)(id _Nullable, NSError * _Nonnull))completionHandler {
    
    NSString *urlString = nil;
       if (version) {
            urlString =[NSString stringWithFormat:@"%@v%zd/%@",kXWalletBaseInterfaceUrl,version,path];
       }
       else {
           urlString = [NSString stringWithFormat:@"%@%@",kXWalletBaseInterfaceUrl,path];
       }
    
    NSString *methodString = @"";
    switch (requestMethod) {
        case NetWorkMethodGet:
            methodString = @"GET";
            break;
        case NetWorkMethodPost:
            methodString = @"POST";
            break;
        default:
            break;
    }
        
    AFHTTPSessionManager *manager = [self sharedNetwork];

    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:methodString URLString:urlString parameters:params error:nil];
    
    [request setTimeoutInterval:NETWORKING_TIMEOUT_SECONDS];
    NSLog(@"urlString----%@,\nparams-----%@,\nheaders:%@", urlString, params,manager.requestSerializer.HTTPRequestHeaders);
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSLog(@"responseObject----%@,\nerror----%@", responseObject,error);
        if (responseObject) {
            NSInteger code = [responseObject[@"code"] integerValue];
            
            
            if (code==200) {
                id responsePathObject = responseObject;
                if (responsePath.length) {
                    responsePathObject = [responseObject valueForKeyPath:responsePath];
                }
                if (mapModelClass) {
                    if (completionHandler) {
                        
                        id mapObject = responsePathObject;
                        if ([responsePathObject isKindOfClass:[NSDictionary class]]) {
                            mapObject = [[mapModelClass alloc] initWithDictionary:responsePathObject error:nil];
                        }
                        else if ([responsePathObject isKindOfClass:[NSArray class]]) {
                            mapObject = [mapModelClass arrayOfModelsFromDictionaries:responsePathObject error:nil];
                        }
                        completionHandler(mapObject,error);
                        
                    };
                }
                else {
                    if (completionHandler) {
                        completionHandler(responsePathObject,error);
                    };
                }
                
            }
            else {
                error = [NSError errorWithDomain:NSStringFromClass([self class]) code:code userInfo:@{NSLocalizedDescriptionKey:responseObject[@"message"]?:@""}];
                if (completionHandler) {
                    completionHandler(responseObject,error);
                }
            }
        }
        else {
            if (completionHandler) {
                completionHandler(nil,error);
            }
        }
        
    }];
    
    
    [dataTask resume];
    
}


+ (void)uploadImageWithImage:(UIImage *)image completionHandler:(void (^)(XWUploadedImageModel * _Nullable, NSError * _Nullable))completionHandler {
    NSInteger version = 1;
    NSString *path = @"auth/upload";
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%@",kXWalletBaseInterfaceUrl,version==0?@"":[NSString stringWithFormat:@"v%zd",version],path];
       
       NSString *methodString = @"POST";
           
       AFHTTPSessionManager *manager = [self sharedNetwork];

       NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:methodString URLString:urlString parameters:nil error:nil];
       
       [request setTimeoutInterval:NETWORKING_TIMEOUT_SECONDS];
       NSLog(@"urlString----%@,\nparams-----%@,\nheaders:%@", urlString, nil,manager.requestSerializer.HTTPRequestHeaders);
    
    [manager POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData = UIImageJPEGRepresentation(image, 0.6);
        [formData appendPartWithFileData:imageData name:@"img" fileName:[NSString stringWithFormat:@"%@.jpg",[imageData xw_md5String]] mimeType:@"image/jpeg"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code==200) {
            XWUploadedImageModel *model = [[XWUploadedImageModel alloc] initWithDictionary:responseObject[@"data"] error:nil];
            if (completionHandler) {
                completionHandler(model,nil);
            }
        }
        else {
            NSError *error = [NSError errorWithDomain:NSStringFromClass([self class]) code:code userInfo:@{NSLocalizedDescriptionKey:responseObject[@"message"]?:@""}];
            if (completionHandler) {
                completionHandler(responseObject,error);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completionHandler) {
            completionHandler(nil,error);
        }
    }];
}

+ (void)dataTaskWithURLString:(NSString *)urlStr
                      version:(NSInteger)version
                requestMethod:(NSString *)requestMethod
                   parameters:(NSDictionary *)params
            completionHandler:(void (^)(NSURLResponse * _Nonnull response, id  _Nullable responseObject, URLResponseStatusEnum error))completionHandler {
    
    AFHTTPSessionManager *manager = [self sharedNetwork];
    
    //设置接口版本号
    [manager.requestSerializer setValue:[UserData getToken] forHTTPHeaderField:@"Authorization"];
    
    //完整请求url
    NSString *requestFullUrl = [NSString stringWithFormat:@"%@%@/%@", kBaseUrl,version==0?@"":[NSString stringWithFormat:@"v%zd",version],urlStr];
    
    
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:requestMethod URLString:requestFullUrl parameters:params error:nil];
    
    [request setTimeoutInterval:NETWORKING_TIMEOUT_SECONDS];
    NSLog(@"----%@", requestFullUrl);
    
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        URLResponseStatusEnum status = [self responseStatusWithError:error];
        
        if (responseObject != nil) {
            
            NSError *parseError = nil;
            
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:&parseError];
            
            NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            NSLog(@"%@", jsonStr);
        }
        
        if (error.code != NSURLErrorCancelled) {
            
            //校验网络请求返回的数据
            if (status == URLResponseStatusSuccess) {
                completionHandler?completionHandler(response,responseObject,status):nil;
                
            }else{
                
                completionHandler?completionHandler(response,responseObject,status):nil;
            }
        }
        
        
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            //获取http code
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            
            if (httpResponse.statusCode == 0) {
                
            }
        }
        
        
    }];
    
    
    [dataTask resume];
}



#pragma mark - private methods
+ (URLResponseStatusEnum)responseStatusWithError:(NSError *)error
{
    if (error) {
        URLResponseStatusEnum result = URLResponseStatusErrorNoNetwork;
        
        // 除了超时以外，所有错误都当成是无网络
        if (error.code == NSURLErrorTimedOut) {
            
            result = URLResponseStatusErrorTimeout;
        }
        
        return result;
        
    } else {
        
        return URLResponseStatusSuccess;
    }
}


@end
