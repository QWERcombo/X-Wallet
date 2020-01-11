//
//  DiscoverBLL.m
//  X-Wallet
//
//  Created by mac on 2019/11/22.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "DiscoverBLL.h"

@implementation DiscoverBLL

+ (DiscoverBLL *)sharedDiscoverBLL {
    
    static DiscoverBLL *loginBLL = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        loginBLL = [[self alloc] init];
    });
    
    return loginBLL;
    
}

@end
