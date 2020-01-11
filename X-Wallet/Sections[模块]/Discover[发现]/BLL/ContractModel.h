//
//  ContractModel.h
//  X-Wallet
//
//  Created by mac on 2019/12/3.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseModel.h"
#import "BaseLanguageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ContractModel : BaseModel

@property (nonatomic, copy) NSString *income_rate;
@property (nonatomic, copy) BaseLanguageModel *status_new;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *end_time;
@property (nonatomic, copy) NSString *is_all;
@property (nonatomic, copy) NSDictionary *currency;
@property (nonatomic, copy) NSString *contracts_bill;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *no;
@property (nonatomic, copy) NSString *income;
@property (nonatomic, copy) NSString *agencies_number;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *contract_id;
@property (nonatomic, copy) NSString *income_doll;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *contracts_number;
@property (nonatomic, copy) NSString *currency_id;
@property (nonatomic, copy) NSString *updated_at;
@property (nonatomic, copy) NSString *contract_day;
@property (nonatomic, copy) NSString *mill_id;
@property (nonatomic, copy) BaseLanguageModel *name_new;
@property (nonatomic, copy) NSString *status_zh;

@end

NS_ASSUME_NONNULL_END
