//
//  BaseLanguageModel.h
//  X-Wallet
//
//  Created by 夏之祥 on 2019/12/3.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseLanguageModel : BaseModel

@property (nonatomic, strong) NSString *zh;

@property (nonatomic, strong) NSString *en;

@property (nonatomic, strong) NSString *jp;

@property (nonatomic, strong) NSString *th;

@property (nonatomic, strong) NSString *ina;

@property (nonatomic, strong) NSString *kor;

@property (nonatomic, strong, readonly) NSString *info;

@end

NS_ASSUME_NONNULL_END
