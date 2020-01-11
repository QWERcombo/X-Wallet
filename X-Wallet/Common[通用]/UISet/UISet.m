//
//  UISet.m
//  DDLife
//
//  Created by 赵越 on 2019/11/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "UISet.h"

@implementation UISet

+ (void)setNormalView:(UIView *)targetView
         cornerRadius:(CGFloat)cornerRadius {
    
    targetView.layer.cornerRadius = cornerRadius;
    
    targetView.layer.masksToBounds = YES;
    
}

+ (void)setCornerByRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii targetView:(UIView *)targetView viewBounds:(CGRect)bounds {
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = targetView.bounds;
    maskLayer.path = maskPath.CGPath;
    
    targetView.layer.mask = maskLayer;
    
}

@end
