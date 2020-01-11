//
//  CommunityRecordListCell.h
//  X-Wallet
//
//  Created by mac on 2019/12/4.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommunityRecordListCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *desLab;


@end

NS_ASSUME_NONNULL_END
