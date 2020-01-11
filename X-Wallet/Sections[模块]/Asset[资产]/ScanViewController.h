//
//  ScanViewController.h
//  X-Wallet
//
//  Created by 夏之祥 on 2019/12/4.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScanViewController : UIViewController

@property (nonatomic, copy) void(^didScanResult)(ScanViewController *scanVC,NSString *result);

@end

NS_ASSUME_NONNULL_END
