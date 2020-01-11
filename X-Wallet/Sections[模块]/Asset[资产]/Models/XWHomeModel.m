//
//  XWHomeModel.m
//  X-Wallet
//
//  Created by 夏之祥 on 2019/11/30.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "XWHomeModel.h"

@implementation XWHomeModel


+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"USDT - ERC20": @"USDT_ERC20"}];
}

@end
