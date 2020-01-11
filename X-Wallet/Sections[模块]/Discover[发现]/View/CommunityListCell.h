//
//  CommunityListCell.h
//  X-Wallet
//
//  Created by 赵越 on 2019/11/27.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommunityListCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *showImg;
@property (weak, nonatomic) IBOutlet UILabel *showLeft;
@property (weak, nonatomic) IBOutlet UILabel *showRight;

@end

NS_ASSUME_NONNULL_END
