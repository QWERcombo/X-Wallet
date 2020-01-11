//
//  UserData.m
//  DDLife
//
//  Created by 赵越 on 2019/11/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "UserData.h"

@implementation UserModel

@end

NSString *const user_info_name = @"/user_info";
@implementation UserData {
    UserModel *_userInfo;
    NSString *_showMode;
}

+ (instancetype)share {
    static dispatch_once_t onceToken;
    static UserData *instance;
    dispatch_once(&onceToken, ^{
        instance = [[UserData alloc] init];
    });
    
    return instance;
}

#pragma mark --- user info(个人信息)
- (void)setCurrentUser:(UserModel *)userInfo {
    _userInfo = userInfo;
    if (userInfo == nil) {
    }else {
        NSData *data = [userInfo toJSONData];
        [data writeToFile:[self path] atomically:YES];
    }
}
- (UserModel *)currentUser {
    if (!_userInfo) {
        NSData *data = [NSData dataWithContentsOfFile:[self path] options:NSDataReadingMappedIfSafe error:nil];
        if (!data) {
            return nil;
        }else {
            _userInfo = [[UserModel alloc] initWithData:data error:nil];
        }
    }
    return _userInfo;
}

- (void)saveUserInfo {
    NSData *data = [self.currentUser toJSONData];
    [data writeToFile:[self path] atomically:YES];
}
- (NSString *)path {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingString:user_info_name];
}

- (void)setShowMode:(NSString *)showMode {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:showMode forKey:@"showMode"];
    [userDefaults synchronize];
}
- (NSString *)showMode {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"showMode"];
}

- (NSString *)showModeText {
    if ([self.showMode isEqualToString:@"Day"]) {
        return AppLanguageStringWithKey(@"日间模式");
    } else if ([self.showMode isEqualToString:@"Night"]) {
        return AppLanguageStringWithKey(@"夜间模式");
    } else if ([self.showMode isEqualToString:@"Christmas"]) {
        return AppLanguageStringWithKey(@"圣诞模式");
    } else if ([self.showMode isEqualToString:@"NewYear"]) {
        return AppLanguageStringWithKey(@"新年模式");
    }
    else {
        return @"";
    }
}


+ (BOOL)saveToken:(NSString *)token {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:token forKey:@"user_token"];
    return [userDefaults synchronize];
}

+ (NSString *)getToken {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"user_token"];
}

+ (BOOL)savePhone:(NSString *)phone {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:phone forKey:@"user_phone"];
    return [userDefaults synchronize];
}

+ (NSString *)getPhone {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
   return [userDefaults objectForKey:@"user_phone"];
}

+ (BOOL)removeTokenAndPhone {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"user_token"];
    [userDefaults removeObjectForKey:@"user_phone"];
    return [userDefaults synchronize];
}

@end
