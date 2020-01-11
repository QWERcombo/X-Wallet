//
//  UILabel+AttributedText.m
//  DDLife
//
//  Created by 赵越 on 2019/11/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "UILabel+AttributedText.h"

@implementation UILabel (AttributedText)


+ (NSMutableAttributedString *)getAttributedStringWithFullText:(NSString *)fullText
                                                   replaceText:(NSString *)replaceText
                                                     textColor:(UIColor *)color
                                                      textFont:(UIFont *)font {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:fullText];
    
    NSRange replaceRange = [fullText rangeOfString:replaceText];
    
    if (font) {
        
        [attributedString addAttribute:NSFontAttributeName value:font range:replaceRange];
    }
    
    if (color) {
        
        [attributedString addAttribute:NSForegroundColorAttributeName value:color range:replaceRange];
    }
    
    return attributedString;
}

@end
