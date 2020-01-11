//
//  CommunityRecordModel.h
//  X-Wallet
//
//  Created by mac on 2019/12/4.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseModel.h"
#import "BaseLanguageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CommunityRecordModel : BaseModel

@property (nonatomic, copy) NSString *dy_id;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSDictionary *user;
@property (nonatomic, copy) NSString *contract_id;
@property (nonatomic, copy) NSString *level;
@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *after;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *contract_rate;
@property (nonatomic, copy) NSString *memo;
@property (nonatomic, copy) NSString *currency_id;
@property (nonatomic, copy) NSDictionary *currencies;
@property (nonatomic, copy) NSString *updated_at;
@property (nonatomic, copy) NSString *dui;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) BaseLanguageModel *memo_new;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *before;

@end

NS_ASSUME_NONNULL_END
