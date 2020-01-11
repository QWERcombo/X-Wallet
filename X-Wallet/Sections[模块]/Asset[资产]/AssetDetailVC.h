//
//  AssetDetailVC.h
//  X-Wallet
//
//  Created by mac on 2019/11/25.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, AssetDetailType) {
    AssetDetailType_XCN,
    AssetDetailType_BTC
};

@interface AssetDetailVC : BaseViewController

@property (nonatomic, assign) AssetDetailType type;

@property (nonatomic, assign) NSInteger id;

@end

NS_ASSUME_NONNULL_END
