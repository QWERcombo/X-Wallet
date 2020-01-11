//
//  ShopModel.m
//  X-Wallet
//
//  Created by 赵越 on 2019/12/1.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "ShopModel.h"

@implementation ShopModel

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"description":@"shop_description",@"shop_id":@"id"}];
}

@end
