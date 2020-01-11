//
//  InvestmentDetailVC.h
//  X-Wallet
//
//  Created by mac on 2019/11/28.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface InvestmentDetailVC : BaseTableViewController

/** id */
@property (nonatomic, copy) NSString *inv_id;
@property (nonatomic, assign) BOOL isVip;
@end

NS_ASSUME_NONNULL_END
