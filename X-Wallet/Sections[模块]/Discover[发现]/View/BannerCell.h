//
//  BannerCell.h
//  X-Wallet
//
//  Created by 赵越 on 2019/11/30.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCCycleScrollView.h"

NS_ASSUME_NONNULL_BEGIN

@class DCCycleScrollView;
@interface BannerCell : UICollectionViewCell<DCCycleScrollViewDelegate>

@property (nonatomic, strong) DCCycleScrollView *banner;
@property (nonatomic, copy) NSArray *imageArr;

@end

NS_ASSUME_NONNULL_END
