//
//  MyOrderListCell.h
//  X-Wallet
//
//  Created by 赵越 on 2019/11/26.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyOrderListCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *showImg;
@property (weak, nonatomic) IBOutlet UILabel *showTitle;
@property (weak, nonatomic) IBOutlet UILabel *showStatus;
@property (weak, nonatomic) IBOutlet UILabel *showPrice;
@property (weak, nonatomic) IBOutlet UILabel *showCount;
@property (weak, nonatomic) IBOutlet UIButton *borderBtn;
@property (weak, nonatomic) IBOutlet UIButton *fillBtn;
@property (weak, nonatomic) IBOutlet UILabel *showInfo;
@property (weak, nonatomic) IBOutlet UIView *showView;

@end

NS_ASSUME_NONNULL_END
