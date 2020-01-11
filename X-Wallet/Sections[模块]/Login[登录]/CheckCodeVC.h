//
//  CheckCodeVC.h
//  X-Wallet
//
//  Created by mac on 2019/11/21.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, CodeType) {
    CodeType_Normal,
    CodeType_Pay
};

@interface CheckCodeVC : BaseTableViewController

@property (nonatomic, strong) NSString *countryStr;

@property (nonatomic, strong) NSString *codeStr;

@property (nonatomic, strong) NSString *accountStr;

@property (nonatomic, strong) NSString *passwordStr;

@property (nonatomic, strong) NSString *inviteStr;

@property (nonatomic, assign) CodeType type;

@property (nonatomic, strong) NSString *area_code;

@end

NS_ASSUME_NONNULL_END
