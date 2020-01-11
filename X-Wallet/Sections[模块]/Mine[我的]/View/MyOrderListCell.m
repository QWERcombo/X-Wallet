//
//  MyOrderListCell.m
//  X-Wallet
//
//  Created by 赵越 on 2019/11/26.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "MyOrderListCell.h"

@implementation MyOrderListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.borderBtn.layer.cornerRadius = 12;
    self.borderBtn.layer.borderWidth = 1;
    self.borderBtn.layer.borderColor = kMainColor.CGColor;
    
    self.showView.backgroundColorPicker = IXColorPickerWithRGB(kLightGrayF5,0x1D263B,kLightGrayF5,kLightGrayF5);
    self.showTitle.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.showPrice.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.showCount.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)initCell:(UITableView *)tableView cellName:(NSString *)cellName dataObjc:(id)dataObjc {
    
    MyOrderListCell *cell = [super initCell:tableView cellName:cellName dataObjc:dataObjc];
    
    
    
    
    
    return cell;
}

+ (CGFloat)tableViewHeight {
    return 190;
}


@end
