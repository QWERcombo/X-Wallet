//
//  DDAlertUtils.m
//  DDLife
//
//  Created by 赵越 on 2019/11/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "AlertUtils.h"

@implementation AlertUtils

+ (AlertUtils *)sharedDDAlertUtils
{
    
    static AlertUtils *ddAlertUtils;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        ddAlertUtils = [[AlertUtils alloc] init];
        
    });
    
    return ddAlertUtils;
}




@end
