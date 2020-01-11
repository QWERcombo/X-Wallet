//
//  UserData.h
//  DDLife
//
//  Created by 赵越 on 2019/11/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseLanguageModel.h"
NS_ASSUME_NONNULL_BEGIN

/**
 用于存储登录用户的数据
 */

@protocol UserModel;
@interface UserModel : BaseModel

@property (nonatomic, copy) NSString *is_block;
@property (nonatomic, copy) NSString *user_level;
@property (nonatomic, copy) NSString *invitation_code;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *login_count;
@property (nonatomic, copy) NSString *parent_id;
@property (nonatomic, copy) NSString *is_valid;
@property (nonatomic, copy) NSString *is_show;
@property (nonatomic, copy) NSString *team_money;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *area_code;
@property (nonatomic, copy) NSString *count_yeji;
@property (nonatomic, copy) NSString *team_user_money;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *consume;
@property (nonatomic, copy) NSString *level_name;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *invite_url;
//@property (nonatomic, copy) NSString *help_key;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *pay_password;
@property (nonatomic, copy) BaseLanguageModel *level_name_new;
@property (nonatomic, copy) NSString *agency_id;

@end

@interface UserData : BaseModel

@property (nonatomic, strong, nullable) UserModel *currentUser;
@property (nonatomic, copy) NSString *showMode;
@property (nonatomic, copy) NSString *showModeText;

///全局唯一单例类
+ (instancetype)share;
/// 储存当前用户信息
- (void)saveUserInfo;


+ (BOOL)saveToken:(NSString *)token;
+ (NSString *)getToken;
+ (BOOL)savePhone:(NSString *)phone;
+ (NSString *)getPhone;
+ (BOOL)removeTokenAndPhone;

@end

NS_ASSUME_NONNULL_END
