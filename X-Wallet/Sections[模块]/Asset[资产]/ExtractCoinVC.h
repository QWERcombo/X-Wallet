//
//  ExtractCoinVC.h
//  X-Wallet
//
//  Created by mac on 2019/11/25.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseTableViewController.h"
#import "XWHomeAssetModel.h"
NS_ASSUME_NONNULL_BEGIN

/** 提币 */
@interface ExtractCoinVC : BaseTableViewController

@property (nonatomic, strong) XWHomeAssetModel *model;

@end

NS_ASSUME_NONNULL_END
