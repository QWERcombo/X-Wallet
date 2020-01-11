//
//  UIImage+Extension.h
//  shengMeiShangCheng
//
//  Created by 河南盛美 on 15/10/16.
//  Copyright (c) 2015年 河南盛美. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^GIFimageBlock)(UIImage *GIFImage);
@interface UIImage (Extension)
/**
 *  绘制一个矩形
 *
 *  @param color 矩形的颜色
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 *  生成一个二维码
 *
 *  @param string 字符串
 */
+ (CIImage *)creatCodeImageString:(NSString *)string;

/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 *
 *  @return 生成高清的UIImage
 */
+ (UIImage *)creatNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size;


+ (UIImage *)getimageWithColor:(UIColor *)color;

/** 根据本地GIF图片名 获得GIF image对象 */
+ (UIImage *)imageWithGIFNamed:(NSString *)name;

/** 根据一个GIF图片的data数据 获得GIF image对象 */
+ (UIImage *)imageWithGIFData:(NSData *)data;

/** 根据一个GIF图片的URL 获得GIF image对象 */
+ (void)imageWithGIFUrl:(NSString *)url and:(GIFimageBlock)gifImageBlock;
@end
