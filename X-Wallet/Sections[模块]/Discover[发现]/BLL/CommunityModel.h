//
//  CommunityModel.h
//  X-Wallet
//
//  Created by 赵越 on 2019/12/1.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CurrentModel : BaseModel

@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *usdt_price;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *guilong_trans_money;
@property (nonatomic, copy) NSString *updated_at;
@property (nonatomic, copy) NSString *total_account;
@property (nonatomic, copy) NSString *min_number;
@property (nonatomic, copy) NSString *is_show;
@property (nonatomic, copy) NSString *rise_rate;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *contents;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *rmb_price;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *commission;
@property (nonatomic, copy) NSString *fee_account;
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *rate;
@property (nonatomic, copy) NSString *pt;
@property (nonatomic, copy) NSString *order;
@property (nonatomic, copy) NSString *contract_address;

@end

@interface CommunityModel : BaseModel

@property (nonatomic, copy) NSString *team_money;
@property (nonatomic, copy) NSString *income_team;
@property (nonatomic, copy) NSString *sideways;
@property (nonatomic, copy) NSString *contract_my;
@property (nonatomic, copy) NSString *team_number;
@property (nonatomic, copy) NSString *income_my_xcn;
@property (nonatomic, copy) NSString *weight;
@property (nonatomic, copy) NSString *income_my_today;
@property (nonatomic, copy) NSString *income_my;
@property (nonatomic, copy) NSString *daishu;
@property (nonatomic, copy) NSString *commission_game;
@property (nonatomic, copy) NSString *commission_goods;
@property (nonatomic, copy) NSString *commission;
@property (nonatomic, copy) NSString *income_team_today;
@property (nonatomic, strong) CurrentModel *currency;

@end

NS_ASSUME_NONNULL_END
