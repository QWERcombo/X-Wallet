//
//  LoginBLL.m
//  X-Wallet
//
//  Created by mac on 2019/11/21.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "LoginBLL.h"

@implementation LoginBLL

+ (LoginBLL *)sharedLoginBLL {
    
    static LoginBLL *loginBLL = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        loginBLL = [[self alloc] init];
    });
    
    return loginBLL;
}


@end
