//
//  UIButton+Additional.h
//  DDLife
//
//  Created by 赵越 on 2019/11/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DDButtonEdgeInsetsStyle) {
    DDButtonEdgeInsetsStyleTop, // image在上，label在下
    DDButtonEdgeInsetsStyleLeft, // image在左，label在右
    DDButtonEdgeInsetsStyleBottom, // image在下，label在上
    DDButtonEdgeInsetsStyleRight // image在右，label在左
};

@interface UIButton (Additional)

/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(DDButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;



@end

NS_ASSUME_NONNULL_END
