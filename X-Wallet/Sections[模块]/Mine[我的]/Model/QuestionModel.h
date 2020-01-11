//
//  QuestionModel.h
//  X-Wallet
//
//  Created by 赵越 on 2019/11/24.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QuestionModel : BaseModel

@property (nonatomic, assign) BOOL isDisplay;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *content;

@end



NS_ASSUME_NONNULL_END
