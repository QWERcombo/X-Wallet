//
//  TeamListCell.h
//  X-Wallet
//
//  Created by mac on 2019/11/25.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface TeamListCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *showImg;
@property (weak, nonatomic) IBOutlet UILabel *showPhone;
@property (weak, nonatomic) IBOutlet UILabel *showAccount;
@property (weak, nonatomic) IBOutlet UIImageView *showLevel;
@property (weak, nonatomic) IBOutlet UILabel *showResult;
@property (weak, nonatomic) IBOutlet UILabel *showTime;
@property (weak, nonatomic) IBOutlet UIImageView *showType;


@end

NS_ASSUME_NONNULL_END
