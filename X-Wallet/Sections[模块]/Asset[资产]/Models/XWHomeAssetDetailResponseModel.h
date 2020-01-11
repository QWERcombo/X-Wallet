//
//  XWHomeAssetDetailResponseModel.h
//  X-Wallet
//
//  Created by 夏之祥 on 2019/11/30.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseModel.h"
//models
#import "XWHomeAssetModel.h"
#import "XWHomeAssetRecordModel.h"
#import "XWHomeAssetTypeModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol XWHomeAssetRecordModel,XWHomeAssetTypeModel;

@interface XWHomeAssetDetailResponseListModel : BaseModel

@property (nonatomic, strong) NSArray<XWHomeAssetRecordModel> *data;

@end

@interface XWHomeAssetDetailResponseModel : BaseModel

@property (nonatomic, strong) XWHomeAssetModel *wallet_info;

@property (nonatomic, strong) XWHomeAssetDetailResponseListModel *list;

@property (nonatomic, strong) NSArray<XWHomeAssetTypeModel> *show_list;

@end

NS_ASSUME_NONNULL_END
