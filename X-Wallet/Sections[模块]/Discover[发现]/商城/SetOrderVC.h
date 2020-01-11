//
//  SetOrderVC.h
//  X-Wallet
//
//  Created by 赵越 on 2019/11/30.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetOrderVC : BaseViewController
@property (nonatomic, strong) NSDictionary *shopDic;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, copy) NSString *size;
@property (nonatomic, copy) NSDictionary *currency;
@end

NS_ASSUME_NONNULL_END
