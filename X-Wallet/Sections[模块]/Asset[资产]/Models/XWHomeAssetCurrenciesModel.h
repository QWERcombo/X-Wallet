//
//  XWHomeAssetCurrenciesModel.h
//  X-Wallet
//
//  Created by 夏之祥 on 2019/11/30.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XWHomeAssetCurrenciesModel : BaseModel

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *type;

@property (nonatomic, assign) double usdt_price;

@property (nonatomic, strong) NSString *min_number;

@property (nonatomic, assign) double rate;

@property (nonatomic, strong) NSString *logo;

@end

NS_ASSUME_NONNULL_END
