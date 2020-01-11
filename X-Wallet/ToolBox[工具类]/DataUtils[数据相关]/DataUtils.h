//
//  DDDataUtils.h
//  DDLife
//
//  Created by 赵越 on 2019/11/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 数据操作相关
 */
@interface DataUtils : NSObject
/**
 初始化单例
 
 @return 单例对象
 */
+ (DataUtils *)sharedDDDataUtils;

/**
 *  检测str是否有值
 *
 *  @param str 字符串
 *
 *  @return 有值，没有值
 */
- (BOOL)isHasValue:(id)str;


/**
 清除缓存
 */
- (void)clearCache;


- (NSString *)getVersionStr;
@end

NS_ASSUME_NONNULL_END
