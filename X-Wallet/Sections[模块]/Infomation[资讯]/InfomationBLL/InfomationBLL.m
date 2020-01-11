//
//  InfomationBLL.m
//  X-Wallet
//
//  Created by mac on 2019/11/22.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "InfomationBLL.h"

@implementation InfomationBLL

+ (InfomationBLL *)sharedInfomationBLL {
    
    static InfomationBLL *loginBLL = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        loginBLL = [[self alloc] init];
    });
    
    return loginBLL;
    
}


@end
