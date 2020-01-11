//
//  QuotationModel.h
//  X-Wallet
//
//  Created by 赵越 on 2019/11/30.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol QuotationInfoModel;
@interface QuotationInfoModel : BaseModel

@property (nonatomic,copy) NSString *diff;
@property (nonatomic,copy) NSString *max_platform;
@property (nonatomic,copy) NSString *max_price;
@property (nonatomic,copy) NSString *min_platform;
@property (nonatomic,copy) NSString *min_price;

@end

@protocol QuotationListModel;
@interface QuotationListModel : BaseModel

@property (nonatomic,copy) NSString *count24;
@property (nonatomic,copy) NSString *desc;
@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *logo;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *platform;
@property (nonatomic,copy) NSString *rmb_price;
@property (nonatomic,copy) NSString *symbol;
@property (nonatomic,copy) NSString *upanddown;
@property (nonatomic,copy) NSString *usdt_price;

@end


@interface QuotationModel : BaseModel

@property (nonatomic,copy) NSArray<QuotationListModel> *list;
@property (nonatomic,copy) QuotationInfoModel *info;
@property (nonatomic,copy) NSString *name;

@end

NS_ASSUME_NONNULL_END
