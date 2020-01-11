//
//  NSString+RegularExpression.h
//  DDLife
//
//  Created by 赵越 on 2019/11/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (RegularExpression)

//验证登录账号
- (BOOL)isMatchNricNumber;

//验证输入的是纯数字
- (BOOL)isMatchOnlyNumber;

/*手机号码验证 MODIFIED BY HELENSONG*/
- (BOOL)isValidateMobile;

//获取违约金比例
+ (NSString *)getContractCancelFee:(NSString *)type;

@end

NS_ASSUME_NONNULL_END
