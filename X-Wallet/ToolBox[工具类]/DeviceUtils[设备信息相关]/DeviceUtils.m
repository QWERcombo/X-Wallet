//
//  DDDeviceUtils.m
//  DDLife
//
//  Created by 赵越 on 2019/11/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "DeviceUtils.h"
#import <Photos/Photos.h>
#import "AlertUtils.h"

@implementation DeviceUtils

+ (DeviceUtils *)sharedDDDeviceUtils
{
    
    static DeviceUtils *ddDeviceUtils;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        ddDeviceUtils = [[DeviceUtils alloc] init];
        
    });
    
    return ddDeviceUtils;
}

- (NSString *)app_Version{
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return app_Version;
}

- (void)userCamera:(onCameraUsable)onCameraUsable{
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        // 用户是否允许摄像头使用
        NSString * mediaType = AVMediaTypeVideo;
        AVAuthorizationStatus  authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        // 不允许弹出提示框
        if (authorizationStatus == AVAuthorizationStatusRestricted|| authorizationStatus == AVAuthorizationStatusDenied) {
            
            NSLog(@"提示框");
        }else{
            // 这里是摄像头可以使用的处理逻辑
            onCameraUsable();
        }
    } else {
        
        NSLog(@"硬件问题提示");
    }
}


- (void)userAlbum:(onAlbumUsable)onAlbumUsable {
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        
        if (status == PHAuthorizationStatusAuthorized) {
            // 这里是摄像头可以使用的处理逻辑
            onAlbumUsable();
            
        } else {
            
            NSLog(@"提示框");
            
        }
        
    }];
    
    
}


@end
