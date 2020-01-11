//
//  XWEarnDetailModel.h
//  X-Wallet
//
//  Created by 夏之祥 on 2019/12/1.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseModel.h"

#import "BaseLanguageModel.h"
#import "XWHomeAssetCurrenciesModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XWEarnDetailModel : BaseModel

@property (nonatomic, strong) NSString *memo;

@property (nonatomic, strong) BaseLanguageModel *memo_new;

@property (nonatomic, strong) NSString *number;

@property (nonatomic, strong) NSString *updated_at;

@property (nonatomic, strong) NSString *value;

@property (nonatomic, strong) XWHomeAssetCurrenciesModel *currencies;

@end

NS_ASSUME_NONNULL_END
