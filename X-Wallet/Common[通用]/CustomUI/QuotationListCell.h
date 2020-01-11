//
//  QuotationListCell.h
//  X-Wallet
//
//  Created by 赵越 on 2019/11/25.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface QuotationListCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *leftUp;
@property (weak, nonatomic) IBOutlet UILabel *leftDown;
@property (weak, nonatomic) IBOutlet UILabel *midUp;
@property (weak, nonatomic) IBOutlet UILabel *midDown;
@property (weak, nonatomic) IBOutlet UIImageView *showImg;

@end

NS_ASSUME_NONNULL_END
