//
//  DDDateUtils.h
//  DDLife
//
//  Created by 赵越 on 2019/11/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 时间格式化类
 */
@interface DateUtils : NSObject

/**
 初始化单例
 
 @return 单例对象
 */
+ (DateUtils *)sharedDDDateUtils;

//yyyy-MM-dd HH:mm:ss   HH:mm
- (NSString *)getHourMinFromDateString:(NSString *)dateStr;


@end

NS_ASSUME_NONNULL_END
