//
//  UISet.h
//  DDLife
//
//  Created by 赵越 on 2019/11/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 用与定义基础控件某些显示状态的设置以便复用
 */
@interface UISet : NSObject


/**
 带圆角的View

 @param targetView View
 @param cornerRadius 半径
 */
+ (void)setNormalView:(UIView *)targetView
         cornerRadius:(CGFloat)cornerRadius;

/** 自定义圆角 */
+ (void)setCornerByRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii targetView:(UIView *)targetView viewBounds:(CGRect)bounds;

@end

NS_ASSUME_NONNULL_END
