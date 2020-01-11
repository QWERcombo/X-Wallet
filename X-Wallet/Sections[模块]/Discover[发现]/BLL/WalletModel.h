//
//  WalletModel.h
//  X-Wallet
//
//  Created by mac on 2019/12/2.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WalletModel : BaseModel

@property (nonatomic, copy) NSString *change_balance;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *lock_guilong;
@property (nonatomic, copy) NSString *address1;
@property (nonatomic, copy) NSString *currency_type;
@property (nonatomic, copy) NSString *put_balance;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *lock_balance;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *llv_balance;
@property (nonatomic, copy) NSString *currency_id;
@property (nonatomic, copy) NSString *old_balance;
@property (nonatomic, copy) NSString *is_new;
@property (nonatomic, copy) NSString *push_service;
@property (nonatomic, copy) NSString *currency_name;
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *equal_balance;
@property (nonatomic, copy) NSDictionary *currency;

@end

NS_ASSUME_NONNULL_END
