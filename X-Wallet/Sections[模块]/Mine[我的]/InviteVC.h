//
//  InviteVC.h
//  X-Wallet
//
//  Created by 赵越 on 2019/11/26.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface InviteVC : BaseViewController

@property (nonatomic, strong) NSString *invitation_code;

@property (nonatomic, strong) NSString *invite_url;

@property (nonatomic, strong) NSString *area_code;

@property (nonatomic, strong) NSString *hidden_phone;


@end

NS_ASSUME_NONNULL_END
