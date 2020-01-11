//
//  ToolBox.h
//  DDLife
//
//  Created by 赵越 on 2019/11/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PromptUtils.h"
#import "AlertUtils.h"
#import "ImageUtils.h"
#import "DeviceUtils.h"
#import "DateUtils.h"
#import "DataUtils.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToolBox : NSObject


+ (PromptUtils *)promptUtils;

+ (AlertUtils *)alertUtils;

+ (ImageUtils *)imageUtils;

+ (DeviceUtils *)deviceUtils;

+ (DateUtils *)dateUtils;

+ (DataUtils *)dataUtils;




@end

NS_ASSUME_NONNULL_END
