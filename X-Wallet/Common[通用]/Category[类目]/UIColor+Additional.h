//
//  UIColor+Additional.h
//  DDLife
//
//  Created by 赵越 on 2019/11/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Additional)

//16进制颜色转换
+ (UIColor *)colorWithHexString: (NSString *)color;

/// 黑暗模式调用颜色
/// @param lightColor 正常模式的颜色
/// @param darkColor 黑暗模式的颜色
+ (UIColor *)colorWithLight:(UIColor *)lightColor dark:(UIColor *)darkColor;

/// 黑暗模式中白色
+ (UIColor *)jyl_WhiteColor;

+ (UIColor *)barColror;

@end

NS_ASSUME_NONNULL_END
