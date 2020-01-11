//
//  TeamVC.h
//  X-Wallet
//
//  Created by mac on 2019/11/25.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseViewController.h"

@class XWTeamModel;

NS_ASSUME_NONNULL_BEGIN

@interface TeamVC : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, assign) NSInteger totalNumber;

@property (nonatomic, assign) NSInteger validNumber;

@property (nonatomic, strong) NSArray *listArray;

@end

NS_ASSUME_NONNULL_END
