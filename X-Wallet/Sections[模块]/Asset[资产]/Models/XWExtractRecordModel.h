//
//  XWExtractRecordModel.h
//  X-Wallet
//
//  Created by 夏之祥 on 2019/12/1.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseModel.h"
#import "XWHomeAssetCurrenciesModel.h"
#import "BaseLanguageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XWExtractRecordModel : BaseModel

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, strong) NSString *real_number;

@property (nonatomic, strong) NSString *number;

@property (nonatomic, strong) XWHomeAssetCurrenciesModel *currency;

@property (nonatomic, strong) NSString *created_at;

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) BaseLanguageModel *status_new;

@property (nonatomic, strong) NSString *to_address;

@end

NS_ASSUME_NONNULL_END
