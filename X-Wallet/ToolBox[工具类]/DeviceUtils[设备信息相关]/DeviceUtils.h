//
//  DDDeviceUtils.h
//  DDLife
//
//  Created by 赵越 on 2019/11/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 设备信息相关类
 */

typedef void (^onCameraUsable)(void);
typedef void (^onAlbumUsable)(void);

@interface DeviceUtils : NSObject


/**
 初始化单例
 
 @return 单例对象
 */
+ (DeviceUtils *)sharedDDDeviceUtils;


/**
 获取版本号
 */
- (NSString *)app_Version;

/**
 获取UUID
 */
- (NSString *)getDeviceUUID;

/**
 获取相机权限
*/
- (void)userCamera:(onCameraUsable)onCameraUsable;

/**
 获取相册权限
 */
- (void)userAlbum:(onAlbumUsable)onAlbumUsable;


@end

NS_ASSUME_NONNULL_END
