//
//  QuotationListCell.m
//  X-Wallet
//
//  Created by 赵越 on 2019/11/25.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "QuotationListCell.h"
#import "QuotationModel.h"

@implementation QuotationListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.leftUp.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.midUp.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
}


+ (instancetype)initCell:(UITableView *)tableView cellName:(NSString *)cellName dataObjc:(id)dataObjc {
    
    QuotationListCell *cell = [super initCell:tableView cellName:cellName dataObjc:dataObjc];
    
    QuotationListModel *model = (QuotationListModel *)dataObjc;
    [cell.showImg sd_setImageWithURL:[NSURL URLWithString:model.logo]];
    cell.leftUp.text = model.platform;
    cell.midUp.text = [NSString stringWithFormat:@"$%@", model.usdt_price];
    cell.priceLab.text = [NSString stringWithFormat:@"%@%%", model.upanddown];
    
    if (model.upanddown.floatValue<0) {
        cell.priceLab.backgroundColor = kQuoGreenColor;
        cell.priceLab.text = [NSString stringWithFormat:@"%@%%", model.upanddown];
    } else {
        cell.priceLab.backgroundColor = kQuoRedColor;
        cell.priceLab.text = [NSString stringWithFormat:@"+%@%%", model.upanddown];
    }
    
    return cell;
}

+ (CGFloat)tableViewHeight {
    return 60;
}


@end
