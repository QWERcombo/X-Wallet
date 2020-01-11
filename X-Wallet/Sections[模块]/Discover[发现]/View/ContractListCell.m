//
//  ContractListCell.m
//  X-Wallet
//
//  Created by mac on 2019/11/28.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "ContractListCell.h"
#import "ContractModel.h"

@implementation ContractListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.showView.backgroundColorPicker = IXColorPickerWithRGB(kWhiteR,kMineShowN,kWhiteR,kWhiteR);
    self.topLeft.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.midLeft.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.midRight1.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.botLeft.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.botRight.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)initCell:(UITableView *)tableView cellName:(NSString *)cellName dataObjc:(id)dataObjc {
    
    ContractListCell *cell = [super initCell:tableView cellName:cellName dataObjc:dataObjc];
    
    ContractModel *model = (ContractModel *)dataObjc;
    cell.topLeft.text = model.name_new.info;
    [cell.cancelBtn setTitle:model.status_new.info forState:UIControlStateNormal];
    cell.midLeft.text = [NSString stringWithFormat:@"%.4f%@($%@)",model.contracts_bill.floatValue,model.currency[@"name"],model.contracts_number];
    cell.midRight1.text = [NSString stringWithFormat:@"≈$%.4f", model.income_doll.floatValue];
    cell.botLeft.text = model.created_at;
    cell.botRight.text = model.end_time;
    
    return cell;
}

+ (CGFloat)tableViewHeight {
    return 190;
}

@end
