//
//  CommunityModel.m
//  X-Wallet
//
//  Created by 赵越 on 2019/12/1.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "CommunityModel.h"

@implementation CurrentModel


@end

@implementation CommunityModel

- (NSString *)contract_my {
    return [NSString stringWithFormat:@"≈$%.4f", _contract_my.floatValue];
}
//- (NSString *)team_number {
//    return [NSString stringWithFormat:@"%@人", _team_number];
//}
- (NSString *)team_money {
    return [NSString stringWithFormat:@"≈$%.4f", _team_money.floatValue];
}
//- (NSString *)income_team {
//    return [NSString stringWithFormat:@"≈$%@", _income_team];
//}
//- (NSString *)income_my {
//    return [NSString stringWithFormat:@"≈$%@", _income_my];
//}
//- (NSString *)income_my_today {
//    return [NSString stringWithFormat:@"≈$%.4f", _income_my_today.floatValue];
//}
//- (NSString *)income_team_today {
//    return [NSString stringWithFormat:@"≈$%.4f", _income_team_today.floatValue];
//}
//- (NSString *)income_my_xcn {
//    return [NSString stringWithFormat:@"=%.4f XCN", _income_my_xcn.floatValue];
//}
//- (NSString *)commission {
//    return [NSString stringWithFormat:@"%.4f", _commission.floatValue];
//}
//- (NSString *)commission_game {
//    return [NSString stringWithFormat:@"%.4f", _commission_game.floatValue];
//}
//- (NSString *)commission_goods {
//    return [NSString stringWithFormat:@"%.4f", _commission_goods.floatValue];
//}
//- (NSString *)daishu {
//    return [NSString stringWithFormat:@"%.4f", _daishu.floatValue];
//}
//- (NSString *)weight {
//    return [NSString stringWithFormat:@"%.4f", _weight.floatValue];
//}
//- (NSString *)sideways {
//    return [NSString stringWithFormat:@"%.4f", _sideways.floatValue];
//}

@end
