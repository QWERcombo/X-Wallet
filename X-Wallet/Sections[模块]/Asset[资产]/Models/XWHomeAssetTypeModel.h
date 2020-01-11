//
//  XWHomeAssetTypeModel.h
//  X-Wallet
//
//  Created by 夏之祥 on 2019/12/3.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseModel.h"
//models
#import "BaseLanguageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XWHomeAssetTypeModel : BaseModel

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) NSString *memeo;

@property (nonatomic, strong) BaseLanguageModel *memeo_new;

@end

NS_ASSUME_NONNULL_END
