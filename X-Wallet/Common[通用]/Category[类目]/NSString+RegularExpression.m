//
//  NSString+RegularExpression.m
//  DDLife
//
//  Created by 赵越 on 2019/11/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "NSString+RegularExpression.h"

@implementation NSString (RegularExpression)

- (BOOL)match:(NSString *)pattern {
    // 1.创建正则表达式
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    // 2.测试字符串
    NSArray *results = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    return results.count > 0;
}

- (BOOL)isMatchNricNumber {
    
    
    return [self match:@"^[0-9]\\d{6}[A-Za-z]$"];
}

- (BOOL)isMatchOnlyNumber {
    
    
    return [self match:@"^[0-9]*$"];
}

/*手机号码验证 MODIFIED BY HELENSONG*/
- (BOOL)isValidateMobile
{
    
    //    电信号段:133/153/180/181/189/177
    //    联通号段:130/131/132/155/156/185/186/145/176
    //    移动号段:134/135/136/137/138/139/150/151/152/157/158/159/182/183/184/187/188/147/178
    //    虚拟运营商:170
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9]|7[0-9])\\d{8}$";
    //    NSString * MOBILE = @" ^(13[0-9])|(147)|(145)|(17[0-9])|(15[^4,\\D])|(18[0-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    //     NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    //    NSString * CM = @" ^((13[4-9])|(147)|(15[0-2,7-9])|(17[0-9])|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    //     NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    //    NSString * CU =  @"^((13[0-2])|(145)|(15[5-6])|(17[0-9])|(18[5,6]))\\d{8}|(1709)\\d{7}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    //     NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    //    NSString * CT = @"^((133)|(153)|(177)|(173)|(18[0,1,9]))\\d{8}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    //    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    //    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    //    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:self] == YES))
        //        || ([regextestcm evaluateWithObject:self] == YES)
        //        || ([regextestct evaluateWithObject:self] == YES)
        //        || ([regextestcu evaluateWithObject:self] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (NSString *)getContractCancelFee:(NSString *)type {
    
    if ([type isEqualToString:@"7"]) {
        return @"5%";
    } else if ([type isEqualToString:@"15"]) {
        return @"10%";
    } else if ([type isEqualToString:@"30"]) {
        return @"15%";
    } else if ([type isEqualToString:@"45"]) {
        return @"30%";
    } else if ([type isEqualToString:@"90"]) {
        return @"20%";
    }
    
    return @"";
}

@end
