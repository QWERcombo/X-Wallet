//
//  PhotoAlertController.h
//  HealthAndFitness
//
//  Created by 赵越 on 2019/4/18.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ReturnPickerImage)(UIImage *pickerImage);

@interface PhotoAlertController : UIAlertController

@property (nonatomic, assign) BOOL isAllowEdit;

@property (nonatomic, copy) ReturnPickerImage pickerImageBlock;

+(instancetype)initPhotoAlertControllerOnRebackImageBlock:(ReturnPickerImage)pickerImageBlock andRootViewController:(UIViewController *)rootViewController target:(UIView *)target;


@end

NS_ASSUME_NONNULL_END
