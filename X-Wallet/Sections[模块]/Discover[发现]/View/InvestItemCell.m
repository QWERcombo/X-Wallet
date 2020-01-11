//
//  InvestItemCell.m
//  X-Wallet
//
//  Created by mac on 2019/12/4.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "InvestItemCell.h"

@implementation InvestItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.showTitle.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)initCell:(UITableView *)tableView cellName:(NSString *)cellName dataObjc:(id)dataObjc {
    
    InvestItemCell *cell = [super initCell:tableView cellName:cellName dataObjc:dataObjc];
    
    
    return cell;
}
@end
