//
//  XWUserModel.h
//  X-Wallet
//
//  Created by 夏之祥 on 2019/11/30.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XWUserModel : BaseModel

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, strong) NSString *nickname;

@property (nonatomic, assign) NSInteger is_show;

@property (nonatomic, assign) float count_yeji;

@property (nonatomic, strong) NSString *avatar;

@property (nonatomic, strong) NSString *level_name;

@property (nonatomic, assign) NSInteger user_level;

@property (nonatomic, strong) NSString *phone;

@property (nonatomic, assign) double team_money;

@property (nonatomic, assign) double team_user_money;

@property (nonatomic, assign) NSInteger is_valid;

@property (nonatomic, strong) NSString *invitation_code;

@property (nonatomic, strong) NSString *invite_url;

@property (nonatomic, strong) NSString *area_code;

@property (nonatomic, strong) NSString *hidden_phone;

@end

NS_ASSUME_NONNULL_END
