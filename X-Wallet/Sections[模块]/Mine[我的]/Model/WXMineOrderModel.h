//
//  WXMineOrderModel.h
//  X-Wallet
//
//  Created by 夏之祥 on 2019/12/1.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseModel.h"
#import "WXMineOrderProductModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WXMineOrderModel : BaseModel

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) NSInteger goods_number;

@property (nonatomic, strong) NSString *currency_name;

@property (nonatomic, strong) NSString *total_amount;

@property (nonatomic, strong) WXMineOrderProductModel *product;

@end

NS_ASSUME_NONNULL_END
