//
//  AssetBLL.m
//  X-Wallet
//
//  Created by mac on 2019/11/22.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "AssetBLL.h"

@implementation AssetBLL

+ (AssetBLL *)sharedAssetBLL {
    
    static AssetBLL *assetBLL = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        assetBLL = [[self alloc] init];
    });
    
    return assetBLL;
}

@end
