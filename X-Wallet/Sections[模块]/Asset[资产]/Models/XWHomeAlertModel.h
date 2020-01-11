//
//  XWHomeAlertModel.h
//  X-Wallet
//
//  Created by 夏之祥 on 2019/12/4.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseModel.h"

#import "BaseLanguageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface XWHomeAlertModel : BaseModel

@property (nonatomic, strong) NSString *msg1;

@property (nonatomic, strong) NSString *msg2;

@property (nonatomic, assign) double number;

@property (nonatomic, strong) BaseLanguageModel *msg1_new;

@property (nonatomic, strong) BaseLanguageModel *msg2_new;

@end

NS_ASSUME_NONNULL_END
