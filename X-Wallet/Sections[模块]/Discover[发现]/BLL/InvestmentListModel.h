//
//  InvestmentListModel.h
//  X-Wallet
//
//  Created by 赵越 on 2019/12/1.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseModel.h"
#import "BaseLanguageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface InvestmentListModel : BaseModel

@property (nonatomic, copy) NSString *inv_id;
@property (nonatomic, copy) NSString *break_rate;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *is_vip;
@property (nonatomic, copy) NSString *number_day;
@property (nonatomic, copy) NSString *max_all;
@property (nonatomic, copy) NSString *max_investment;
@property (nonatomic, copy) NSString *day;
@property (nonatomic, copy) NSString *min_all;
@property (nonatomic, copy) NSString *income;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *rate_min;
@property (nonatomic, copy) NSString *status_zh;
@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSDictionary *name_new;
@property (nonatomic, copy) NSString *contents;
@property (nonatomic, copy) NSString *rate_max;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, strong) BaseLanguageModel *status_new;

@end

NS_ASSUME_NONNULL_END
