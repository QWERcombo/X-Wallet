//
//  XWTeamUserModel.h
//  X-Wallet
//
//  Created by 夏之祥 on 2019/12/1.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseModel.h"
#import "XWUserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface XWTeamUserModel : BaseModel

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, strong) XWUserModel *user;

@property (nonatomic, strong) NSString *updated_at;

@end

NS_ASSUME_NONNULL_END
