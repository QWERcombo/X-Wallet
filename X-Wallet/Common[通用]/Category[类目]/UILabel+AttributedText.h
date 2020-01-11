//
//  UILabel+AttributedText.h
//  DDLife
//
//  Created by 赵越 on 2019/11/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (AttributedText)

/**
 获取富文本

 @param fullText 完整text
 @param replaceText 需要替换的text
 @param color 替换的颜色
 @param font 替换的文字大小
 @return 富文本
 */
+ (NSMutableAttributedString *)getAttributedStringWithFullText:(NSString *)fullText
                                                   replaceText:(NSString *)replaceText
                                                     textColor:(UIColor *)color
                                                      textFont:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
