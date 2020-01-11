//
//  CountryCodeVC.h
//  X-Wallet
//
//  Created by mac on 2019/11/21.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseViewController.h"

@class XWCountryModel;

NS_ASSUME_NONNULL_BEGIN

@interface CountryCodeVC : BaseViewController

@property (nonatomic, copy) void(^valueBlock)(XWCountryModel *value);
@property (nonatomic, assign) BOOL isHideCode;
@end

NS_ASSUME_NONNULL_END
