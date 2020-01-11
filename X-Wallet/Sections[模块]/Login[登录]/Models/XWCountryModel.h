//
//  XWCountryModel.h
//  X-Wallet
//
//  Created by 夏之祥 on 2019/11/30.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XWCountryModel : BaseModel

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, strong) NSString *tel;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *en;

@property (nonatomic, assign) NSInteger sort;

@property (nonatomic, strong) NSString *created_at;

@property (nonatomic, strong) NSString *updated_at;

@end

NS_ASSUME_NONNULL_END
