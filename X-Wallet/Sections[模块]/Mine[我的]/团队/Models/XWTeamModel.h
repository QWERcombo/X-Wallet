//
//  XWTeamModel.h
//  X-Wallet
//
//  Created by 夏之祥 on 2019/11/30.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseModel.h"
#import "XWTeamUserModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol XWTeamUserModel;

@interface XWTeamModel : BaseModel

@property (nonatomic, assign) NSInteger count_valid;

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, strong) NSArray<XWTeamUserModel> *data;

@end

NS_ASSUME_NONNULL_END
