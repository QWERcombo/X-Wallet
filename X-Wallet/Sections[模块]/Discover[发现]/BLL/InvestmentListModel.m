//
//  InvestmentListModel.m
//  X-Wallet
//
//  Created by 赵越 on 2019/12/1.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "InvestmentListModel.h"

@implementation InvestmentListModel
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"inv_id":@"id"}];
}
@end
