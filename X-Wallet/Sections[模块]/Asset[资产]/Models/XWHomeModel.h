//
//  XWHomeModel.h
//  X-Wallet
//
//  Created by 夏之祥 on 2019/11/30.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseModel.h"
//models
#import "XWHomeAssetModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol XWHomeAssetModel;

@interface XWHomeModel : BaseModel

@property (nonatomic, strong) NSString *doll;

@property (nonatomic, strong) NSArray<XWHomeAssetModel> *list;

@end

NS_ASSUME_NONNULL_END
