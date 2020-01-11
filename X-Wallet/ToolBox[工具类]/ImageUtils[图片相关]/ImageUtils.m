//
//  DDImageUtils.m
//  DDLife
//
//  Created by 赵越 on 2019/11/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "ImageUtils.h"

@implementation ImageUtils

+ (ImageUtils *)sharedDDImageUtils
{
    
    static ImageUtils *ddImageUtils;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        ddImageUtils = [[ImageUtils alloc] init];
        
    });
    
    return ddImageUtils;
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage*)gradualImageWithColor:(UIColor *)color secondColor:(UIColor *)secondColor rect:(CGRect)rect

{
    
    NSMutableArray *ar = [NSMutableArray array];
    [ar addObject:(id)color.CGColor];
    [ar addObject:(id)secondColor.CGColor];
    
    
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 1);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([secondColor CGColor]);
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    
    CGPoint start;
    
    CGPoint end;
    
    
    start = CGPointMake(0.0, rect.size.height);
    
    end = CGPointMake(rect.size.width, 0.0);
    
    
    CGContextDrawLinearGradient(context, gradient, start, end,kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGGradientRelease(gradient);
    
    CGContextRestoreGState(context);
    
    CGColorSpaceRelease(colorSpace);
    
    UIGraphicsEndImageContext();
    
    return image;
    
}


- (UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth toMaxFileSize:(NSInteger)maxFileSize{
    
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = (targetWidth / width) * height;
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0,0,targetWidth,  targetHeight)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.5f;
    NSData *imageData = UIImageJPEGRepresentation(newImage, compression);
    while ([imageData length] > maxFileSize && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(newImage, compression);
    }
    
    UIImage *compressedImage = [UIImage imageWithData:imageData];
    
    return compressedImage;
}


@end
