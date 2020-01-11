//
//  RegistVC.h
//  X-Wallet
//
//  Created by mac on 2019/11/21.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, RegistType) {
    RegistType_Phone,
    RegistType_Email
};

@interface RegistVC : BaseTableViewController

@property (nonatomic, assign) RegistType type;


@end

NS_ASSUME_NONNULL_END
