//
//  AssetListCell.h
//  X-Wallet
//
//  Created by mac on 2019/11/22.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface AssetListCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *showImg;
@property (weak, nonatomic) IBOutlet UILabel *showName;
@property (weak, nonatomic) IBOutlet UILabel *showPrice;
@property (weak, nonatomic) IBOutlet UILabel *showDoular;
@property (weak, nonatomic) IBOutlet UIView *showView;


@end

NS_ASSUME_NONNULL_END
