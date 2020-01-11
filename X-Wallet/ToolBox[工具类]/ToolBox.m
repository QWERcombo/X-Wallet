//
//  ToolBox.m
//  DDLife
//
//  Created by 赵越 on 2019/11/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "ToolBox.h"

@implementation ToolBox

+ (PromptUtils *)promptUtils
{
    return [PromptUtils sharedDDPromptUtils];
}

+ (AlertUtils *)alertUtils
{
    return [AlertUtils sharedDDAlertUtils];
}

+ (ImageUtils *)imageUtils
{
    return [ImageUtils sharedDDImageUtils];
}

+ (DeviceUtils *)deviceUtils
{
    return [DeviceUtils sharedDDDeviceUtils];
}

+ (DateUtils *)dateUtils
{
    return [DateUtils sharedDDDateUtils];
}

+ (DataUtils *)dataUtils
{
    return [DataUtils sharedDDDataUtils];
}




@end
