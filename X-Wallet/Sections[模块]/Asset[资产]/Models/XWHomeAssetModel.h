//
//  XWHomeAssetModel.h
//  X-Wallet
//
//  Created by 夏之祥 on 2019/11/30.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseModel.h"
#import "XWHomeAssetRecordModel.h"
#import "XWHomeAssetCurrenciesModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface XWHomeAssetModel : BaseModel

@property (nonatomic, assign) NSInteger currency_id;

@property (nonatomic, strong) NSString *logo;

@property (nonatomic, strong) NSString *currency_name;

@property (nonatomic, strong) NSString *change_balance;

@property (nonatomic, strong) NSString *doll_balance;

@property (nonatomic, assign) NSString *usdt_price;

@property (nonatomic, strong) NSString *address;

@property (nonatomic, strong) XWHomeAssetCurrenciesModel *currency;

@property (nonatomic, assign) NSInteger is_dui;

@property (nonatomic, assign) NSInteger is_transfer;

@property (nonatomic, assign) NSInteger is_recharge;

@property (nonatomic, assign) NSInteger is_withdraw;

@property (nonatomic, assign) NSInteger is_contract;

@end

NS_ASSUME_NONNULL_END
