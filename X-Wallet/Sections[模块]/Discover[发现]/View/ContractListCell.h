//
//  ContractListCell.h
//  X-Wallet
//
//  Created by mac on 2019/11/28.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ContractListCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *topLeft;
@property (weak, nonatomic) IBOutlet UILabel *midLeft;
@property (weak, nonatomic) IBOutlet UILabel *midRight1;
@property (weak, nonatomic) IBOutlet UILabel *botRight;
@property (weak, nonatomic) IBOutlet UILabel *botLeft;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIView *showView;


@end

NS_ASSUME_NONNULL_END
